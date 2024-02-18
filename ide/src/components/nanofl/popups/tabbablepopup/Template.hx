package components.nanofl.popups.tabbablepopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var tabbable(get, never) : js.JQuery;
	inline function get_tabbable() return component.q('#tabbable');
	
	public var parts(get, never) : js.JQuery;
	inline function get_parts() return component.q('#parts');
	
	public var panes(get, never) : js.JQuery;
	inline function get_panes() return component.q('#panes');
}