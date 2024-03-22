package components.nanofl.properties.video;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var currentTime(get, never) : js.JQuery;
	inline function get_currentTime() return component.q("#currentTime");

	public var seekTo(get, never) : js.JQuery;
	inline function get_seekTo() return component.q("#seekTo");
}