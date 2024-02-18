package js.three.renderers;

/**
 * Represents a three-dimensional render target.
 */
/**
	
	 * Represents a three-dimensional render target.
	 
**/
@:native("THREE.WebGL3DRenderTarget") extern class WebGL3DRenderTarget extends js.three.renderers.WebGLRenderTarget<js.three.textures.Data3DTexture> {
	/**
		
			 * Represents a three-dimensional render target.
			 
	**/
	function new(?width:Float, ?height:Float, ?depth:Float, ?options:js.three.renderers.WebGLRenderTargetOptions):Void;
	/**
		
			 * The texture property is overwritten with an instance of {@link Data3DTexture}.
			 
	**/
	var isWebGL3DRenderTarget(default, null) : Bool;
}