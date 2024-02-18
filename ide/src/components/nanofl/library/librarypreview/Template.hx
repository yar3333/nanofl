package components.nanofl.library.librarypreview;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var canvas(get, never) : js.JQuery;
	inline function get_canvas() return component.q('#canvas');
	
	public var sound(get, never) : js.JQuery;
	inline function get_sound() return component.q('#sound');

	public function new(component:wquery.Component) this.component = component;
}