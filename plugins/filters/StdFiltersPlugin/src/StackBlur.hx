package;

import js.html.CanvasElement;

extern class StackBlur
{
	private static function __init__() : Void
	{
		haxe.macro.Compiler.includeFile("StackBlur.js", "inline");
	}
	
	public static function stackBlurCanvasRGBA(canvas:CanvasElement, x:Float, y:Float, width:Float, height:Float, radius:Int) : Void;
}