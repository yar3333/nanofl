package components.nanofl.library.libraryitem;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var item(get, never) : js.JQuery;
	inline function get_item() return component.q('#item');
	
	public var name(get, never) : js.JQuery;
	inline function get_name() return component.q('#name');
	
	public function new(component:wquery.Component) this.component = component;
}