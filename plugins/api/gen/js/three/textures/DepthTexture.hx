package js.three.textures;

/**
 * This class can be used to automatically save the depth information of a rendering into a texture
 * @remarks
 * When using a **WebGL1** rendering context, {@link DepthTexture} requires support for the
 * {@link https://www.khronos.org/registry/webgl/extensions/WEBGL_depth_texture/ | WEBGL_depth_texture} extension.
 * @see Example: {@link https://threejs.org/examples/#webgl_depth_texture | depth / texture}
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DepthTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DepthTexture.js | Source}
 */
/**
	
	 * This class can be used to automatically save the depth information of a rendering into a texture
	 * @remarks
	 * When using a **WebGL1** rendering context, {@link DepthTexture} requires support for the
	 * {@link https://www.khronos.org/registry/webgl/extensions/WEBGL_depth_texture/ | WEBGL_depth_texture} extension.
	 * @see Example: {@link https://threejs.org/examples/#webgl_depth_texture | depth / texture}
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DepthTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DepthTexture.js | Source}
	 
**/
@:native("THREE.DepthTexture") extern class DepthTexture extends js.three.textures.Texture {
	/**
		
			 * This class can be used to automatically save the depth information of a rendering into a texture
			 * @remarks
			 * When using a **WebGL1** rendering context, {@link DepthTexture} requires support for the
			 * {@link https://www.khronos.org/registry/webgl/extensions/WEBGL_depth_texture/ | WEBGL_depth_texture} extension.
			 * @see Example: {@link https://threejs.org/examples/#webgl_depth_texture | depth / texture}
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DepthTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DepthTexture.js | Source}
			 
	**/
	function new(width:Float, height:Float, ?type:js.three.TextureDataType, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?anisotropy:Int, ?format:js.three.DepthTexturePixelFormat):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link DepthTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isDepthTexture(default, null) : Bool;
	/**
		
			 * This is used to define the comparison function used when comparing texels in the depth texture to the value in
			 * the depth buffer. Default is `null` which means comparison is disabled.
			 * 
			 * See {@link THREE.TextureComparisonFunction} for functions.
			 
	**/
	var compareFunction : js.three.TextureComparisonFunction;
}