package components.nanofl.properties.coloreffect;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var type(get, never) : js.JQuery;
	var color(get, never) : components.nanofl.common.color.Code;
	var colorEffects(get, never) : js.JQuery;
	var brightness(get, never) : components.nanofl.common.slider.Code;
	var tint(get, never) : components.nanofl.common.slider.Code;
	var colorMulA(get, never) : js.JQuery;
	var colorAddA(get, never) : js.JQuery;
	var colorMulR(get, never) : js.JQuery;
	var colorAddR(get, never) : js.JQuery;
	var colorMulG(get, never) : js.JQuery;
	var colorAddG(get, never) : js.JQuery;
	var colorMulB(get, never) : js.JQuery;
	var colorAddB(get, never) : js.JQuery;
	var alpha(get, never) : components.nanofl.common.slider.Code;
}