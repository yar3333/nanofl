package components.nanofl.properties.positionandsize;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var x(get, never) : js.JQuery;
	inline function get_x() return component.q('#x');
	
	public var y(get, never) : js.JQuery;
	inline function get_y() return component.q('#y');
	
	public var w(get, never) : js.JQuery;
	inline function get_w() return component.q('#w');
	
	public var h(get, never) : js.JQuery;
	inline function get_h() return component.q('#h');
	
	public var rotationContainer(get, never) : js.JQuery;
	inline function get_rotationContainer() return component.q('#rotationContainer');
	
	public var r(get, never) : js.JQuery;
	inline function get_r() return component.q('#r');
}