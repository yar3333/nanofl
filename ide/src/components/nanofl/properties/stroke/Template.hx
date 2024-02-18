package components.nanofl.properties.stroke;

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
	
	public var thickness(get, never) : components.nanofl.common.slider.Code;
	inline function get_thickness() return cast component.children.thickness;
	
	public var ignoreScale(get, never) : js.JQuery;
	inline function get_ignoreScale() return component.q('#ignoreScale');
	
	public var caps(get, never) : js.JQuery;
	inline function get_caps() return component.q('#caps');
	
	public var joints(get, never) : js.JQuery;
	inline function get_joints() return component.q('#joints');
	
	public var miterLimit(get, never) : components.nanofl.common.slider.Code;
	inline function get_miterLimit() return cast component.children.miterLimit;
}