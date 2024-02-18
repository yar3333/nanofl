package nanofl.engine;

extern class CustomPropertiesTools {
	static function equ(params1:Dynamic, params2:Dynamic):Bool;
	static function tween(start:Dynamic, t:Float, finish:Dynamic, properties:Array<nanofl.engine.CustomProperty>):Void;
	static function fix(params:Dynamic, properties:Array<nanofl.engine.CustomProperty>):Dynamic;
	static function resetToNeutral(params:Dynamic, properties:Array<nanofl.engine.CustomProperty>):Void;
}