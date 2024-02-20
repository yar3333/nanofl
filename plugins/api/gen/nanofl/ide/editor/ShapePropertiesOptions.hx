package nanofl.ide.editor;

extern class ShapePropertiesOptions {
	function new():Void;
	var strokePane(default, null) : Bool;
	var fillPane(default, null) : Bool;
	var roundRadiusPane(default, null) : Bool;
	var noneStroke(default, null) : Bool;
	var noneFill(default, null) : Bool;
	function showStrokePane():nanofl.ide.editor.ShapePropertiesOptions;
	function showFillPane():nanofl.ide.editor.ShapePropertiesOptions;
	function showRoundRadiusPane():nanofl.ide.editor.ShapePropertiesOptions;
	function disallowNoneStroke():nanofl.ide.editor.ShapePropertiesOptions;
	function disallowNoneFill():nanofl.ide.editor.ShapePropertiesOptions;
}