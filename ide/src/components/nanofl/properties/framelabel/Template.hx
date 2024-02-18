package components.nanofl.properties.framelabel;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var label(get, never) : js.JQuery;
	inline function get_label() return component.q('#label');
}