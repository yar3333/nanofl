package components.nanofl.properties.positionandsize;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var x(get, never) : js.JQuery;
	var y(get, never) : js.JQuery;
	var w(get, never) : js.JQuery;
	var h(get, never) : js.JQuery;
	var rotationContainer(get, never) : js.JQuery;
	var r(get, never) : js.JQuery;
}