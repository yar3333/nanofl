package components.nanofl.others.gradientselector;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');
	
	public var gradient(get, never) : js.JQuery;
	inline function get_gradient() return component.q('#gradient');
	
	public var controls(get, never) : js.JQuery;
	inline function get_controls() return component.q('#controls');
	
	public var color(get, never) : components.nanofl.common.color.Code;
	inline function get_color() return cast component.children.color;

	public function new(component:wquery.Component) this.component = component;
}