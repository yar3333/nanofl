package components.nanofl.movie.timeline;

interface ITimelineAdapter {
	var layers(get, never) : Array<components.nanofl.movie.timeline.TLLayer>;
	var editable(get, never) : Bool;
	var frameIndex(get, set) : Int;
	var layerIndex(get, set) : Int;
	var framerate(get, never) : Float;
	var xmlLayersTag(default, null) : String;
	function beginTransaction():Void;
	function commitTransaction():Void;
	function getLayerContextMenu():Array<nanofl.ide.ui.menu.MenuItem>;
	function getFrameContextMenu():Array<nanofl.ide.ui.menu.MenuItem>;
	function getLibraryItems(namePaths:Array<String>):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function addNewKeyFrameToLayer(layer:components.nanofl.movie.timeline.TLLayer):Void;
	function newLayer(name:String, ?type:nanofl.engine.LayerType):components.nanofl.movie.timeline.TLLayer;
	function parseLayer(layerNode:htmlparser.HtmlNodeElement, version:String):components.nanofl.movie.timeline.TLLayer;
	function onLayerAdded():Void;
	function onLayerRemoved():Void;
	function onLayerVisibleChange():Void;
	function onLayerLockChange():Void;
	function onTweenCreated():Void;
	function onTweenRemoved():Void;
	function onConvertToKeyFrame():Void;
	function onFrameRemoved():Void;
	function onLayersSelectionChange(indexes:Array<Int>):Void;
	function getTotalFrames():Int;
	function addLayersBlock(layersToAdd:Array<components.nanofl.movie.timeline.TLLayer>, ?index:Int):Void;
	function removeLayer(index:Int):Void;
	function addLayer(layer:components.nanofl.movie.timeline.TLLayer):Void;
	function getNamePaths(keyFrame:components.nanofl.movie.timeline.TLKeyFrame):Array<String>;
	function getLayerNestLevel(layer:components.nanofl.movie.timeline.TLLayer):Int;
	function duplicateLayerWoFrames(layer:components.nanofl.movie.timeline.TLLayer):components.nanofl.movie.timeline.TLLayer;
	function getLayerKeyFrames(layer:components.nanofl.movie.timeline.TLLayer):Array<components.nanofl.movie.timeline.TLKeyFrame>;
	function addKeyFrame(layer:components.nanofl.movie.timeline.TLLayer, keyFrame:components.nanofl.movie.timeline.TLKeyFrame):Void;
}