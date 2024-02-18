package components.nanofl.others.properties;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var nothing(get, never) : components.nanofl.properties.nothing.Code;
	var instance(get, never) : components.nanofl.properties.instance.Code;
	var positionAndSize(get, never) : components.nanofl.properties.positionandsize.Code;
	var colorEffect(get, never) : components.nanofl.properties.coloreffect.Code;
	var display(get, never) : components.nanofl.properties.display.Code;
	var filters(get, never) : components.nanofl.properties.filters.Code;
	var character(get, never) : components.nanofl.properties.character.Code;
	var paragraph(get, never) : components.nanofl.properties.paragraph.Code;
	var stroke(get, never) : components.nanofl.properties.stroke.Code;
	var fill(get, never) : components.nanofl.properties.fill.Code;
	var shape(get, never) : components.nanofl.properties.shape.Code;
	var frameLabel(get, never) : components.nanofl.properties.framelabel.Code;
	var motionTween(get, never) : components.nanofl.properties.motiontween.Code;
	var meshParams(get, never) : components.nanofl.properties.meshparams.Code;
}