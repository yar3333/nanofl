package nanofl.engine;

typedef ShapeRender =
{
	function moveTo(x:Float, y:Float) : ShapeRender;
	function lineTo(x:Float, y:Float) : ShapeRender;
	function curveTo(x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender;
	
	function beginStroke(color:String) : ShapeRender;
	function beginLinearGradientStroke(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender;
	function beginRadialGradientStroke(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float) : ShapeRender;
	function beginBitmapStroke(image:Dynamic, repeat:String) : ShapeRender;
	function setStrokeStyle(thickness:Float, caps:String, joints:String, miterLimit:Float, ignoreScale:Bool) : ShapeRender;
	function endStroke() : ShapeRender;
	
	function beginFill(color:String) : ShapeRender;
	function beginLinearGradientFill(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender;
	function beginRadialGradientFill(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float) : ShapeRender;
	function beginBitmapFill(image:Dynamic, repeat:String, matrix:easeljs.geom.Matrix2D) : ShapeRender;
	function endFill() : ShapeRender;
}