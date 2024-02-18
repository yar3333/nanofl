package nanofl.ide.editor.transformationshapes;

extern class TransformationVector extends nanofl.ide.editor.transformationshapes.BaseTransformationShape {
	function new():Void;
	var pt1(get, never) : nanofl.engine.geom.Point;
	private function get_pt1():nanofl.engine.geom.Point;
	var pt2(get, never) : nanofl.engine.geom.Point;
	private function get_pt2():nanofl.engine.geom.Point;
	var change(default, null) : stdlib.Event<ChangeEventArgs>;
}