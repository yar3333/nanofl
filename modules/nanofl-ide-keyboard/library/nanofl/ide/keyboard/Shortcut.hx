package nanofl.ide.keyboard;

@:jsRequire("@nanofl/ide-keyboard", "Shortcut") extern class Shortcut {
	function test(e:{ var altKey : Bool; var ctrlKey : Bool; var keyCode : Int; var shiftKey : Bool; }):Bool;
	static function key(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function ctrl(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function shift(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function alt(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function ctrlShift(keyCode:Int):nanofl.ide.keyboard.Shortcut;
}