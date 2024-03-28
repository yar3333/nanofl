package components.nanofl.movie.timeline;

extern class Code extends wquery.Component implements nanofl.ide.timeline.ITimelineView {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function init():Void;
	function hasSelectedFramesWithTween():Bool;
	function hasSelectedFramesWithoutTween():Bool;
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
	function getAciveFrame():nanofl.engine.movieclip.KeyFrame;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function createTween():Void;
	function removeTween():Void;
	function hasSelectedFrames():Bool;
	function saveSelectedToXml(out:htmlparser.XmlBuilder):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function pasteFromXml(xml:htmlparser.XmlNodeElement):Bool;
	function getSelectedLayerIndexes():Array<Int>;
	function gotoPrevFrame():Void;
	function gotoNextFrame():Void;
	function setSelectedLayerType(humanType:String):Void;
	function selectLayersByIndexes(layerIndexes:Array<Int>, ?replaceSelection:Bool):Void;
	function play():Void;
	function stop():Void;
	function renameActiveLayerByUser():Void;
}