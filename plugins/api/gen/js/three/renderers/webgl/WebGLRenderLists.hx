package js.three.renderers.webgl;

@:native("THREE.WebGLRenderLists") extern class WebGLRenderLists {
	function new(properties:js.three.renderers.webgl.WebGLProperties):Void;
	function dispose():Void;
	function get(scene:js.three.scenes.Scene, renderCallDepth:Float):js.three.renderers.webgl.WebGLRenderList;
}