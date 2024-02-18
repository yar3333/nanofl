package components.nanofl.properties.instance;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var name(get, never) : js.JQuery;
	inline function get_name() return component.q('#name');
	
	public var namePathContainer(get, never) : js.JQuery;
	inline function get_namePathContainer() return component.q('#namePathContainer');
	
	public var namePath(get, never) : js.JQuery;
	inline function get_namePath() return component.q('#namePath');
}