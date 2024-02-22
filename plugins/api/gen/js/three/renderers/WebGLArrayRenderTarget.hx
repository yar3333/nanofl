package js.three.renderers;

/**
 * This type of render target represents an array of textures.
 */
/**
	
	 * This type of render target represents an array of textures.
	 
**/
@:native("THREE.WebGLArrayRenderTarget") extern class WebGLArrayRenderTarget extends js.three.renderers.WebGLRenderTarget<js.three.textures.DataArrayTexture> {
	/**
		
			 * This type of render target represents an array of textures.
			 
	**/
	function new(?width:Float, ?height:Float, ?depth:Float, ?options:js.three.renderers.WebGLRenderTargetOptions):Void;
	/**
		
			 * The texture property is overwritten with an instance of {@link DataArrayTexture}.
			 
	**/
	var isWebGLArrayRenderTarget(default, null) : Bool;
}