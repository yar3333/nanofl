package components.nanofl.popups.promptpopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var label(get, never) : js.JQuery;
	inline function get_label() return component.q('#label');
	
	public var text(get, never) : js.JQuery;
	inline function get_text() return component.q('#text');
}