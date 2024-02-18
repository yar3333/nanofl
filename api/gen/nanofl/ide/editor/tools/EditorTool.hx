package nanofl.ide.editor.tools;

extern class EditorTool {
	function createControls(controls:easeljs.display.Container):Void;
	function beginEditing(item:nanofl.ide.editor.elements.EditorElement):Void;
	function endEditing():Void;
	function isShowCenterCross():Bool;
	function isShowRegPoints():Bool;
	function getCursor():String;
	function stageClick(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageMouseDown(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageMouseMove(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageMouseUp(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageDoubleClick(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageRightMouseDown(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function stageRightMouseUp(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function itemMouseDown(e:nanofl.ide.editor.EditorMouseEvent, item:nanofl.ide.editor.elements.EditorElement):Void;
	function itemPressUp(e:nanofl.ide.editor.EditorMouseEvent):Void;
	function itemChanged(item:nanofl.ide.editor.elements.EditorElement):Void;
	function figureChanged():Void;
	function onSelectedTranslate(dx:Float, dy:Float):Void;
	function getPropertiesObject(selectedItems:Array<nanofl.ide.editor.elements.EditorElement>):nanofl.ide.PropertiesObject;
	function allowContextMenu():Bool;
	function draw(shapeSelections:easeljs.display.Shape, itemSelections:easeljs.display.Shape):Void;
	function selectionChange():Void;
	static function create<T:(nanofl.ide.editor.tools.EditorTool)>(clas:Class<T>, editor:nanofl.ide.editor.Editor, library:nanofl.ide.editor.EditorLibrary, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, newObjectParams:nanofl.ide.editor.NewObjectParams, undoQueue:nanofl.ide.undo.document.UndoQueue):T;
}