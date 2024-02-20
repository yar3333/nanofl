package nanofl.engine.geom;

extern class BoundsTools {
	static function extendR(bounds:nanofl.engine.geom.Bounds, rect:{ var height : Float; var width : Float; var x : Float; var y : Float; }):nanofl.engine.geom.Bounds;
	static function extend(bounds:nanofl.engine.geom.Bounds, b:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	static function isIntersect(a:nanofl.engine.geom.Bounds, b:nanofl.engine.geom.Bounds, ?gap:Float):Bool;
	static function isPointInside(bounds:nanofl.engine.geom.Bounds, x:Float, y:Float, ?gap:Float):Bool;
	static function isPointInsideP(bounds:nanofl.engine.geom.Bounds, pt:nanofl.engine.geom.Point, ?gap:Float):Bool;
	static function getNearestPoint(bounds:nanofl.engine.geom.Bounds, pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	static function clone(bounds:nanofl.engine.geom.Bounds):nanofl.engine.geom.Bounds;
	static function toBounds(rect:{ var height : Float; var width : Float; var x : Float; var y : Float; }):nanofl.engine.geom.Bounds;
	static function toString(bounds:nanofl.engine.geom.Bounds):String;
	static function toRectangle(bounds:nanofl.engine.geom.Bounds):easeljs.geom.Rectangle;
	static function transform<R:({ var height : Float; var width : Float; var x : Float; var y : Float; })>(bounds:R, matrix:{ var a : Float; var b : Float; var c : Float; var d : Float; var tx : Float; var ty : Float; }):R;
}