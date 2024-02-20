package components.nanofl.popups.aboutapplicationpopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var version(get, never) : js.JQuery;
	inline function get_version() return component.q('#version');
}