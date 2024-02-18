package components.nanofl.library.libraryview;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var preview(get, never) : components.nanofl.library.librarypreview.Code;
	inline function get_preview() return cast component.children.preview;
	
	public var centerContainer(get, never) : js.JQuery;
	inline function get_centerContainer() return component.q('#centerContainer');
	
	public var items(get, never) : components.nanofl.library.libraryitems.Code;
	inline function get_items() return cast component.children.items;

	public function new(component:wquery.Component) this.component = component;
}