package components.nanofl.movie.timeline;

extern class Code extends wquery.Component implements nanofl.ide.timeline.ITimeline {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function bind(adapter:components.nanofl.movie.timeline.ITimelineAdapter):Void;
	function init():Void;
	function update():Void;
	function insertFrame():Void;
	function convertToKeyFrame():Void;
	function addBlankKeyFrame():Void;
	function removeSelectedFrames():Void;
	function updateHeader():Void;
	function fixActiveFrame():Void;
	function fixActiveLayer():Void;
	function resize(maxWidth:Int, maxHeight:Int):Void;
	function updateActiveLayerFrames():Void;
	function updateActiveFrame():Void;
	function updateFrames(?isUpdateHeader:Bool):Void;
	function selectLayerFrames(layerIndexes:Array<Int>):Void;
	function getAciveFrame():components.nanofl.movie.timeline.TLKeyFrame;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function createTween():Void;
	function removeTween():Void;
	function hasSelectedFrames():Bool;
	function saveSelectedToXml(out:htmlparser.XmlBuilder):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function pasteFromXml(xml:htmlparser.XmlNodeElement):Bool;
	function getSelectedLayerIndexes():Array<Int>;
	function gotoPrevFrame():Void;
	function gotoNextFrame():Void;
	function setSelectedLayerType(type:String):Void;
	function setLayerType(layer:components.nanofl.movie.timeline.TLLayer, type:String):Void;
	function selectLayersByIndexes(layerIndexes:Array<Int>, ?replaceSelection:Bool):Void;
	function play():Void;
	function stop():Void;
	function renameSelectedLayerByUser():Void;
	function getActiveKeyFrame():components.nanofl.movie.timeline.TLKeyFrame;
}