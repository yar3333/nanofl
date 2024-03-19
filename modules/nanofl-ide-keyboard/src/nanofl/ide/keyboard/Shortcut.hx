package nanofl.ide.keyboard;

typedef Shortcut = 
{
	var keyCode : Int;
	@:optional var ctrlKey : Bool;
	@:optional var shiftKey : Bool;
	@:optional var altKey : Bool;
}
