package components.nanofl.properties.filters;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var usedFilters(get, never) : js.JQuery;
	inline function get_usedFilters() return component.q('#usedFilters');
	
	public var allFilters(get, never) : js.JQuery;
	inline function get_allFilters() return component.q('#allFilters');
	
	public var removeFilter(get, never) : js.JQuery;
	inline function get_removeFilter() return component.q('#removeFilter');
	
	public var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
	inline function get_customProperties() return cast component.children.customProperties;
}