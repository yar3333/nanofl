package nanofl.engine.geom;

extern class Contour {
	function new(edges:Array<nanofl.engine.geom.Edge>):Void;
	var edges(default, null) : Array<nanofl.engine.geom.Edge>;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function draw(g:nanofl.engine.ShapeRender):Void;
	function translate(dx:Float, dy:Float):Void;
	function transform(m:nanofl.engine.geom.Matrix):Void;
	function isPointInside(px:Float, py:Float):Bool;
	function isPointInsideP(p:nanofl.engine.geom.Point):Bool;
	function hasPoint(px:Float, py:Float):Bool;
	function hasEdge(edge:nanofl.engine.geom.Edge):Bool;
	function isEdgeInside(edge:nanofl.engine.geom.Edge):Bool;
	function isNestedTo(outer:nanofl.engine.geom.Contour):Bool;
	function clone():nanofl.engine.geom.Contour;
	function isClockwise():Bool;
	function isCounterClockwise():Bool;
	function getClockwiseProduct():Float;
	function normalize():Void;
	function reverse():nanofl.engine.geom.Contour;
	function indexIn(contours:Array<nanofl.engine.geom.Contour>):Int;
	function equ(c:nanofl.engine.geom.Contour):Bool;
	function toString():String;
	function assertCorrect():Void;
	static function fromRectangle(rect:{ var height : Float; var width : Float; var x : Float; var y : Float; }):nanofl.engine.geom.Contour;
}