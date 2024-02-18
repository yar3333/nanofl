package components.nanofl.common.slider;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var label(get, never) : js.JQuery;
	inline function get_label() return component.q('#label');
	
	public var slider(get, never) : js.JQuery;
	inline function get_slider() return component.q('#slider');
	
	public var value(get, never) : js.JQuery;
	inline function get_value() return component.q('#value');
	
	public var units(get, never) : js.JQuery;
	inline function get_units() return component.q('#units');

	public function new(component:wquery.Component) this.component = component;
}