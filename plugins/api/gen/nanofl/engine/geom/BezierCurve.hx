package nanofl.engine.geom;

typedef BezierCurvesIntersection = {
	var a : Array<nanofl.engine.geom.BezierCurve>;
	var b : Array<nanofl.engine.geom.BezierCurve>;
};

extern class BezierCurve {
	function new(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float):Void;
	var p1(default, null) : nanofl.engine.geom.Point;
	var p2(default, null) : nanofl.engine.geom.Point;
	var p3(default, null) : nanofl.engine.geom.Point;
	function getNearestPoint(x:Float, y:Float):{ var dist : Float; var nor : nanofl.engine.geom.Point; var orientedDist : Float; var point : nanofl.engine.geom.Point; var t : Float; };
	function getNearestPointP(pt:nanofl.engine.geom.Point):{ var dist : Float; var nor : nanofl.engine.geom.Point; var orientedDist : Float; var point : nanofl.engine.geom.Point; var t : Float; };
	function getPoint(t:Float):nanofl.engine.geom.Point;
	function getNor(t:Float):nanofl.engine.geom.Point;
	function getBounds():nanofl.engine.geom.Bounds;
	function getIntersectionPointsX_rightRay(mx:Float, my:Float):Array<Float>;
	function getIntersectionCount_rightRay(mx:Float, my:Float):Int;
	function getIntersection_straightSection(line:nanofl.engine.geom.StraightLine):{ var curves : Array<nanofl.engine.geom.BezierCurve>; var lines : Array<nanofl.engine.geom.StraightLine>; };
	function getIntersection_bezierCurve(curve:nanofl.engine.geom.BezierCurve):nanofl.engine.geom.BezierCurve.BezierCurvesIntersection;
	function isDegenerated():Bool;
	function getFirstPart(t:Float):nanofl.engine.geom.BezierCurve;
	function getSecondPart(t:Float):nanofl.engine.geom.BezierCurve;
	function getPart(t1:Float, t2:Float):nanofl.engine.geom.BezierCurve;
	function split(tt:Array<Float>):Array<nanofl.engine.geom.BezierCurve>;
	function translate(dx:Float, dy:Float):nanofl.engine.geom.BezierCurve;
	function rotate(da:Float):nanofl.engine.geom.BezierCurve;
	function clone():nanofl.engine.geom.BezierCurve;
	function equ(curve:nanofl.engine.geom.BezierCurve):Bool;
	function getReversed():nanofl.engine.geom.BezierCurve;
	function reverse():Void;
	function getLength():Float;
	function getTangent(t:Float):Float;
	function toString():String;
	function getMonotoneT(k:Float):Float;
}