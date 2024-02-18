package js.three.renderers.webgl;

@:native("THREE.WebGLTextures") extern class WebGLTextures {
	function new(gl:js.html.webgl.RenderingContext, extensions:js.three.renderers.webgl.WebGLExtensions, state:js.three.renderers.webgl.WebGLState, properties:js.three.renderers.webgl.WebGLProperties, capabilities:js.three.renderers.webgl.WebGLCapabilities, utils:js.three.renderers.webgl.WebGLUtils, info:js.three.renderers.webgl.WebGLInfo):Void;
	function allocateTextureUnit():Void;
	function resetTextureUnits():Void;
	function setTexture2D(texture:Dynamic, slot:Float):Void;
	function setTexture2DArray(texture:Dynamic, slot:Float):Void;
	function setTexture3D(texture:Dynamic, slot:Float):Void;
	function setTextureCube(texture:Dynamic, slot:Float):Void;
	function setupRenderTarget(renderTarget:Dynamic):Void;
	function updateRenderTargetMipmap(renderTarget:Dynamic):Void;
	function updateMultisampleRenderTarget(renderTarget:Dynamic):Void;
	function safeSetTexture2D(texture:Dynamic, slot:Float):Void;
	function safeSetTextureCube(texture:Dynamic, slot:Float):Void;
}