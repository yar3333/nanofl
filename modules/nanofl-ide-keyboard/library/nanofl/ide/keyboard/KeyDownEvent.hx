package nanofl.ide.keyboard;

typedef KeyDownEvent = {
	var altKey(default, null) : Bool;
	var ctrlKey(default, null) : Bool;
	function processShortcut(prefix:String, whenVars:nanofl.ide.keyboard.WhenVars):Bool;
	var shiftKey(default, null) : Bool;
};