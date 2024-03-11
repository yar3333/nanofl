package nanofl.engine.elements;

extern class Element {
	var parent : nanofl.engine.movieclip.KeyFrame;
	var type(get, never) : nanofl.engine.ElementType;
	private function get_type():nanofl.engine.ElementType;
	var visible : Bool;
	var matrix : nanofl.engine.geom.Matrix;
	var regX : Float;
	var regY : Float;
	function setLibrary(library:nanofl.engine.Library):Void;
	function getState():nanofl.ide.undo.states.ElementState;
	function setState(state:nanofl.ide.undo.states.ElementState):Void;
	function fixErrors():Bool;
	function getUsedSymbolNamePaths():Array<String>;
	function clone():nanofl.engine.elements.Element;
	function toString():String;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var type : String; };
	function translate(dx:Float, dy:Float):Void;
	function createDisplayObject():easeljs.display.DisplayObject;
	function transform(m:nanofl.engine.geom.Matrix, ?applyToStrokeAndFill:Bool):Void;
	function equ(element:nanofl.engine.elements.Element):Bool;
	function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function parse(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.elements.Element;
	static function parseJson(obj:Dynamic, version:String):nanofl.engine.elements.Element;
}