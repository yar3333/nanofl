package components.nanofl.others.openedfiles;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var toggleMenu(get, never) : js.JQuery;
	inline function get_toggleMenu() return component.q('#toggleMenu');
	
	public var menu(get, never) : components.nanofl.common.dropdownmenu.Code;
	inline function get_menu() return cast component.children.menu;
	
	public var tabs(get, never) : js.JQuery;
	inline function get_tabs() return component.q('#tabs');
	
	public function new(component:wquery.Component) this.component = component;
}