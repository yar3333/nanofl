package components.nanofl.others.statusbar;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');

	public function new(component:wquery.Component) this.component = component;
}