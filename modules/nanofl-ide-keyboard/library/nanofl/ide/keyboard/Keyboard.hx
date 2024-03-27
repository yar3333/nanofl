package nanofl.ide.keyboard;

@:rtti @:jsRequire("@nanofl/ide-keyboard", "Keyboard") extern class Keyboard {
	function new(commands:nanofl.ide.keyboard.Commands):Void;
	var keymap(default, null) : Array<nanofl.ide.keyboard.KeymapItem>;
	var onCtrlButtonChange : stdlib.Event<{ public var pressed(default, default) : Bool; }>;
	var onShiftButtonChange : stdlib.Event<{ public var pressed(default, default) : Bool; }>;
	var onAltButtonChange : stdlib.Event<{ public var pressed(default, default) : Bool; }>;
	var onKeymapChange : stdlib.Event<{ }>;
	var onKeyDown : stdlib.Event<nanofl.ide.keyboard.KeyDownEvent>;
	function enable():Void;
	function disable():Void;
	function setKeymap(keymap:Array<nanofl.ide.keyboard.KeymapItem>):Void;
	function getShortcutsForCommand(command:String):Array<String>;
}