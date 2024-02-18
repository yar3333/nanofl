package components.nanofl.library.libraryitems;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');
	
	public var contextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_contextMenu() return cast component.children.contextMenu;

	public function new(component:wquery.Component) this.component = component;
}