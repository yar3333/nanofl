package components.nanofl.popups.fontpropertiespopup.item;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var row(get, never) : js.JQuery;
	inline function get_row() return component.q('#row');
	
	public var style(get, never) : js.JQuery;
	inline function get_style() return component.q('#style');
	
	public var weight(get, never) : js.JQuery;
	inline function get_weight() return component.q('#weight');
	
	public var locals(get, never) : js.JQuery;
	inline function get_locals() return component.q('#locals');
	
	public var formatAndUrls(get, never) : js.JQuery;
	inline function get_formatAndUrls() return component.q('#formatAndUrls');
	
	public var removeVariant(get, never) : js.JQuery;
	inline function get_removeVariant() return component.q('#removeVariant');
	
	public function new(component:wquery.Component) this.component = component;
}