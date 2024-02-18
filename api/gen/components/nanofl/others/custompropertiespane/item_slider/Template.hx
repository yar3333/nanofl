package components.nanofl.others.custompropertiespane.item_slider;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var sliderContainer(get, never) : js.JQuery;
	var slider(get, never) : components.nanofl.common.slider.Code;
}