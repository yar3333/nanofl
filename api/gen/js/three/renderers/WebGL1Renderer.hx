package js.three.renderers;

@:native("THREE.WebGL1Renderer") extern class WebGL1Renderer extends js.three.renderers.WebGLRenderer {
	function new(?parameters:js.three.renderers.WebGLRendererParameters):Void;
	var isWebGL1Renderer(default, null) : Bool;
}