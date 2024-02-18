package nanofl.engine.geom;

extern class Polygon implements nanofl.engine.ISelectable {
	function new(?fill:nanofl.engine.fills.IFill, ?contours:Array<nanofl.engine.geom.Contour>, ?selected:Bool):Void;
	var contours(default, null) : Array<nanofl.engine.geom.Contour>;
	var fill : nanofl.engine.fills.IFill;
	@:isVar
	var selected(get, set) : Bool;
	private function get_selected():Bool;
	private function set_selected(v:Bool):Bool;
	function save(fills:Array<nanofl.engine.fills.IFill>, out:htmlparser.XmlBuilder):Void;
	function saveJson(fills:Array<nanofl.engine.fills.IFill>):Dynamic;
	function draw(g:nanofl.engine.ShapeRender, scaleSelection:Float):Void;
	function translate(dx:Float, dy:Float):Void;
	function isPointInside(px:Float, py:Float):Bool;
	function hasPoint(px:Float, py:Float):Bool;
	function hasEdge(edge:nanofl.engine.geom.Edge):Bool;
	function isEdgeInside(edge:nanofl.engine.geom.Edge):Bool;
	function isEdgeAtLeastPartiallyInside(edge:nanofl.engine.geom.Edge):Bool;
	function isPolygonInside(p:nanofl.engine.geom.Polygon):Bool;
	function translateVertex(point:nanofl.engine.geom.Point, dx:Float, dy:Float):Void;
	function getBounds(?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	function applyFill(fill:nanofl.engine.fills.IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float):Void;
	function transform(m:nanofl.engine.geom.Matrix, ?applyToFill:Bool):Void;
	function getEdges(?edges:Array<nanofl.engine.geom.Edge>):Array<nanofl.engine.geom.Edge>;
	function getPointInside():nanofl.engine.geom.Point;
	function clone():nanofl.engine.geom.Polygon;
	function replaceEdge(search:nanofl.engine.geom.Edge, replacement:Array<nanofl.engine.geom.Edge>):Void;
	function export(out:htmlparser.XmlBuilder, fills:Array<nanofl.engine.fills.IFill>):Void;
	function split():Array<nanofl.engine.geom.Polygon>;
	function equ(p:nanofl.engine.geom.Polygon):Bool;
	function normalize():Void;
	function isInRectangle(x:Float, y:Float, width:Float, height:Float):Bool;
	function assertCorrect():Void;
	function isContourOutside(c:nanofl.engine.geom.Contour):Bool;
	function fixErrors():Array<nanofl.engine.geom.Polygon>;
	function toString():String;
	static var showSelection : Bool;
	static function load(node:htmlparser.HtmlNodeElement, fills:Array<nanofl.engine.fills.IFill>, version:String):nanofl.engine.geom.Polygon;
	static function loadJson(obj:Dynamic, fills:Array<nanofl.engine.fills.IFill>, version:String):nanofl.engine.geom.Polygon;
}