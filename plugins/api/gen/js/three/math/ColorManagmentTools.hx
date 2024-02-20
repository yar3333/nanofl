package js.three.math;

@:native("THREE") extern class ColorManagmentTools {
	static function SRGBToLinear(c:Float):Float;
	static function LinearToSRGB(c:Float):Float;
}