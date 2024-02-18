package components.nanofl.properties.display;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var blendMode(get, never) : js.JQuery;
	inline function get_blendMode() return component.q('#blendMode');
}