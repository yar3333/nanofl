package nanofl.ide.editor.elements;

extern class EditorElementSelectBox extends nanofl.ide.editor.elements.EditorElement {
	function new(layer:nanofl.ide.editor.EditorLayer, editor:nanofl.ide.editor.Editor, navigator:nanofl.ide.navigator.Navigator, view:nanofl.ide.ui.View, frame:nanofl.engine.movieclip.Frame, tweenedElement:nanofl.engine.movieclip.TweenedElement, track:nanofl.ide.ElementLifeTracker.ElementLifeTrack, framerate:Float):Void;
	override function updateTransformations():Void;
	override function onClick(e:easeljs.events.MouseEvent):Void;
	override function onMouseDown(e:easeljs.events.MouseEvent):Void;
	override function onMouseUp(e:easeljs.events.MouseEvent):Void;
	override function onDoubleClick(e:easeljs.events.MouseEvent):Void;
}