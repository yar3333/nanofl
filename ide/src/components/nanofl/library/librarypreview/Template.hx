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
	
	public var video(get, never) : js.JQuery;
	inline function get_video() return component.q('#video');

	public function new(component:wquery.Component) this.component = component;
}