package nanofl.ide.editor.tools;

extern class TransformEditorTool extends nanofl.ide.editor.tools.SelectEditorTool {
	function new(editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):Void;
	override function isShowRegPoints():Bool;
	override function createControls(controls:easeljs.display.Container):Void;
	override function selectionChange():Void;
	override function draw(shapeSelections:easeljs.display.Shape, itemSelections:easeljs.display.Shape):Void;
	override function onSelectedTranslate(dx:Float, dy:Float):Void;
	override function stageMouseMove(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function itemChanged(item:nanofl.ide.editor.elements.EditorElement):Void;
	override function figureChanged():Void;
}