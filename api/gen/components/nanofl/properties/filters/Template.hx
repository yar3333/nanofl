package components.nanofl.properties.filters;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var usedFilters(get, never) : js.JQuery;
	var allFilters(get, never) : js.JQuery;
	var removeFilter(get, never) : js.JQuery;
	var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
}