package js.three.renderers;

@:native("THREE.WebGLCubeRenderTarget") extern class WebGLCubeRenderTarget extends js.three.renderers.WebGLRenderTarget<js.three.textures.CubeTexture> {
	function new(?size:Float, ?options:js.three.renderers.WebGLRenderTargetOptions):Void;
	function fromEquirectangularTexture(renderer:js.three.renderers.WebGLRenderer, texture:js.three.textures.Texture):js.three.renderers.WebGLCubeRenderTarget;
	function clear(renderer:js.three.renderers.WebGLRenderer, color:Bool, depth:Bool, stencil:Bool):Void;
}