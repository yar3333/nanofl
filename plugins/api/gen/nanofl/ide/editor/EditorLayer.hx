package nanofl.ide.editor;

extern class EditorLayer {
	var editable(get, never) : Bool;
	@:noCompletion
	private function get_editable():Bool;
	var parentIndex(get, never) : Int;
	private function get_parentIndex():Int;
	var type(get, never) : nanofl.engine.LayerType;
	private function get_type():nanofl.engine.LayerType;
	var shape : nanofl.ide.editor.elements.EditorElementShape;
	var container : easeljs.display.Container;
	function addElements(elements:Array<nanofl.engine.elements.Element>, ?index:Int):Array<nanofl.ide.editor.elements.EditorElement>;
	function removeSelected():Void;
	function hasItem(item:nanofl.ide.editor.elements.EditorElement):Bool;
	function show():Void;
	function hide():Void;
	function lock():Void;
	function unlock():Void;
	function getItemAtPos(pos:nanofl.engine.geom.Point):nanofl.ide.editor.elements.EditorElement;
	function getEditablessReason():String;
	function getIndex():Int;
	function getTweenedElements(frameIndex:Int):Array<nanofl.engine.movieclip.TweenedElement>;
	function getChildLayers():Array<nanofl.ide.editor.EditorLayer>;
	function getElementIndex(element:nanofl.engine.elements.Element):Int;
	function getElementByIndex(elementIndex:Int):nanofl.engine.elements.Element;
	function getElementsState():{ var elements : Array<nanofl.engine.elements.Element>; };
	function duplicateSelected():Void;
	function isShowSelection():Bool;
	function addElement(element:nanofl.engine.elements.Element, ?index:Int):nanofl.ide.editor.elements.EditorElement;
	function getElements(?r:Array<nanofl.ide.editor.elements.EditorElement>, ?includeShape:Bool):Array<nanofl.ide.editor.elements.EditorElement>;
	function getSelectedElements(?r:Array<nanofl.ide.editor.elements.EditorElement>):Array<nanofl.ide.editor.elements.EditorElement>;
	function hasSelected():Bool;
	function isAllSelected():Bool;
	function selectAll():Void;
	function deselectAll():Void;
	function breakApartSelectedItems():Void;
	function moveSelectedFront():Void;
	function moveSelectedForwards():Void;
	function moveSelectedBackwards():Void;
	function moveSelectedBack():Void;
	function magnetSelectedToGuide():Void;
	function update():Void;
	function getVertexAtPos(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	function getEdgeAtPos(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Edge;
	function getStrokeEdgeAtPos(pos:nanofl.engine.geom.Point):nanofl.engine.geom.StrokeEdge;
	function getPolygonEdgeAtPos(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Edge;
	function getPolygonAtPos(pt:nanofl.engine.geom.Point):nanofl.engine.geom.Polygon;
	function getObjectAtPos(pos:nanofl.engine.geom.Point):nanofl.engine.ISelectable;
	function getInstanceTrack(instance:nanofl.engine.elements.Instance):nanofl.engine.ElementLifeTrack;
}