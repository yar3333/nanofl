package nanofl.ide.keyboard;

typedef Shortcut = {
	@:optional
	var altKey : Bool;
	@:optional
	var ctrlKey : Bool;
	var keyCode : Int;
	@:optional
	var shiftKey : Bool;
};