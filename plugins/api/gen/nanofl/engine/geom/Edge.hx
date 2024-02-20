package nanofl.engine.geom;

typedef EdgesItersection = {
	var a : Array<nanofl.engine.geom.Edge>;
	var b : Array<nanofl.engine.geom.Edge>;
};

extern class Edge {
	function new(x1:Float, y1:Float, x2:Float, y2:Float, ?x3:Float, ?y3:Float):Void;
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
	var x3 : Float;
	var y3 : Float;
	function isStraight():Bool;
	function getIntersectionCount_rightRay(x:Float, y:Float):Int;
	function getIntersectionDirectedCount_rightRay(x:Float, y:Float):Int;
	function getIntersectionPointsX_rightRay(x:Float, y:Float):Array<Float>;
	function drawTo(g:nanofl.engine.ShapeRender):Void;
	function equ(e:nanofl.engine.geom.Edge):Bool;
	function equDirected(e:nanofl.engine.geom.Edge):Bool;
	function getNearestPoint(x:Float, y:Float):{ var point : nanofl.engine.geom.Point; var t : Float; };
	function translate(dx:Float, dy:Float):Void;
	function translateVertex(point:nanofl.engine.geom.Point, dx:Float, dy:Float):Void;
	function translateStart(dx:Float, dy:Float):Void;
	function translateEnd(dx:Float, dy:Float):Void;
	function reverse():nanofl.engine.geom.Edge;
	function getBounds(?bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	function getBoundsRO():nanofl.engine.geom.Bounds;
	function toString():String;
	function getMiddlePoint():nanofl.engine.geom.Point;
	function hasCommonVertices(edge:nanofl.engine.geom.Edge):Bool;
	function transform(m:nanofl.engine.geom.Matrix, ?applyToStroke:Bool):Void;
	function splitByClosePoint(x:Float, y:Float):Array<nanofl.engine.geom.Edge>;
	function asStraightLine():nanofl.engine.geom.StraightLine;
	function asBezierCurve():nanofl.engine.geom.BezierCurve;
	function clone():nanofl.engine.geom.Edge;
	function duplicate(e:nanofl.engine.geom.Edge):nanofl.engine.geom.Edge;
	function indexIn<T:(nanofl.engine.geom.Edge)>(edges:Array<T>):Int;
	function isDegenerated():Bool;
	function roundPoints():Void;
	function getLength():Float;
	function getPart(t:Float):nanofl.engine.geom.Edge;
	function getPoint(t:Float):nanofl.engine.geom.Point;
	function getTangent(t:Float):Float;
	function split(tt:Array<Float>):Array<nanofl.engine.geom.Edge>;
	function isInRectangle(x:Float, y:Float, width:Float, height:Float):Bool;
	function getMonotoneT(k:Float):Float;
	static function fromStraightLine(line:nanofl.engine.geom.StraightLine):nanofl.engine.geom.Edge;
	static function fromBezierCurve(curve:nanofl.engine.geom.BezierCurve):nanofl.engine.geom.Edge;
	static function getIntersection(edgeA:nanofl.engine.geom.Edge, edgeB:nanofl.engine.geom.Edge):nanofl.engine.geom.Edge.EdgesItersection;
	static function loadFromJson(obj:Dynamic):nanofl.engine.geom.Edge;
}