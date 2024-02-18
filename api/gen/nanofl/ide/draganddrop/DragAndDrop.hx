package nanofl.ide.draganddrop;

extern class DragAndDrop {
	function new():Void;
	var ready(default, null) : js.lib.Promise<nanofl.ide.draganddrop.IDragAndDrop>;
}