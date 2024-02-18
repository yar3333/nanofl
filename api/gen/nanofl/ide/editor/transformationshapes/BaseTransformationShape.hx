package nanofl.ide.editor.transformationshapes;

extern class BaseTransformationShape extends easeljs.display.Container {
	function new():Void;
	var magnet : Bool;
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
}