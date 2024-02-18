package nanofl.engine;

typedef ShapeRender = {
	function beginBitmapFill(image:Dynamic, repeat:String, matrix:easeljs.geom.Matrix2D):nanofl.engine.ShapeRender;
	function beginBitmapStroke(image:Dynamic, repeat:String):nanofl.engine.ShapeRender;
	function beginFill(color:String):nanofl.engine.ShapeRender;
	function beginLinearGradientFill(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float):nanofl.engine.ShapeRender;
	function beginLinearGradientStroke(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float):nanofl.engine.ShapeRender;
	function beginRadialGradientFill(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float):nanofl.engine.ShapeRender;
	function beginRadialGradientStroke(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float):nanofl.engine.ShapeRender;
	function beginStroke(color:String):nanofl.engine.ShapeRender;
	function curveTo(x0:Float, y0:Float, x1:Float, y1:Float):nanofl.engine.ShapeRender;
	function endFill():nanofl.engine.ShapeRender;
	function endStroke():nanofl.engine.ShapeRender;
	function lineTo(x:Float, y:Float):nanofl.engine.ShapeRender;
	function moveTo(x:Float, y:Float):nanofl.engine.ShapeRender;
	function setStrokeStyle(thickness:Float, caps:String, joints:String, miterLimit:Float, ignoreScale:Bool):nanofl.engine.ShapeRender;
};