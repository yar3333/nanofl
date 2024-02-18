package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;

typedef FillParams =
{
	@:optional var color : String;
	@:optional var colors : Array<String>;
	@:optional var ratios : Array<Float>;
	@:optional var x0 : Float;
	@:optional var y0 : Float;
	@:optional var x1 : Float;
	@:optional var y1 : Float;
	@:optional var r : Float;
	@:optional var bitmapPath : String;
	@:optional var matrix : Matrix;
	@:optional var repeat : String;
}