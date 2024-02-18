package nanofl.ide.editor;

extern class EditorMouseEvent extends nanofl.ide.Invalidater {
	function new(native:easeljs.events.MouseEvent, container:easeljs.display.DisplayObject):Void;
	var x : Float;
	var y : Float;
	var ctrlKey : Bool;
	var shiftKey : Bool;
}