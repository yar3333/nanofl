package nanofl.engine.geom;

extern class Equation {
	static function solveCube(a:Float, b:Float, c:Float, d:Float):Array<Float>;
	static function solveQuadratic(a:Float, b:Float, c:Float):Array<Float>;
}