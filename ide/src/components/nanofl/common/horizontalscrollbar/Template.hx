package components.nanofl.common.horizontalscrollbar;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var bar(get, never) : js.JQuery;
	inline function get_bar() return component.q('#bar');

	public function new(component:wquery.Component) this.component = component;
}