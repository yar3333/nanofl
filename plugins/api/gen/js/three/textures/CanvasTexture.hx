package js.three.textures;

/**
 * Creates a texture from a {@link https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas | canvas element}.
 * @remarks
 * This is almost the same as the base {@link Texture | Texture} class,
 * except that it sets {@link Texture.needsUpdate | needsUpdate} to `true` immediately.
 * @see {@link THREE.Texture | Texture}
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CanvasTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CanvasTexture.js | Source}
 */
/**
	
	 * Creates a texture from a {@link https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas | canvas element}.
	 * @remarks
	 * This is almost the same as the base {@link Texture | Texture} class,
	 * except that it sets {@link Texture.needsUpdate | needsUpdate} to `true` immediately.
	 * @see {@link THREE.Texture | Texture}
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CanvasTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CanvasTexture.js | Source}
	 
**/
@:native("THREE.CanvasTexture") extern class CanvasTexture extends js.three.textures.Texture {
	/**
		
			 * Creates a texture from a {@link https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas | canvas element}.
			 * @remarks
			 * This is almost the same as the base {@link Texture | Texture} class,
			 * except that it sets {@link Texture.needsUpdate | needsUpdate} to `true` immediately.
			 * @see {@link THREE.Texture | Texture}
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CanvasTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CanvasTexture.js | Source}
			 
	**/
	function new(canvas:haxe.extern.EitherType<js.html.TexImageSource, js.html.OffscreenCanvas>, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?format:js.three.PixelFormat, ?type:js.three.TextureDataType, ?anisotropy:Int):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link CanvasTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCanvasTexture(default, null) : Bool;
}