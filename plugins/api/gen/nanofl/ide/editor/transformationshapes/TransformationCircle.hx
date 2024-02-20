package nanofl.ide.editor.transformationshapes;

extern class TransformationCircle extends nanofl.ide.editor.transformationshapes.BaseTransformationShape {
	function new():Void;
	var circleCenter(get, never) : nanofl.engine.geom.Point;
	private function get_circleCenter():nanofl.engine.geom.Point;
	var circleRadius : Float;
	var circleFocus(get, never) : nanofl.engine.geom.Point;
	private function get_circleFocus():nanofl.engine.geom.Point;
	var change(default, null) : stdlib.Event<ChangeEventArgs>;
}