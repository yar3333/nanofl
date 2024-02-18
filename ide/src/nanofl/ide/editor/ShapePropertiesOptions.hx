package nanofl.ide.editor;

class ShapePropertiesOptions
{
	public var strokePane(default, null) = false;
	public var fillPane(default, null) = false;
	public var roundRadiusPane(default, null) = false;
	public var noneStroke(default, null) = true;
	public var noneFill(default, null) = true;
	
	public function new() {}
	
	public function showStrokePane() : ShapePropertiesOptions { strokePane = true; return this; }
	public function showFillPane() : ShapePropertiesOptions { fillPane = true; return this; }
	public function showRoundRadiusPane() : ShapePropertiesOptions { roundRadiusPane = true; return this; }
	public function disallowNoneStroke() : ShapePropertiesOptions { noneStroke = false; return this; }
	public function disallowNoneFill() : ShapePropertiesOptions { noneFill = false; return this; }
}