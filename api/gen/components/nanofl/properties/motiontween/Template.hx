package components.nanofl.properties.motiontween;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var easing(get, never) : components.nanofl.common.slider.Code;
	var rotateCount(get, never) : js.JQuery;
	var orientToPath(get, never) : js.JQuery;
	var rotateCountXContainer(get, never) : js.JQuery;
	var rotateCountX(get, never) : js.JQuery;
	var rotateCountYContainer(get, never) : js.JQuery;
	var rotateCountY(get, never) : js.JQuery;
}