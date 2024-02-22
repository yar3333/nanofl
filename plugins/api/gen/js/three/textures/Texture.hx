package js.three.textures;

/**
 * Create a {@link Texture} to apply to a surface or as a reflection or refraction map.
 * @remarks
 * After the initial use of a texture, its **dimensions**, {@link format}, and {@link type} cannot be changed
 * Instead, call {@link dispose | .dispose()} on the {@link Texture} and instantiate a new {@link Texture}.
 * @example
 * ```typescript
 * // load a texture, set wrap mode to repeat
 * const texture = new THREE.TextureLoader().load("textures/water.jpg");
 * texture.wrapS = THREE.RepeatWrapping;
 * texture.wrapT = THREE.RepeatWrapping;
 * texture.repeat.set(4, 4);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_materials_texture_filters | webgl materials texture filters}
 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/Texture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/Textures/Texture.js | Source}
 */
/**
	
	 * Create a {@link Texture} to apply to a surface or as a reflection or refraction map.
	 * @remarks
	 * After the initial use of a texture, its **dimensions**, {@link format}, and {@link type} cannot be changed
	 * Instead, call {@link dispose | .dispose()} on the {@link Texture} and instantiate a new {@link Texture}.
	 * @example
	 * ```typescript
	 * // load a texture, set wrap mode to repeat
	 * const texture = new THREE.TextureLoader().load("textures/water.jpg");
	 * texture.wrapS = THREE.RepeatWrapping;
	 * texture.wrapT = THREE.RepeatWrapping;
	 * texture.repeat.set(4, 4);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_materials_texture_filters | webgl materials texture filters}
	 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/Texture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/Textures/Texture.js | Source}
	 
**/
@:native("THREE.Texture") extern class Texture extends js.three.core.EventDispatcher<{ var dispose : { }; }> {
	/**
		
			 * Create a {@link Texture} to apply to a surface or as a reflection or refraction map.
			 * @remarks
			 * After the initial use of a texture, its **dimensions**, {@link format}, and {@link type} cannot be changed
			 * Instead, call {@link dispose | .dispose()} on the {@link Texture} and instantiate a new {@link Texture}.
			 * @example
			 * ```typescript
			 * // load a texture, set wrap mode to repeat
			 * const texture = new THREE.TextureLoader().load("textures/water.jpg");
			 * texture.wrapS = THREE.RepeatWrapping;
			 * texture.wrapT = THREE.RepeatWrapping;
			 * texture.repeat.set(4, 4);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_materials_texture_filters | webgl materials texture filters}
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/Texture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/Textures/Texture.js | Source}
			 
	**/
	@:overload(function(?image:haxe.extern.EitherType<js.html.TexImageSource, js.html.OffscreenCanvas>, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?format:js.three.PixelFormat, ?type:js.three.TextureDataType, ?anisotropy:Int, ?colorSpace:js.three.ColorSpace):Void { })
	function new(image:haxe.extern.EitherType<js.html.TexImageSource, js.html.OffscreenCanvas>, mapping:js.three.Mapping, wrapS:js.three.Wrapping, wrapT:js.three.Wrapping, magFilter:js.three.MagnificationTextureFilter, minFilter:js.three.MinificationTextureFilter, format:js.three.PixelFormat, type:js.three.TextureDataType, anisotropy:Int, encoding:js.three.TextureEncoding):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link Texture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isTexture(default, null) : Bool;
	/**
		
			 * Unique number for this {@link Texture} instance.
			 * @remarks Note that ids are assigned in chronological order: 1, 2, 3, ..., incrementing by one for each new object.
			 * @remarks Expects a `Integer`
			 
	**/
	var id(default, null) : Int;
	/**
		
			 * {@link http://en.wikipedia.org/wiki/Universally_unique_identifier | UUID} of this object instance.
			 * @remarks This gets automatically assigned and shouldn't be edited.
			 
	**/
	var uuid : String;
	/**
		
			 * Optional name of the object
			 * @remarks _(doesn't need to be unique)_.
			 * @defaultValue `""`
			 
	**/
	var name : String;
	/**
		
			 * The data definition of a texture. A reference to the data source can be shared across textures.
			 * This is often useful in context of spritesheets where multiple textures render the same data
			 * but with different {@link Texture} transformations.
			 
	**/
	var source : js.three.textures.Source;
	/**
		
			 * Array of user-specified mipmaps
			 * @defaultValue `[]`
			 
	**/
	var mipmaps : Array<Dynamic>;
	/**
		
			 * How the image is applied to the object.
			 * @remarks All {@link Texture} types except {@link THREE.CubeTexture} expect the _values_ be {@link THREE.Mapping}
			 * @remarks {@link CubeTexture} expect the _values_ be {@link THREE.CubeTextureMapping}
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @defaultValue _value of_ {@link THREE.Texture.DEFAULT_MAPPING}
			 
	**/
	var mapping : js.three.AnyMapping;
	/**
		
			 * Lets you select the uv attribute to map the texture to. `0` for `uv`, `1` for `uv1`, `2` for `uv2` and `3` for
			 * `uv3`.
			 
	**/
	var channel : Float;
	/**
		
			 * This defines how the {@link Texture} is wrapped *horizontally* and corresponds to **U** in UV mapping.
			 * @remarks for **WEBGL1** - tiling of images in textures only functions if image dimensions are powers of two
			 * (2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, ...) in terms of pixels.
			 * Individual dimensions need not be equal, but each must be a power of two. This is a limitation of WebGL1, not three.js.
			 * **WEBGL2** does not have this limitation.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link wrapT}
			 * @see {@link repeat}
			 * @defaultValue {@link THREE.ClampToEdgeWrapping}
			 
	**/
	var wrapS : js.three.Wrapping;
	/**
		
			 * This defines how the {@link Texture} is wrapped *vertically* and corresponds to **V** in UV mapping.
			 * @remarks for **WEBGL1** - tiling of images in textures only functions if image dimensions are powers of two
			 * (2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, ...) in terms of pixels.
			 * Individual dimensions need not be equal, but each must be a power of two. This is a limitation of WebGL1, not three.js.
			 * **WEBGL2** does not have this limitation.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link wrapS}
			 * @see {@link repeat}
			 * @defaultValue {@link THREE.ClampToEdgeWrapping}
			 
	**/
	var wrapT : js.three.Wrapping;
	/**
		
			 * How the {@link Texture} is sampled when a texel covers more than one pixel.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link minFilter}
			 * @see {@link THREE.MagnificationTextureFilter}
			 * @defaultValue {@link THREE.LinearFilter}
			 
	**/
	var magFilter : js.three.MagnificationTextureFilter;
	/**
		
			 * How the {@link Texture} is sampled when a texel covers less than one pixel.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link magFilter}
			 * @see {@link THREE.MinificationTextureFilter}
			 * @defaultValue {@link THREE.LinearMipmapLinearFilter}
			 
	**/
	var minFilter : js.three.MinificationTextureFilter;
	/**
		
			 * The number of samples taken along the axis through the pixel that has the highest density of texels.
			 * @remarks A higher value gives a less blurry result than a basic mipmap, at the cost of more {@link Texture} samples being used.
			 * @remarks Use {@link THREE.WebGLCapabilities.getMaxAnisotropy() | renderer.capabilities.getMaxAnisotropy()} to find the maximum valid anisotropy value for the GPU;
			 * @remarks This value is usually a power of 2.
			 * @default _value of_ {@link THREE.Texture.DEFAULT_ANISOTROPY}. That is normally `1`.
			 
	**/
	var anisotropy : Int;
	/**
		
			 * These define how elements of a 2D texture, or texels, are read by shaders.
			 * @remarks All {@link Texture} types except {@link THREE.DepthTexture} and {@link THREE.CompressedPixelFormat} expect the _values_ be {@link THREE.PixelFormat}
			 * @remarks {@link DepthTexture} expect the _values_ be {@link THREE.CubeTextureMapping}
			 * @remarks {@link CompressedPixelFormat} expect the _values_ be {@link THREE.CubeTextureMapping}
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link THREE.PixelFormat}
			 * @defaultValue {@link THREE.RGBAFormat}.
			 
	**/
	var format : js.three.AnyPixelFormat;
	/**
		
			 * This must correspond to the {@link Texture.format | .format}.
			 * @remarks {@link THREE.UnsignedByteType}, is the type most used by Texture formats.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link THREE.TextureDataType}
			 * @defaultValue {@link THREE.UnsignedByteType}
			 
	**/
	var type : js.three.TextureDataType;
	/**
		
			 * The GPU Pixel Format allows the developer to specify how the data is going to be stored on the GPU.
			 * @remarks Compatible only with {@link WebGL2RenderingContext | WebGL 2 Rendering Context}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @defaultValue The default value is obtained using a combination of {@link Texture.format | .format} and {@link Texture.type | .type}.
			 
	**/
	var internalFormat : js.three.PixelFormatGPU;
	/**
		
			 * The uv-transform matrix for the texture.
			 * @remarks
			 * When {@link Texture.matrixAutoUpdate | .matrixAutoUpdate} property is `true`.
			 * Will be updated by the renderer from the properties:
			 *  - {@link Texture.offset | .offset}
			 *  - {@link Texture.repeat | .repeat}
			 *  - {@link Texture.rotation | .rotation}
			 *  - {@link Texture.center | .center}
			 * @remarks
			 * When {@link Texture.matrixAutoUpdate | .matrixAutoUpdate} property is `false`.
			 * This matrix may be set manually.
			 * @see {@link matrixAutoUpdate | .matrixAutoUpdate}
			 * @defaultValue `new THREE.Matrix3()`
			 
	**/
	var matrix : js.three.math.Matrix3;
	/**
		
			 * Whether is to update the texture's uv-transform {@link matrix | .matrix}.
			 * @remarks Set this to `false` if you are specifying the uv-transform {@link matrix} directly.
			 * @see {@link matrix | .matrix}
			 * @defaultValue `true`
			 
	**/
	var matrixAutoUpdate : Bool;
	/**
		
			 * How much a single repetition of the texture is offset from the beginning, in each direction **U** and **V**.
			 * @remarks Typical range is `0.0` to `1.0`.
			 * @defaultValue `new THREE.Vector2(0, 0)`
			 
	**/
	var offset : js.three.math.Vector2;
	/**
		
			 * How many times the texture is repeated across the surface, in each direction **U** and **V**.
			 * @remarks
			 * If repeat is set greater than `1` in either direction, the corresponding *Wrap* parameter should
			 * also be set to {@link THREE.RepeatWrapping} or {@link THREE.MirroredRepeatWrapping} to achieve the desired tiling effect.
			 * @see {@link wrapS}
			 * @see {@link wrapT}
			 * @defaultValue `new THREE.Vector2( 1, 1 )`
			 
	**/
	var repeat : js.three.math.Vector2;
	/**
		
			 * The point around which rotation occurs.
			 * @remarks A value of `(0.5, 0.5)` corresponds to the center of the texture.
			 * @defaultValue `new THREE.Vector2( 0, 0 )`, _lower left._
			 
	**/
	var center : js.three.math.Vector2;
	/**
		
			 * How much the texture is rotated around the center point, in radians.
			 * @remarks Positive values are counter-clockwise.
			 * @defaultValue `0`
			 
	**/
	var rotation : Float;
	/**
		
			 * Whether to generate mipmaps, _(if possible)_ for a texture.
			 * @remarks Set this to false if you are creating mipmaps manually.
			 * @defaultValue true
			 
	**/
	var generateMipmaps : Bool;
	/**
		
			 * If set to `true`, the alpha channel, if present, is multiplied into the color channels when the texture is uploaded to the GPU.
			 * @remarks
			 * Note that this property has no effect for {@link https://developer.mozilla.org/en-US/docs/Web/API/ImageBitmap | ImageBitmap}.
			 * You need to configure on bitmap creation instead. See {@link THREE.ImageBitmapLoader | ImageBitmapLoader}.
			 * @see {@link THREE.ImageBitmapLoader | ImageBitmapLoader}.
			 * @defaultValue `false`
			 
	**/
	var premultiplyAlpha : Bool;
	/**
		
			 * If set to `true`, the texture is flipped along the vertical axis when uploaded to the GPU.
			 * @remarks
			 * Note that this property has no effect for {@link https://developer.mozilla.org/en-US/docs/Web/API/ImageBitmap | ImageBitmap}.
			 * You need to configure on bitmap creation instead. See {@link THREE.ImageBitmapLoader | ImageBitmapLoader}.
			 * @see {@link THREE.ImageBitmapLoader | ImageBitmapLoader}.
			 * @defaultValue `true`
			 
	**/
	var flipY : Bool;
	/**
		
			 * Specifies the alignment requirements for the start of each pixel row in memory.
			 * @remarks
			 * The allowable values are:
			 *  - `1` (byte-alignment)
			 *  - `2` (rows aligned to even-numbered bytes)
			 *  - `4` (word-alignment)
			 *  - `8` (rows start on double-word boundaries).
			 * @see {@link http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml | glPixelStorei} for more information.
			 * @defaultValue `4`
			 
	**/
	var unpackAlignment : Float;
	/**
		
			 * The {@link Textures | {@link Texture} constants} page for details of other formats.
			 * @remarks
			 * Values of {@link encoding} !== {@link THREE.LinearEncoding} are only supported on _map_, _envMap_ and _emissiveMap_.
			 * @remarks
			 * Note that if this value is changed on a texture after the material has been used, it is necessary to trigger a {@link THREE.Material.needsUpdate} for this value to be realized in the shader.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link THREE.TextureDataType}
			 * @defaultValue {@link THREE.LinearEncoding}
			 * @deprecated Use {@link Texture.colorSpace .colorSpace} in three.js r152+.
			 
	**/
	var encoding : js.three.TextureEncoding;
	/**
		
			 * The {@link Textures | {@link Texture} constants} page for details of other color spaces.
			 * @remarks
			 * Textures containing color data should be annotated with {@link SRGBColorSpace THREE.SRGBColorSpace} or
			 * {@link LinearSRGBColorSpace THREE.LinearSRGBColorSpace}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
			 * @see {@link THREE.TextureDataType}
			 * @defaultValue {@link THREE.NoColorSpace}
			 
	**/
	var colorSpace : js.three.ColorSpace;
	/**
		
			 * Indicates whether a texture belongs to a render target or not
			 * @defaultValue `false`
			 
	**/
	var isRenderTargetTexture : Bool;
	/**
		
			 * Indicates whether this texture should be processed by {@link THREE.PMREMGenerator} or not.
			 * @remarks Only relevant for render target textures.
			 * @defaultValue `false`
			 
	**/
	var needsPMREMUpdate : Bool;
	/**
		
			 * An object that can be used to store custom data about the texture.
			 * @remarks It should not hold references to functions as these will not be cloned.
			 * @defaultValue `{}`
			 
	**/
	var userData : Dynamic<Dynamic>;
	/**
		
			 * This starts at `0` and counts how many times {@link needsUpdate | .needsUpdate} is set to `true`.
			 * @remarks Expects a `Integer`
			 * @defaultValue `0`
			 
	**/
	var version : Float;
	/**
		
			 * A callback function, called when the texture is updated _(e.g., when needsUpdate has been set to true and then the texture is used)_.
			 
	**/
	var onUpdate : () -> Void;
	/**
		
			 * Transform the **UV** based on the value of this texture's
			 * {@link offset | .offset},
			 * {@link repeat | .repeat},
			 * {@link wrapS | .wrapS},
			 * {@link wrapT | .wrapT} and
			 * {@link flipY | .flipY} properties.
			 
	**/
	function transformUv(uv:js.three.math.Vector2):js.three.math.Vector2;
	/**
		
			 * Update the texture's **UV-transform** {@link matrix | .matrix} from the texture properties
			 * {@link offset | .offset},
			 * {@link repeat | .repeat},
			 * {@link rotation | .rotation} and
			 * {@link center | .center}.
			 
	**/
	function updateMatrix():Void;
	/**
		
			 * Make copy of the texture
			 * @remarks Note this is not a **"deep copy"**, the image is shared
			 * @remarks
			 * Besides, cloning a texture does not automatically mark it for a texture upload
			 * You have to set {@link needsUpdate | .needsUpdate} to `true` as soon as it's image property (the data source) is fully loaded or ready.
			 
	**/
	function clone():js.three.textures.Texture;
	function copy(source:js.three.textures.Texture):js.three.textures.Texture;
	/**
		
			 * Convert the texture to three.js {@link https://github.com/mrdoob/three.js/wiki/JSON-Object-Scene-format-4 | JSON Object/Scene format}.
			 
	**/
	function toJSON(?meta:haxe.extern.EitherType<String, { }>):{ };
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
	/**
		
			 * The Global default value for {@link anisotropy | .anisotropy}.
			 * @defaultValue `1`.
			 
	**/
	static var DEFAULT_ANISOTROPY : Float;
	/**
		
			 * The Global default value for {@link Texture.image | .image}.
			 * @defaultValue `null`.
			 
	**/
	static var DEFAULT_IMAGE : Dynamic;
	/**
		
			 * The Global default value for {@link mapping | .mapping}.
			 * @defaultValue {@link THREE.UVMapping}
			 
	**/
	static var DEFAULT_MAPPING : js.three.Mapping;
}