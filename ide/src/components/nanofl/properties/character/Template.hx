package components.nanofl.properties.character;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var family(get, never) : js.JQuery;
	inline function get_family() return component.q('#family');
	
	public var style(get, never) : js.JQuery;
	inline function get_style() return component.q('#style');
	
	public var fillColor(get, never) : components.nanofl.common.color.Code;
	inline function get_fillColor() return cast component.children.fillColor;
	
	public var size(get, never) : components.nanofl.common.slider.Code;
	inline function get_size() return cast component.children.size;
	
	public var strokeSize(get, never) : js.JQuery;
	inline function get_strokeSize() return component.q('#strokeSize');
	
	public var strokeColor(get, never) : components.nanofl.common.color.Code;
	inline function get_strokeColor() return cast component.children.strokeColor;
	
	public var kerning(get, never) : js.JQuery;
	inline function get_kerning() return component.q('#kerning');
	
	public var letterSpacing(get, never) : js.JQuery;
	inline function get_letterSpacing() return component.q('#letterSpacing');
}