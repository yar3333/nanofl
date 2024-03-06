package nanofl.ide.navigator;

import stdlib.Std;
import stdlib.Debug;
import components.nanofl.movie.timeline.TimelineAdapterToEditor;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.Document;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import nanofl.ide.undo.states.NavigatorState;
import nanofl.engine.IPathElement;
using stdlib.Lambda;
using nanofl.engine.LayersTools;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Navigator extends InjectContainer
{
	@inject var view : View;
	@inject var preferences : Preferences;
	
	var document : Document;
	
	public var editPath(default, null) : Array<PathItem>;
	
	public var pathItem(get, never) : PathItem;
	@:noCompletion function get_pathItem() : PathItem return editPath[editPath.length - 1];
	
	@:noapi
	public function new(document:Document)
	{
		super();
		
		this.document = document;
		this.editPath = [];
	}
	
	public function navigateDown(container:IPathElement)
	{
        document.undoQueue.commitTransaction();
		editPath.push(new PathItem(container));
		update(false);
	}
	
	public function navigateTo(editPath:Array<PathItem>, isCenterView=true)
	{
        document.undoQueue.commitTransaction();
		this.editPath = editPath;
		update(isCenterView);
	}
	
	public function setLayerIndex(index:Int)
	{
		pathItem.setLayerIndex(index);
        view.movie.timeline.fixActiveLayer();
	}
	
	@:profile
	public function setFrameIndex(index:Int, ?invalidater:Invalidater, commitBeforeChange=true)
	{
		var totalFrames = pathItem.element.getTotalFrames();
		
		if (totalFrames > 0)
		{
			index = Std.max(index, 0);
			index = Std.min(index, totalFrames - 1);
		}
		else
		{
			index = 0;
		}
		
		if (pathItem.frameIndex == index) return;
		
		if (commitBeforeChange) document.undoQueue.commitTransaction();
		
		pathItem.setFrameIndex(index);
		
		if (invalidater != null)
		{
			invalidater.invalidateEditorDeep();
			invalidater.invalidateTimelineActiveFrame();
		}
		else
		{
            document.editor.rebind();
            view.movie.timeline.fixActiveFrame();
		}
	}
	
	//@:allow(nanofl.ide.undo)
	public function getState() : NavigatorState
	{
		var first =
		{
			namePath: (cast editPath[0].element : Instance).namePath,
			layerIndex: editPath[0].layerIndex,
			frameIndex: editPath[0].frameIndex
		};
		
		var nexts = [];
		for (i in 1...editPath.length)
		{
			nexts.push
			({
				elementIndex: editPath[i - 1].frame.keyFrame.elements.indexOf((cast editPath[i].element : Element)),
				layerIndex: editPath[i].layerIndex,
				frameIndex: editPath[i].frameIndex
			});
		}
		
		return new NavigatorState(first, nexts);
	}
	
	//@:allow(nanofl.ide.undo)
	public function setState(state:NavigatorState)
	{
		var editPath = new Array<PathItem>();
		
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
                (cast parent.frame.keyFrame.elements[next.elementIndex] : IPathElement),
                next.layerIndex,
                next.frameIndex
            ));
			parent = editPath[editPath.length - 1];
		}
		
		navigateTo(editPath, false);
	}
	
	@:profile
	public function navigateUp()
	{
		Debug.assert(editPath.length >= 1);
		
		if (editPath.length > 1)
		{
			editPath.pop();
			update(false);
		}
		else
		if (!editPath[0].isScene())
		{
			editPath.pop();
			editPath.push(new PathItem(document.library.getSceneInstance()));
			update(true);
		}
	}
	
	@:profile
	public function update(isCenterView:Bool)
	{
		if (editPath.length == 0)
		{
			editPath.push(new PathItem(document.library.getSceneInstance()));
		}
		
		view.movie.timeline.bind(new TimelineAdapterToEditor(document.editor, document.undoQueue, document.library.getRawLibrary(), preferences, pathItem, this, document.properties));
		view.movie.navigator.update();
		view.movie.timeline.update();
		
		document.editor.beginEditing(pathItem, isCenterView);

        view.movie.editor.show();
	}
	
	public function getInstanceNamePaths() : Array<String>
	{
		var r = [];
		for (item in editPath)
		{
			if (Std.isOfType(item.element, Instance))
			{
				r.push(cast(item.element, Instance).namePath);
			}
		}
		return r;
	}
}