package nanofl.engine.movieclip;

extern class KeyFrame {
	function new(?label:String, ?duration:Int, ?motionTween:nanofl.engine.movieclip.MotionTween, ?elements:Array<nanofl.engine.elements.Element>):Void;
	var layer : nanofl.engine.movieclip.Layer;
	var label : String;
	var duration : Int;
	var elements(get, never) : Array<nanofl.engine.elements.Element>;
	private function get_elements():Array<nanofl.engine.elements.Element>;
	function getNextKeyFrame():nanofl.engine.movieclip.KeyFrame;
	function getPrevKeyFrame():nanofl.engine.movieclip.KeyFrame;
	function addElement(element:nanofl.engine.elements.Element, ?index:Int):Void;
	function removeElementAt(n:Int):Void;
	function removeElement(element:nanofl.engine.elements.Element):Void;
	function swapElement(i:Int, j:Int):Void;
	function isEmpty():Bool;
	function getElementsState():{ var elements : Array<nanofl.engine.elements.Element>; };
	function setElementsState(state:{ var elements : Array<nanofl.engine.elements.Element>; }):Void;
	function getTweenedElements(frameSubIndex:Int):Array<nanofl.engine.movieclip.TweenedElement>;
	function setLibrary(library:nanofl.engine.Library):Void;
	function toString():String;
	function getIndex():Int;
	function hasGoodMotionTween():Bool;
	function getParentLayerFrame(frameSubIndex:Int):nanofl.engine.movieclip.Frame;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function clone():nanofl.engine.movieclip.KeyFrame;
	function hasMotionTween():Bool;
	function removeMotionTween():Void;
	function getGuideLine():nanofl.engine.movieclip.GuideLine;
	function getShape(createIfNotExist:Bool):nanofl.engine.elements.ShapeElement;
	function duplicate(?label:String, ?duration:Int, ?elements:Array<nanofl.engine.elements.Element>):nanofl.engine.movieclip.KeyFrame;
	function equ(keyFrame:nanofl.engine.movieclip.KeyFrame):Bool;
	function getMotionTween():nanofl.engine.movieclip.MotionTween;
	function addDefaultMotionTween():Void;
	static function parse(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.movieclip.KeyFrame;
	static function parseJson(obj:Dynamic, version:String):nanofl.engine.movieclip.KeyFrame;
}