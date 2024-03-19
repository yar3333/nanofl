package nanofl.ide.keyboard;

extern class ShortcutTools {
	static function equ(a:nanofl.ide.keyboard.Shortcut, b:nanofl.ide.keyboard.Shortcut):Bool;
	static function key(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function ctrl(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function shift(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function alt(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function ctrlShift(keyCode:Int):nanofl.ide.keyboard.Shortcut;
	static function toString(e:nanofl.ide.keyboard.Shortcut):String;
}