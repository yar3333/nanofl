package components.nanofl.others.custompropertiespane.item_slider;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var sliderContainer(get, never) : js.JQuery;
	inline function get_sliderContainer() return component.q('#sliderContainer');
	
	public var slider(get, never) : components.nanofl.common.slider.Code;
	inline function get_slider() return cast component.children.slider;

	public function new(component:wquery.Component) this.component = component;
}