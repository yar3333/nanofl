package nanofl.engine.geom;

extern class PointTools {
	static function half(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function round(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function normalize(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function getLength(pt:nanofl.engine.geom.Point):Float;
	@:noUsing
	static function getDist(x1:Float, y1:Float, x2:Float, y2:Float):Float;
	@:noUsing
	static function getSqrDist(x1:Float, y1:Float, x2:Float, y2:Float):Float;
	@:noUsing
	static function rotate(x:Float, y:Float, da:Float):nanofl.engine.geom.Point;
	static function getRotated(pt:nanofl.engine.geom.Point, da:Float):nanofl.engine.geom.Point;
	static function moveInDirection(start:nanofl.engine.geom.Point, endX:Float, endY:Float, len:Float):nanofl.engine.geom.Point;
	static function equ(pt1:nanofl.engine.geom.Point, pt2:nanofl.engine.geom.Point):Bool;
	static function clone(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	@:noUsing
	static function roundGap(n:Float):Float;
	static function roundGapP(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function getNearest(pt:nanofl.engine.geom.Point, points:Array<nanofl.engine.geom.Point>):nanofl.engine.geom.Point;
	static function toString(pt:nanofl.engine.geom.Point):String;
}