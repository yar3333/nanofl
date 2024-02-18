package nanofl.ide.editor.tools;

extern class GradientEditorTool extends nanofl.ide.editor.tools.EditorTool {
	function new(editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):Void;
	override function isShowRegPoints():Bool;
	override function createControls(controls:easeljs.display.Container):Void;
	override function selectionChange():Void;
	override function stageClick(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function stageMouseMove(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function getPropertiesObject(selectedItems:Array<nanofl.ide.editor.elements.EditorElement>):nanofl.ide.PropertiesObject;
}