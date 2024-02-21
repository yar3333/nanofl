package js.three.renderers.webgl;

@:native("THREE.WebGLShadowMap") extern class WebGLShadowMap {
	function new(_renderer:js.three.renderers.WebGLRenderer, _objects:js.three.renderers.webgl.WebGLObjects, _capabilities:js.three.renderers.webgl.WebGLCapabilities):Void;
	/**
		
			 * @default false
			 
	**/
	var enabled : Bool;
	/**
		
			 * @default true
			 
	**/
	var autoUpdate : Bool;
	/**
		
			 * @default false
			 
	**/
	var needsUpdate : Bool;
	/**
		
			 * @default THREE.PCFShadowMap
			 
	**/
	var type : js.three.ShadowMapType;
	/**
		
			 * @deprecated Use {@link Material#shadowSide} instead.
			 
	**/
	var cullFace : Dynamic;
	function render(shadowsArray:Array<js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>>, scene:js.three.scenes.Scene, camera:js.three.cameras.Camera):Void;
}