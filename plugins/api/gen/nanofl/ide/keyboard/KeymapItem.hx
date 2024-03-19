package nanofl.ide.keyboard;

typedef KeymapItem = {
	var command(default, never) : String;
	var shortcut(default, never) : String;
	@:optional
	var when(default, never) : String;
};