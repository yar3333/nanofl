package nanofl.ide.editor.elements;

extern class EditorElementInstance extends nanofl.ide.editor.elements.EditorElementSelectBox {
	function new(layer:nanofl.ide.editor.EditorLayer, editor:nanofl.ide.editor.Editor, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, frame:nanofl.engine.movieclip.Frame, tweenedElement:nanofl.engine.movieclip.TweenedElement, track:nanofl.ide.ElementLifeTracker.ElementLifeTrack, framerate:Float):Void;
	var element(get, never) : nanofl.engine.elements.Instance;
	@:noCompletion
	private function get_element():nanofl.engine.elements.Instance;
	override function getPropertiesObject(newObjectParams:nanofl.ide.editor.NewObjectParams):nanofl.ide.PropertiesObject;
}