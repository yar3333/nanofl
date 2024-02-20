package nanofl.engine.fills;

typedef FillParams = {
	@:optional
	var bitmapPath : String;
	@:optional
	var color : String;
	@:optional
	var colors : Array<String>;
	@:optional
	var matrix : nanofl.engine.geom.Matrix;
	@:optional
	var r : Float;
	@:optional
	var ratios : Array<Float>;
	@:optional
	var repeat : String;
	@:optional
	var x0 : Float;
	@:optional
	var x1 : Float;
	@:optional
	var y0 : Float;
	@:optional
	var y1 : Float;
};