package components.nanofl.popups.registerpopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var trialMessage(get, never) : js.JQuery;
	inline function get_trialMessage() return component.q('#trialMessage');
	
	public var key(get, never) : js.JQuery;
	inline function get_key() return component.q('#key');
	
	public var register(get, never) : js.JQuery;
	inline function get_register() return component.q('#register');
}