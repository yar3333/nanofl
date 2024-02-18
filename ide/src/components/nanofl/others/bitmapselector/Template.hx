package components.nanofl.others.bitmapselector;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var prev(get, never) : js.JQuery;
	inline function get_prev() return component.q('#prev');
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');
	
	public var image(get, never) : js.JQuery;
	inline function get_image() return component.q('#image');
	
	public var next(get, never) : js.JQuery;
	inline function get_next() return component.q('#next');

	public function new(component:wquery.Component) this.component = component;
}