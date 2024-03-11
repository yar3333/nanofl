package nanofl.ide.libraryitems;

import js.lib.Set;
import datatools.ArrayTools;
import htmlparser.HtmlNodeElement;
import nanofl.engine.MovieClipItemTools;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.elements.Elements;
import nanofl.ide.libraryitems.IIdeLibraryItem;
using stdlib.Lambda;
using stdlib.StringTools;

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
		switch (itemNode.name)
		{
            case "movieclip":
                final r = new MovieClipItem(namePath);
                r.loadProperties(itemNode);
                return r;
            
            case "group":
                final r = MovieClipItem.createWithFrame(namePath, Elements.parse(itemNode, itemNode.getAttribute("version")));
                r.loop = false;
                r.autoPlay = false;
                return r;

            case _:
                return null;
        }
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
	
	public function getUsedSymbolNamePaths() : Set<String>
	{
		var r = new Set([ namePath ]);
		
		MovieClipItemTools.iterateElements(this, true, (element, _) ->
		{
			for (namePath in element.getUsedSymbolNamePaths()) r.add(namePath);
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

	public function removeLayer(index:Int) : Void // TODO: check calls & parent layers
	{
		_layers.splice(index, 1);
		for (layer in _layers)
		{
			if (layer.parentIndex != null)
			{
				if      (layer.parentIndex == index) layer.parentIndex = null;
				else if (layer.parentIndex > index)  layer.parentIndex--;
			}
		}		
	}    

	public function removeLayerWithChildren(index:Int) : Array<Layer>
	{
		var n = index + 1; while (n < _layers.length && isLayerChildOf(n, index)) n++;

        final layerToRemoveCount = n - index;
		
		for (layer in _layers.slice(n))
		{
			if (layer.parentIndex != null && layer.parentIndex > index)
			{
				layer.parentIndex -= layerToRemoveCount;
			}
		}
		
		final removedLayers = _layers.splice(index, layerToRemoveCount);
		for (layer in removedLayers) layer.parentIndex -= index;
		removedLayers[0].parentIndex = null;
		
		return removedLayers;
	}

	function isLayerChildOf(childIndex:Int, parentIndex:Int)
	{
		var pi = _layers[childIndex].parentIndex;
		if (pi == null) return false;
		if (pi == parentIndex) return true;
		return isLayerChildOf(pi, parentIndex);
	}
}