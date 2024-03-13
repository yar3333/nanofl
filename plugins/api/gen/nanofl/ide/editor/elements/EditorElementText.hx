package nanofl.ide.editor.elements;

extern class EditorElementText extends nanofl.ide.editor.elements.EditorElementSelectBox {
	function new(layer:nanofl.ide.editor.EditorLayer, editor:nanofl.ide.editor.Editor, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, frame:nanofl.engine.movieclip.Frame, tweenedElement:nanofl.engine.movieclip.TweenedElement, track:nanofl.ide.ElementLifeTracker.ElementLifeTrack, framerate:Float):Void;
	var element(get, never) : nanofl.engine.elements.TextElement;
	@:noCompletion
	private function get_element():nanofl.engine.elements.TextElement;
	override function update():Void;
	override function getPropertiesObject(newObjectParams:nanofl.ide.editor.NewObjectParams):nanofl.ide.PropertiesObject;
	function beginEditing():Void;
	function endEditing():Void;
	function setSelectionFormat(format:nanofl.TextRun):Void;
	function getSelectionFormat():nanofl.TextRun;
	function setPosAndSize(obj:{ var height : Float; var width : Float; var x : Float; var y : Float; }):Void;
	function getMinSize():{ var height : Float; var width : Float; };
}