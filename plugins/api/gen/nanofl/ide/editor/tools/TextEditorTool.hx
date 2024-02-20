package nanofl.ide.editor.tools;

extern class TextEditorTool extends nanofl.ide.editor.tools.EditorTool {
	function new(editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):Void;
	override function createControls(controls:easeljs.display.Container):Void;
	override function beginEditing(item:nanofl.ide.editor.elements.EditorElement):Void;
	override function endEditing():Void;
	override function isShowCenterCross():Bool;
	override function getCursor():String;
	override function stageClick(e:nanofl.ide.editor.EditorMouseEvent):Void;
	override function itemMouseDown(e:nanofl.ide.editor.EditorMouseEvent, item:nanofl.ide.editor.elements.EditorElement):Void;
	override function itemChanged(item:nanofl.ide.editor.elements.EditorElement):Void;
	override function getPropertiesObject(selectedItems:Array<nanofl.ide.editor.elements.EditorElement>):nanofl.ide.PropertiesObject;
	override function draw(shapeSelections:easeljs.display.Shape, itemSelections:easeljs.display.Shape):Void;
}