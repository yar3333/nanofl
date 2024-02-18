package components.nanofl.others.draganddrop;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var iconText(get, never) : js.JQuery;
	inline function get_iconText() return component.q('#iconText');
	
	public var icon(get, never) : js.JQuery;
	inline function get_icon() return component.q('#icon');
	
	public var text(get, never) : js.JQuery;
	inline function get_text() return component.q('#text');
	
	public var rectangle(get, never) : js.JQuery;
	inline function get_rectangle() return component.q('#rectangle');

	public function new(component:wquery.Component) this.component = component;
}