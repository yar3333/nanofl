package nanofl;

extern class Stage extends easeljs.display.Stage {
	function new(canvas:Dynamic):Void;
	var recacheOnUpdate : Bool;
	override function update(?params:Dynamic):Void;
	function waitLoading():js.lib.Promise<{ }>;
}