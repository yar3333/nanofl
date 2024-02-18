package components.nanofl.popups.basepopup;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var overlay(get, never) : js.JQuery;
	inline function get_overlay() return component.q('#overlay');
	
	public var popup(get, never) : js.JQuery;
	inline function get_popup() return component.q('#popup');
	
	public var close(get, never) : js.JQuery;
	inline function get_close() return component.q('#close');
	
	public var title(get, never) : js.JQuery;
	inline function get_title() return component.q('#title');
	
	public var ok(get, never) : js.JQuery;
	inline function get_ok() return component.q('#ok');
	
	public var cancel(get, never) : js.JQuery;
	inline function get_cancel() return component.q('#cancel');

	public function new(component:wquery.Component) this.component = component;
}