package components.nanofl.properties.coloreffect;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var type(get, never) : js.JQuery;
	inline function get_type() return component.q('#type');
	
	public var color(get, never) : components.nanofl.common.color.Code;
	inline function get_color() return cast component.children.color;
	
	public var colorEffects(get, never) : js.JQuery;
	inline function get_colorEffects() return component.q('#colorEffects');
	
	public var brightness(get, never) : components.nanofl.common.slider.Code;
	inline function get_brightness() return cast component.children.brightness;
	
	public var tint(get, never) : components.nanofl.common.slider.Code;
	inline function get_tint() return cast component.children.tint;
	
	public var colorMulA(get, never) : js.JQuery;
	inline function get_colorMulA() return component.q('#colorMulA');
	
	public var colorAddA(get, never) : js.JQuery;
	inline function get_colorAddA() return component.q('#colorAddA');
	
	public var colorMulR(get, never) : js.JQuery;
	inline function get_colorMulR() return component.q('#colorMulR');
	
	public var colorAddR(get, never) : js.JQuery;
	inline function get_colorAddR() return component.q('#colorAddR');
	
	public var colorMulG(get, never) : js.JQuery;
	inline function get_colorMulG() return component.q('#colorMulG');
	
	public var colorAddG(get, never) : js.JQuery;
	inline function get_colorAddG() return component.q('#colorAddG');
	
	public var colorMulB(get, never) : js.JQuery;
	inline function get_colorMulB() return component.q('#colorMulB');
	
	public var colorAddB(get, never) : js.JQuery;
	inline function get_colorAddB() return component.q('#colorAddB');
	
	public var alpha(get, never) : components.nanofl.common.slider.Code;
	inline function get_alpha() return cast component.children.alpha;
}