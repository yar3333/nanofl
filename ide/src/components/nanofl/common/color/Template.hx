package components.nanofl.common.color;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var color(get, never) : js.JQuery;
	inline function get_color() return component.q('#color');

	public function new(component:wquery.Component) this.component = component;
}
