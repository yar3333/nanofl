package js.three.renderers.webgl;

@:native("THREE.WebGLBufferRenderer") extern class WebGLBufferRenderer {
	function new(gl:js.html.webgl.RenderingContext, extensions:js.three.renderers.webgl.WebGLExtensions, info:js.three.renderers.webgl.WebGLInfo, capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	var setMode : Dynamic -> Void;
	var render : (Dynamic, Float) -> Void;
	var renderInstances : (Dynamic, Float, Float) -> Void;
	var renderMultiDraw : (js.lib.Int32Array, js.lib.Int32Array, Float) -> Void;
}