package components.nanofl.properties.paragraph;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var align(get, never) : js.JQuery;
	inline function get_align() return component.q('#align');
	
	public var lineSpacing(get, never) : js.JQuery;
	inline function get_lineSpacing() return component.q('#lineSpacing');
}