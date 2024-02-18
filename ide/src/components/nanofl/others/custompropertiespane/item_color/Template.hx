package components.nanofl.others.custompropertiespane.item_color;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var colorContainer(get, never) : js.JQuery;
	inline function get_colorContainer() return component.q('#colorContainer');
	
	public var colorSelector(get, never) : components.nanofl.common.color.Code;
	inline function get_colorSelector() return cast component.children.colorSelector;

	public function new(component:wquery.Component) this.component = component;
}