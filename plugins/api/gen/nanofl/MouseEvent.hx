package nanofl;

extern class MouseEvent {
	function new(stageX:Float, stageY:Float):Void;
	var canceled : Bool;
	var stageX(default, null) : Float;
	var stageY(default, null) : Float;
	function cancel():Void;
	var _target : easeljs.display.DisplayObject;
	var localX(default, never) : Float;
	var localY(default, never) : Float;
}