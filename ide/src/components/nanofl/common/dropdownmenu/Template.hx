package components.nanofl.common.dropdownmenu;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var shadow(get, never) : js.JQuery;
	inline function get_shadow() return component.q('#shadow');
	
	public var menu(get, never) : js.JQuery;
	inline function get_menu() return component.q('#menu');

	public function new(component:wquery.Component) this.component = component;
}