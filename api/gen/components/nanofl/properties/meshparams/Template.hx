package components.nanofl.properties.meshparams;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var rotationX(get, never) : components.nanofl.common.slider.Code;
	var rotationY(get, never) : components.nanofl.common.slider.Code;
	var cameraFov(get, never) : components.nanofl.common.slider.Code;
	var ambientLightColor(get, never) : components.nanofl.common.color.Code;
	var directionalLightColor(get, never) : components.nanofl.common.color.Code;
	var directionalLightRotationX(get, never) : components.nanofl.common.slider.Code;
	var directionalLightRotationY(get, never) : components.nanofl.common.slider.Code;
}