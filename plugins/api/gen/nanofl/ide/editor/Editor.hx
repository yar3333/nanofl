package nanofl.ide.editor;

extern class Editor extends nanofl.ide.InjectContainer {
	function new(document:nanofl.ide.Document):Void;
	var tool(default, null) : nanofl.ide.editor.tools.EditorTool;
	var container(default, null) : easeljs.display.Container;
	var layers : Array<nanofl.ide.editor.EditorLayer>;
	var activeLayer(get, never) : nanofl.ide.editor.EditorLayer;
	@:noCompletion
	private function get_activeLayer():nanofl.ide.editor.EditorLayer;
	var activeShape(get, never) : nanofl.engine.elements.ShapeElement;
	@:noCompletion
	private function get_activeShape():nanofl.engine.elements.ShapeElement;
	var figure(default, null) : nanofl.ide.editor.Figure;
	var magnet(get, set) : Bool;
	@:noCompletion
	private function get_magnet():Bool;
	@:noCompletion
	private function set_magnet(value:Bool):Bool;
	var shift(get, set) : Bool;
	@:noCompletion
	private function get_shift():Bool;
	@:noCompletion
	private function set_shift(value:Bool):Bool;
	var zoomLevel(get, set) : Float;
	@:noCompletion
	private function get_zoomLevel():Float;
	@:noCompletion
	private function set_zoomLevel(value:Float):Float;
	var ready(get, never) : Bool;
	@:noCompletion
	private function get_ready():Bool;
	function beginEditing(pathItem:nanofl.ide.navigator.PathItem, ?isCenterView:Bool):Void;
	function switchTool<T:(nanofl.ide.editor.tools.EditorTool)>(clas:Class<T>):T;
	function updateShapes():Void;
	function updateElement(element:nanofl.engine.elements.Element):Void;
	function hasSelected():Bool;
	function toggleSelection():Bool;
	function select(obj:nanofl.engine.ISelectable, ?deselectOthers:Bool):Void;
	function selectWoUpdate(obj:nanofl.engine.ISelectable, ?deselectOthers:Bool):Void;
	function deselect(obj:nanofl.engine.ISelectable):Void;
	function deselectWoUpdate(obj:nanofl.engine.ISelectable):Void;
	function selectAll():Void;
	function deselectAll():Void;
	function deselectAllWoUpdate():Void;
	function selectLayers(layerIndexes:Array<Int>):Void;
	function isSelectedAtPos(pos:nanofl.engine.geom.Point):Bool;
	function getItemAtPos(pos:nanofl.engine.geom.Point):nanofl.ide.editor.elements.EditorElement;
	function getObjectAtPosEx(pos:nanofl.engine.geom.Point):{ var layerIndex : Int; var obj : nanofl.engine.ISelectable; };
	function breakApartSelected():Void;
	function removeSelected():Void;
	function translateSelected(dx:Float, dy:Float, ?lowLevel:Bool):Void;
	function updateTransformations():Void;
	function getItems(?includeShape:Bool):Array<nanofl.ide.editor.elements.EditorElement>;
	function getSelectedItems():Array<nanofl.ide.editor.elements.EditorElement>;
	function getObjectLayerIndex(obj:nanofl.engine.ISelectable):Int;
	function extractSelected():Array<nanofl.engine.elements.Element>;
	function isItemCanBeAdded(item:nanofl.ide.libraryitems.IIdeLibraryItem):Bool;
	function addElement(element:nanofl.engine.elements.Element, ?addUndoTransaction:Bool):nanofl.ide.editor.elements.EditorElement;
	function convertToSymbol():Void;
	function groupSelected():Void;
	function translateVertex(point:nanofl.engine.geom.Point, dx:Float, dy:Float, ?addUndoTransaction:Bool):Void;
	function rebind(?isCenterView:Bool):js.lib.Promise<{ }>;
	function update():Void;
	function showAllLayers():Void;
	function hideAllLayers():Void;
	function lockAllLayers():Void;
	function unlockAllLayers():Void;
	function getSelectedLayerIndexes():Array<Int>;
	function getPropertiesObject():nanofl.ide.PropertiesObject;
	function removeTransformFromSelected():Void;
	function moveSelectedFront():Void;
	function moveSelectedForwards():Void;
	function moveSelectedBackwards():Void;
	function moveSelectedBack():Void;
	function magnetSelectedToGuide(?invalidater:nanofl.ide.Invalidater):Void;
	function swapInstance(instance:nanofl.engine.elements.Instance, newNamePath:String):Void;
	function saveSelectedToXml(out:htmlparser.XmlBuilder):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function pasteFromXml(xml:htmlparser.XmlNodeElement, ?selectPasted:Bool):Bool;
	function duplicateSelected():Void;
	function getObjectsInRectangle(x:Float, y:Float, width:Float, height:Float):Array<nanofl.engine.ISelectable>;
	function flipSelectedHorizontal():Void;
	function flipSelectedVertical():Void;
	function getSelectedBounds():{ var height : Float; var width : Float; var x : Float; var y : Float; };
	function getHitTestGap():Float;
	function getEditableLayers():Array<nanofl.ide.editor.EditorLayer>;
	function getSingleSelectedInstance():nanofl.engine.elements.Instance;
	function saveViewState():Void;
	function loadViewState():Void;
}