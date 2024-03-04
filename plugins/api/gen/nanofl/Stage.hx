package nanofl;

extern class Stage extends easeljs.display.Stage {
	function new(canvas:Dynamic, framerate:Float):Void;
	var framerate(default, null) : Float;
	override function update(?params:Dynamic):Void;
}