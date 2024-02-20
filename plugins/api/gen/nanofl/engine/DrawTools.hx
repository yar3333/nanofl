package nanofl.engine;

extern class DrawTools {
	static function drawDashedLine(g:nanofl.engine.ShapeRender, x1:Float, y1:Float, x2:Float, y2:Float, color1:String, ?color2:String, ?dashLen:Float):nanofl.engine.ShapeRender;
	static function drawDashedRect(g:nanofl.engine.ShapeRender, x1:Float, y1:Float, x2:Float, y2:Float, color1:String, ?color2:String, ?dashLen:Float):nanofl.engine.ShapeRender;
}