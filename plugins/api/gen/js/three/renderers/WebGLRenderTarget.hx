package js.three.renderers;

@:native("THREE.WebGLRenderTarget") extern class WebGLRenderTarget<TTexture:(haxe.extern.EitherType<js.three.textures.Texture, Array<js.three.textures.Texture>>)> extends js.three.core.RenderTarget<TTexture> {
	function new(?width:Float, ?height:Float, ?options:js.three.renderers.WebGLRenderTargetOptions):Void;
	var isWebGLRenderTarget(default, null) : Bool;
}