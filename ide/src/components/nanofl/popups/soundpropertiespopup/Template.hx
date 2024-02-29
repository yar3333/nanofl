package components.nanofl.popups.soundpropertiespopup;

@:access(wquery.Component)
class Template extends components.nanofl.popups.basepopup.Template
{
	public var loop(get, never) : js.JQuery;
	inline function get_loop() return component.q('#loop');

	public var linkage(get, never) : js.JQuery;
	inline function get_linkage() return component.q('#linkage');
}