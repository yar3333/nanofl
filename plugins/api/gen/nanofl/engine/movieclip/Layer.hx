package nanofl.engine.movieclip;

extern class Layer {
	function new(name:String, ?type:nanofl.engine.LayerType, ?visible:Bool, ?locked:Bool, ?parentIndex:Int):Void;
	var layersContainer : nanofl.engine.libraryitems.MovieClipItem;
	var name : String;
	var type : nanofl.engine.LayerType;
	var visible : Bool;
	var locked : Bool;
	var parentIndex : Int;
	var parentLayer(get, never) : nanofl.engine.movieclip.Layer;
	@:noCompletion
	private function get_parentLayer():nanofl.engine.movieclip.Layer;
	var keyFrames(get, never) : Array<nanofl.engine.movieclip.KeyFrame>;
	function getTotalFrames():Int;
	function getFrame(frameIndex:Int):nanofl.engine.movieclip.Frame;
	function addKeyFrame(keyFrame:nanofl.engine.movieclip.KeyFrame):Void;
	function insertFrame(frameIndex:Int):Void;
	function convertToKeyFrame(frameIndex:Int, ?blank:Bool):Bool;
	function removeFrame(frameIndex:Int):Bool;
	function getHumanType():String;
	function getIcon():String;
	function getNestLevel(layers:Array<nanofl.engine.movieclip.Layer>):Int;
	function getChildLayers():Array<nanofl.engine.movieclip.Layer>;
	function getTweenedElements(frameIndex:Int):Array<nanofl.engine.movieclip.TweenedElement>;
	function loadProperties(node:htmlparser.HtmlNodeElement, version:String):Void;
	function loadPropertiesJson(obj:Dynamic, version:String):Void;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function clone():nanofl.engine.movieclip.Layer;
	function duplicate(keyFrames:Array<nanofl.engine.movieclip.KeyFrame>, parentIndex:Int):nanofl.engine.movieclip.Layer;
	function getIndex():Int;
	function setLibrary(library:nanofl.engine.Library):Void;
	function equ(layer:nanofl.engine.movieclip.Layer):Bool;
	function toString():String;
}