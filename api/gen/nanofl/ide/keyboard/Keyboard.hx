package nanofl.ide.keyboard;

extern class Keyboard {
	function new(commands:nanofl.ide.keyboard.Commands):Void;
	var keymap(default, null) : Array<{ public var shortcut(default, default) : String; public var command(default, default) : String; }>;
	var onCtrlButtonChange : stdlib.Event<{ public var pressed(default, default) : Bool; }>;
	var onShiftButtonChange : stdlib.Event<{ public var pressed(default, default) : Bool; }>;
	var onKeymapChange : stdlib.Event<{ }>;
	var onKeyDown : stdlib.Event<nanofl.ide.keyboard.KeyDownEvent>;
	function setKeymap(keymap:Array<{ public var shortcut(default, default) : String; public var command(default, default) : String; }>):Void;
	function getShortcutsForCommand(command:String):Array<String>;
	function getGroupedKeymap():Array<{ public var shortcuts(default, default) : String; public var command(default, default) : String; }>;
	function enable():Void;
	function disable():Void;
}