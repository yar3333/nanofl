package js.three.renderers;

@:native("THREE.WebGLMultipleRenderTargets") extern class WebGLMultipleRenderTargets extends js.three.renderers.WebGLRenderTarget<Array<js.three.textures.Texture>> {
	function new(?width:Float, ?height:Float, ?count:Int, ?options:js.three.renderers.WebGLRenderTargetOptions):Void;
	var isWebGLMultipleRenderTargets(default, null) : Bool;
}