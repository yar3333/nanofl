package components.nanofl.popups.symboladdpopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var name(get, never) : js.JQuery;
	inline function get_name() return component.q('#name');
	
	public var registration(get, never) : js.JQuery;
	inline function get_registration() return component.q('#registration');
}