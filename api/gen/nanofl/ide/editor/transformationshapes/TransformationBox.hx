package nanofl.ide.editor.transformationshapes;

extern class TransformationBox extends nanofl.ide.editor.transformationshapes.BaseTransformationShape {
	function new():Void;
	var minWidth : Float;
	var minHeight : Float;
	var width : Float;
	var height : Float;
	var regPointX(get, set) : Float;
	private function get_regPointX():Float;
	private function set_regPointX(v:Float):Float;
	var regPointY(get, set) : Float;
	private function get_regPointY():Float;
	private function set_regPointY(v:Float):Float;
	var rotateCursorUrl : String;
	var resize(default, null) : stdlib.Event<ResizeEventArgs>;
	var rotate(default, null) : stdlib.Event<RotateEventArgs>;
	var changeRegPoint(default, null) : stdlib.Event<{ }>;
	var move(default, null) : stdlib.Event<MoveEventArgs>;
	var barMove(default, null) : stdlib.Event<BarMoveEventArgs>;
	var defaultRegPointX : Float;
	var defaultRegPointY : Float;
	var enableRegPoint : Bool;
	var enableRotatePoint : Bool;
	var enableTranslatePoint : Bool;
	var enableBars : Bool;
	var translatePointPositionX : String;
	var translatePointPositionY : String;
	var topBarPosition : Float;
	var rightBarPosition : Float;
	var bottomBarPosition : Float;
	var leftBarPosition : Float;
}