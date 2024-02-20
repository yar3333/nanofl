package nanofl.ide.editor;

extern class NewObjectParams extends nanofl.ide.InjectContainer {
	function new():Void;
	var strokeType : String;
	var fillType : String;
	var stroke(get, never) : nanofl.engine.strokes.IStroke;
	private function get_stroke():nanofl.engine.strokes.IStroke;
	var fill(get, never) : nanofl.engine.fills.IFill;
	private function get_fill():nanofl.engine.fills.IFill;
	var roundRadius : Float;
	var textFormat(default, null) : nanofl.TextRun;
	function setStroke(stroke:nanofl.engine.strokes.IStroke):Void;
	function setFill(fill:nanofl.engine.fills.IFill):Void;
	function setStrokeParams(p:nanofl.engine.strokes.StrokeParams):Void;
	function getStrokeParams():{ @:optional
	var bitmapPath : String; @:optional
	var caps : String; @:optional
	var color : String; @:optional
	var colors : Array<String>; @:optional
	var ignoreScale : Bool; @:optional
	var joints : String; @:optional
	var miterLimit : Float; @:optional
	var r : Float; @:optional
	var ratios : Array<Float>; @:optional
	var thickness : Float; var type : String; @:optional
	var x0 : Float; @:optional
	var x1 : Float; @:optional
	var y0 : Float; @:optional
	var y1 : Float; };
	function setFillParams(p:nanofl.engine.fills.FillParams):Void;
	function getFillParams():{ @:optional
	var bitmapPath : String; @:optional
	var color : String; @:optional
	var colors : Array<String>; @:optional
	var matrix : nanofl.engine.geom.Matrix; @:optional
	var r : Float; @:optional
	var ratios : Array<Float>; @:optional
	var repeat : String; var type : String; @:optional
	var x0 : Float; @:optional
	var x1 : Float; @:optional
	var y0 : Float; @:optional
	var y1 : Float; };
	function getStrokeByType(type:String):nanofl.engine.strokes.IStroke;
	function getFillByType(type:String):nanofl.engine.fills.IFill;
}