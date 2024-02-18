package components.nanofl.others.mainmenu;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var subContainer(get, never) : js.JQuery;
	inline function get_subContainer() return component.q('#subContainer');
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');

	public function new(component:wquery.Component) this.component = component;
}