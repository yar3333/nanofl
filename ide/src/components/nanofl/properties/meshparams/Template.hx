package components.nanofl.properties.meshparams;

@:access(wquery.Component)
class Template extends components.nanofl.properties.base.Template
{
	public var rotationX(get, never) : components.nanofl.common.slider.Code;
	inline function get_rotationX() return cast component.children.rotationX;
	
	public var rotationY(get, never) : components.nanofl.common.slider.Code;
	inline function get_rotationY() return cast component.children.rotationY;
	
	public var cameraFov(get, never) : components.nanofl.common.slider.Code;
	inline function get_cameraFov() return cast component.children.cameraFov;
	
	public var ambientLightColor(get, never) : components.nanofl.common.color.Code;
	inline function get_ambientLightColor() return cast component.children.ambientLightColor;
	
	public var directionalLightColor(get, never) : components.nanofl.common.color.Code;
	inline function get_directionalLightColor() return cast component.children.directionalLightColor;

	public var directionalLightRotationX(get, never) : components.nanofl.common.slider.Code;
	inline function get_directionalLightRotationX() return cast component.children.directionalLightRotationX;

	public var directionalLightRotationY(get, never) : components.nanofl.common.slider.Code;
	inline function get_directionalLightRotationY() return cast component.children.directionalLightRotationY;
}