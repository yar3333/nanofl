package components.nanofl.movie.zoomer;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var select(get, never) : js.JQuery;
	inline function get_select() return component.q('#select');

	public function new(component:wquery.Component) this.component = component;
}