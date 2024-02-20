package nanofl.ide.editor.tools;

extern class DropperEditorTool extends nanofl.ide.editor.tools.EditorTool {
	function new(editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):Void;
	override function allowContextMenu():Bool;
	override function stageMouseDown(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function stageRightMouseDown(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function stageMouseMove(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function stageMouseUp(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function stageRightMouseUp(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function getPropertiesObject(selectedItems:Array<nanofl.ide.editor.elements.EditorElement>):nanofl.ide.PropertiesObject;
}