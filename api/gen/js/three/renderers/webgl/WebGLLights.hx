package js.three.renderers.webgl;

@:native("THREE.WebGLLights") extern class WebGLLights {
	function new(extensions:js.three.renderers.webgl.WebGLExtensions, capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	var state : js.three.renderers.webgl.WebGLLightsState;
	function get(light:Dynamic):Dynamic;
	function setup(lights:Dynamic):Void;
	function setupView(lights:Dynamic, camera:Dynamic):Void;
}