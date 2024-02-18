package components.nanofl.popups.fontimportpopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var text(get, never) : js.JQuery;
	inline function get_text() return component.q('#text');
}