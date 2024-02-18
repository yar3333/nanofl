package components.nanofl.properties.fill;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var type(get, never) : js.JQuery;
	inline function get_type() return component.q('#type');
	
	public var color(get, never) : components.nanofl.common.color.Code;
	inline function get_color() return cast component.children.color;
	
	public var gradient(get, never) : components.nanofl.others.gradientselector.Code;
	inline function get_gradient() return cast component.children.gradient;
	
	public var bitmap(get, never) : components.nanofl.others.bitmapselector.Code;
	inline function get_bitmap() return cast component.children.bitmap;
	
	public var repeatContainer(get, never) : js.JQuery;
	inline function get_repeatContainer() return component.q('#repeatContainer');
	
	public var repeat(get, never) : js.JQuery;
	inline function get_repeat() return component.q('#repeat');
}