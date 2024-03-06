package nanofl.ide.editor.elements;

extern class EditorElement implements nanofl.engine.ISelectable {
	var frame(default, null) : nanofl.engine.movieclip.Frame;
	var originalElement(default, null) : nanofl.engine.elements.Element;
	var currentElement(default, null) : nanofl.engine.elements.Element;
	var metaDispObj(default, null) : easeljs.display.Container;
	var selected(get, set) : Bool;
	private function get_selected():Bool;
	private function set_selected(v:Bool):Bool;
	var width(get, set) : Float;
	var height(get, set) : Float;
	function updateTransformations():Void;
	function update():Void;
	function getBounds():easeljs.geom.Rectangle;
	function getTransformedBounds():easeljs.geom.Rectangle;
	function hitTest(pos:nanofl.engine.geom.Point):Bool;
	function getPropertiesObject(newObjectParams:nanofl.ide.editor.NewObjectParams):nanofl.ide.PropertiesObject;
	private function get_width():Float;
	private function set_width(v:Float):Float;
	private function get_height():Float;
	private function set_height(v:Float):Float;
	function onClick(e:easeljs.events.MouseEvent):Void;
	function onMouseDown(e:easeljs.events.MouseEvent):Void;
	function onMouseUp(e:easeljs.events.MouseEvent):Void;
	function onDoubleClick(e:easeljs.events.MouseEvent):Void;
	static function create(layer:nanofl.ide.editor.EditorLayer, editor:nanofl.ide.editor.Editor, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, frame:nanofl.engine.movieclip.Frame, tweenedElement:nanofl.engine.movieclip.TweenedElement):nanofl.ide.editor.elements.EditorElement;
}