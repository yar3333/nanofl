package components.nanofl.others.custompropertiespane.item_int;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var value(get, never) : js.JQuery;
	inline function get_value() return component.q('#value');

	public function new(component:wquery.Component) this.component = component;
}