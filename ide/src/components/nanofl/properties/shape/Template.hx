package components.nanofl.properties.shape;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var radius(get, never) : components.nanofl.common.slider.Code;
	inline function get_radius() return cast component.children.radius;
}