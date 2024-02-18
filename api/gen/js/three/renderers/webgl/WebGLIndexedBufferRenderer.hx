package js.three.renderers.webgl;

@:native("THREE.WebGLIndexedBufferRenderer") extern class WebGLIndexedBufferRenderer {
	function new(gl:js.html.webgl.RenderingContext, extensions:Dynamic, info:Dynamic, capabilities:Dynamic):Void;
	var setMode : Dynamic -> Void;
	var setIndex : Dynamic -> Void;
	var render : (Dynamic, Float) -> Void;
	var renderInstances : (Dynamic, Float, Float) -> Void;
	var renderMultiDraw : (js.lib.Int32Array, js.lib.Int32Array, Float) -> Void;
}