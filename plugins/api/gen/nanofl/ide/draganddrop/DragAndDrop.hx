package nanofl.ide.draganddrop;

extern class DragAndDrop {
	function new():Void;
	var ready : js.lib.Promise<nanofl.ide.draganddrop.IDragAndDrop>;
}