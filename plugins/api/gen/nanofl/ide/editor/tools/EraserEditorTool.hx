package nanofl.ide.editor.tools;

extern class EraserEditorTool extends nanofl.ide.editor.tools.DrawEditorTool {
	function new(editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):Void;
	override function getCursor():String;
}