package components.nanofl.movie.timeline;

import htmlparser.HtmlNodeElement;
import nanofl.engine.LayerType;
import datatools.ArrayRO;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.ui.menu.MenuItem;

interface ITimelineAdapter
{
	var layers(get, never) : ArrayRO<TLLayer>;
	
	var editable(get, never) : Bool;
	
	var frameIndex(get, set) : Int;
	var layerIndex(get, set) : Int;
	
	var framerate(get, never) : Float;
	
	var xmlLayersTag(default, null) : String;
	
	function beginTransaction() : Void;
	function commitTransaction() : Void;
	
	function getLayerContextMenu() : Array<MenuItem>;
	function getFrameContextMenu() : Array<MenuItem>;
	
	function getLibraryItems(namePaths:Array<String>) : Array<IIdeLibraryItem>;
	function addNewKeyFrameToLayer(layer:TLLayer) : Void;
	function newLayer(name:String, ?type:LayerType) : TLLayer;
	function parseLayer(layerNode:HtmlNodeElement, version:String) : TLLayer;
	
	function onLayerAdded() : Void;
	function onLayerRemoved() : Void;
	function onLayerVisibleChange() : Void;
	function onLayerLockChange() : Void;
	function onTweenCreated() : Void;
	function onTweenRemoved() : Void;
	function onConvertToKeyFrame() : Void;
	function onFrameRemoved() : Void;
	function onLayersSelectionChange(indexes:Array<Int>) : Void;
	
	function getTotalFrames() : Int;
	
	function addLayersBlock(layersToAdd:ArrayRO<TLLayer>, ?index:Int) : Void;
	function removeLayer(index:Int) : Void;
	function addLayer(layer:TLLayer) : Void;
	
	function getNamePaths(keyFrame:TLKeyFrame) : Array<String>;
	
	function getLayerNestLevel(layer:TLLayer) : Int;
	
	function duplicateLayerWoFrames(layer:TLLayer) : TLLayer;
	
	function getLayerKeyFrames(layer:TLLayer) : ArrayRO<TLKeyFrame>;
	
	function addKeyFrame(layer:TLLayer, keyFrame:TLKeyFrame) : Void;
}
