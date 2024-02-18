package nanofl.ide.editor.elements;

extern class EditorElementGroup extends nanofl.ide.editor.elements.EditorElementSelectBox {
	function new(layer:nanofl.ide.editor.EditorLayer, editor:nanofl.ide.editor.Editor, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, frame:nanofl.engine.movieclip.Frame, tweenedElement:nanofl.engine.movieclip.TweenedElement):Void;
	var element(get, never) : nanofl.engine.elements.GroupElement;
	@:noCompletion
	private function get_element():nanofl.engine.elements.GroupElement;
	override function getPropertiesObject(newObjectParams:nanofl.ide.editor.NewObjectParams):nanofl.ide.PropertiesObject;
}