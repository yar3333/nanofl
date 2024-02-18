package nanofl.engine.strokes;

typedef StrokeParams =
{
	@:optional var thickness : Float;
	@:optional var ignoreScale : Bool;
	@:optional var color : String;
	@:optional var colors : Array<String>;
	@:optional var ratios : Array<Float>;
	@:optional var x0 : Float;
	@:optional var y0 : Float;
	@:optional var x1 : Float;
	@:optional var y1 : Float;
	@:optional var r : Float;
	@:optional var bitmapPath : String;
	@:optional var caps : String;
	@:optional var joints : String;
	@:optional var miterLimit : Float;
}