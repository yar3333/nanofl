package nanofl.ide.libraryitems;

import nanofl.engine.MovieClipItemTools;
import nanofl.engine.IPathElement;
import datatools.ArrayTools;
import htmlparser.HtmlNodeElement;
import js.lib.Promise;
import nanofl.engine.LayerType;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import stdlib.Debug;
import stdlib.Std;
using stdlib.Lambda;

class MovieClipItem extends nanofl.engine.libraryitems.MovieClipItem
	implements IIdeInstancableItem
	implements nanofl.ide.ITimeline
{
	public static function createWithFrame(namePath:String, ?elements:Array<Element>, layerName="Layer 0") : MovieClipItem
	{
		var item = new MovieClipItem(namePath);
		var layer = new Layer(layerName);
		item.addLayer(layer);
		layer.addKeyFrame(new KeyFrame(elements));
		return item;
	}
	
	override public function clone() : MovieClipItem
	{
		var obj = new MovieClipItem(namePath);
		copyBaseProperties(obj);
		copyProperties(obj);
		return obj;
	}
	
	public static function parse(namePath:String, itemNode:HtmlNodeElement) : MovieClipItem
	{
		if (itemNode.name != "movieclip") return null;
		
        var r = new MovieClipItem(namePath);
        r.loadProperties(itemNode);
		return r;
	}
	
	public static function parseJson(namePath:String, obj:Dynamic) : MovieClipItem
	{
        var r = new MovieClipItem(namePath);
        r.loadPropertiesJson(obj);
		return r;
	}
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		return new nanofl.MovieClip(this, initFrameIndex, childFrameIndexes);
	}
	
	override public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : Void
	{
		Debug.assert(Std.isOfType(dispObj, nanofl.MovieClip));
		
		var movieClip : nanofl.MovieClip = cast dispObj;
		
		movieClip.removeAllChildren();
		movieClip.alpha = 1.0;
		
		var topElement : Element = null;
		var topElementLayer : Int = null;
		
		var i = layers.length - 1; while (i >= 0)
		{
			for (tweenedElement in layers[i].getTweenedElements(movieClip.currentFrame))
			{
				if (childFrameIndexes == null || childFrameIndexes.length == 0 || childFrameIndexes[0].element != cast tweenedElement.original)
				{
					var obj = tweenedElement.current.createDisplayObject(childFrameIndexes);
					obj.visible = layers[i].type == LayerType.normal;
					movieClip.addChildToLayer(obj, i);
				}
				else
				if (childFrameIndexes != null && childFrameIndexes.length != 0 && childFrameIndexes[0].element == cast tweenedElement.original)
				{
					topElement = tweenedElement.current;
					topElementLayer = i;
				}
			}
			i--;
		}
		
		if (topElement != null)
		{
			movieClip.addChildToLayer(topElement.createDisplayObject(childFrameIndexes), topElementLayer);
		}
	}
	
	override public function preload() : Promise<{}> return Promise.resolve();
	
	/*override public function equ(item:ILibraryItem) : Bool
	{
		return super.equ(item);
	}*/
	
	public function getUsedSymbolNamePaths() : Array<String>
	{
		var r = [ namePath ];
		
		MovieClipItemTools.iterateElements(this, true, function(element, _)
		{
			ArrayTools.appendUniqueFast(r, element.getUsedSymbolNamePaths());
		});
		
		return r;
	}
	
	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String) : IIdeLibraryItem
	{
		return clone();
	}
	
	public function getTimelineState() : nanofl.ide.undo.states.TimelineState
	{
		return new nanofl.ide.undo.states.TimelineState(ArrayTools.clone(_layers));
	}
	
	public function setTimelineState(state:nanofl.ide.undo.states.TimelineState)
	{
		_layers = ArrayTools.clone(state.layerStates);
		for (layer in layers) layer.layersContainer = this;
	}
	
	public function getFilePathToRunWithEditor() : String return null;
	
	public function getLibraryFilePaths() : Array<String> return [];
}