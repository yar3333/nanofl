package nanofl.ide.navigator;

import js.lib.Promise;
import stdlib.Std;
import stdlib.Debug;
import datatools.ArrayRO;
import nanofl.engine.elements.Instance;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.Document;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import nanofl.ide.undo.states.NavigatorState;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Navigator extends InjectContainer
{
	@inject var app : Application;
	@inject var view : View;
	@inject var preferences : Preferences;
	
	var document : Document;
	
	public var editPath(get, never) : ArrayRO<PathItem>; function get_editPath() return _editPath;
	var _editPath(default, null) : Array<PathItem>;
	
	public var pathItem(get, never) : PathItem;
	@:noCompletion function get_pathItem() : PathItem return editPath[editPath.length - 1];
	
	@:noapi
	public function new(document:Document) : Void
	{
		super();
		
		this.document = document;
		this._editPath = [];
	}
	
	public function navigateDown(instance:Instance) : Void
	{
        document.undoQueue.commitTransaction();
		_editPath.push(new PathItem(instance));
		update(false);
	}
	
	public function navigateTo(editPath:Array<PathItem>, isCenterView=true, commitBeforeChange=true) : Void
	{
        if (commitBeforeChange) document.undoQueue.commitTransaction();
		this._editPath = editPath;
		update(isCenterView);
	}
	
	public function setLayerIndex(index:Int) : Void
	{
		pathItem.setLayerIndex(index);
        view.movie.timeline.fixActiveLayer();
	}
	
	@:profile
	public function setFrameIndex(index:Int, ?invalidater:Invalidater, commitBeforeChange=true) : Promise<{}>
	{
		final totalFrames = pathItem.getTotalFrames();
		
		if (totalFrames > 0)
		{
			index = Std.max(index, 0);
			index = Std.min(index, totalFrames - 1);
		}
		else
		{
			index = 0;
		}
		
		if (pathItem.frameIndex == index) return Promise.resolve(null);
		
		if (commitBeforeChange) document.undoQueue.commitTransaction();
		
		pathItem.setFrameIndex(index);

        var r = Promise.resolve(null);
		
		if (invalidater != null)
		{
			invalidater.invalidateEditorDeep();
			invalidater.invalidateTimelineActiveFrame();
		}
		else
		{
            r = document.editor.rebind();
            view.movie.timeline.fixActiveFrame();
		}

        return r;
	}
	
	public function getState() : NavigatorState
	{
		final first =
		{
			namePath: editPath[0].mcItem.namePath,
			layerIndex: editPath[0].layerIndex,
			frameIndex: editPath[0].frameIndex
		};
		
		final nexts = [];
		for (i in 1...editPath.length)
		{
			nexts.push
			({
				elementIndex: editPath[i - 1].frame.keyFrame.elements.indexOf(editPath[i].instance),
				layerIndex: editPath[i].layerIndex,
				frameIndex: editPath[i].frameIndex
			});
		}
		
		return new NavigatorState(first, nexts);
	}
	
	public function setState(state:NavigatorState) : Void
	{
		final editPath = new Array<PathItem>();
		
		editPath.push(new PathItem
		(
            cast(document.library.getItem(state.first.namePath), InstancableItem).newInstance(),
			state.first.layerIndex,
			state.first.frameIndex
		));
		
		var parent = editPath[0];
		for (next in state.nexts)
		{
			editPath.push(new PathItem
            (
                (cast parent.frame.keyFrame.elements[next.elementIndex] : Instance),
                next.layerIndex,
                next.frameIndex
            ));
			parent = editPath[editPath.length - 1];
		}
		
		navigateTo(editPath, false);
	}
	
	@:profile
	public function navigateUp(newEditPathLength:Int = null) : Void
	{
		Debug.assert(editPath.length >= 1);
        
        if (newEditPathLength == null) newEditPathLength = editPath.length - 1;
        Debug.assert(newEditPathLength >= 0);
        Debug.assert(newEditPathLength < editPath.length);

		_editPath = _editPath.splice(0, newEditPathLength);

        if (_editPath.length > 0)
        {
			update(false);
        }
        else
        {
            _editPath.push(new PathItem(document.library.getSceneInstance()));
            update(true);
        }
	}
	
	@:profile
	public function update(isCenterView:Bool)
	{
		if (_editPath.length == 0)
		{
			_editPath.push(new PathItem(document.library.getSceneInstance()));
		}

		view.movie.navigator.update();
		view.movie.timeline.update();
		
		document.editor.beginEditing(pathItem, isCenterView);

        view.movie.editor.show();
	}
	
	public function getNamePaths() : Array<String>
	{
		return editPath.map(x -> x.mcItem.namePath);
	}
}