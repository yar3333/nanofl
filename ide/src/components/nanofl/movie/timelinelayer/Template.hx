package components.nanofl.movie.timelinelayer;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var layerRow(get, never) : js.JQuery;
	inline function get_layerRow() return component.q('#layerRow');
	
	public var icon(get, never) : js.JQuery;
	inline function get_icon() return component.q('#icon');
	
	public var title(get, never) : js.JQuery;
	inline function get_title() return component.q('#title');
	
	public var edited(get, never) : js.JQuery;
	inline function get_edited() return component.q('#edited');
	
	public var visible(get, never) : js.JQuery;
	inline function get_visible() return component.q('#visible');
	
	public var locked(get, never) : js.JQuery;
	inline function get_locked() return component.q('#locked');
	
	public var framesContent(get, never) : js.JQuery;
	inline function get_framesContent() return component.q('#framesContent');

	public function new(component:wquery.Component) this.component = component;
}