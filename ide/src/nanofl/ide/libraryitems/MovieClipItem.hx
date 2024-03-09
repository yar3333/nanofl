package nanofl.ide.libraryitems;

import nanofl.engine.MovieClipItemTools;
import datatools.ArrayTools;
import htmlparser.HtmlNodeElement;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.libraryitems.IIdeLibraryItem;
using stdlib.Lambda;

class MovieClipItem extends nanofl.engine.libraryitems.MovieClipItem
	implements IIdeInstancableItem
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
	
	override public function createDisplayObject()
	{
		return new nanofl.MovieClip(this);
	}
	
	public function getUsedSymbolNamePaths() : Array<String>
	{
		var r = [ namePath ];
		
		MovieClipItemTools.iterateElements(this, true, function(element, _)
		{
			ArrayTools.appendUniqueFast(r, element.getUsedSymbolNamePaths());
		});
		
		return r;
	}
	
    public function getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem:nanofl.ide.sys.FileSystem, destLibraryDir:String) : Dynamic
    {
        return null;
    }

	public function publish(fileSystem:nanofl.ide.sys.FileSystem, settings:nanofl.ide.PublishSettings, destLibraryDir:String, savedData:Dynamic) : IIdeLibraryItem
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