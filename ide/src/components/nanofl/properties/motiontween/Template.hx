package components.nanofl.properties.motiontween;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var easing(get, never) : components.nanofl.common.slider.Code;
	inline function get_easing() return cast component.children.easing;
	
	public var rotateCount(get, never) : js.JQuery;
	inline function get_rotateCount() return component.q('#rotateCount');
	
	public var orientToPath(get, never) : js.JQuery;
	inline function get_orientToPath() return component.q('#orientToPath');
	
	public var rotateCountXContainer(get, never) : js.JQuery;
	inline function get_rotateCountXContainer() return component.q('#rotateCountXContainer');
	
	public var rotateCountX(get, never) : js.JQuery;
	inline function get_rotateCountX() return component.q('#rotateCountX');
	
	public var rotateCountYContainer(get, never) : js.JQuery;
	inline function get_rotateCountYContainer() return component.q('#rotateCountYContainer');
	
	public var rotateCountY(get, never) : js.JQuery;
	inline function get_rotateCountY() return component.q('#rotateCountY');
}