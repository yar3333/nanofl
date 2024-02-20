package js.three.renderers.webgl;

@:native("THREE.WebGLCubeUVMaps") extern class WebGLCubeUVMaps {
	function new(renderer:js.three.renderers.WebGLRenderer):Void;
	@:optional
	var Texture : Dynamic;
	var T : Dynamic;
	function get<T:(Dynamic)>(texture:T):T;
	function dispose():Void;
}