package components.nanofl.popups.hotkeyshelppopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var pane(get, never) : js.JQuery;
	inline function get_pane() return component.q('#pane');
	
	public var hotkeys(get, never) : js.JQuery;
	inline function get_hotkeys() return component.q('#hotkeys');
}