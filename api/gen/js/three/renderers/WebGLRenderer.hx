package js.three.renderers;

/**
 * The WebGL renderer displays your beautifully crafted scenes using WebGL, if your device supports it.
 * This renderer has way better performance than CanvasRenderer.
 *
 * see {@link https://github.com/mrdoob/three.js/blob/master/src/renderers/WebGLRenderer.js|src/renderers/WebGLRenderer.js}
 */
/**
	
	 * The WebGL renderer displays your beautifully crafted scenes using WebGL, if your device supports it.
	 * This renderer has way better performance than CanvasRenderer.
	 * 
	 * see {@link https://github.com/mrdoob/three.js/blob/master/src/renderers/WebGLRenderer.js|src/renderers/WebGLRenderer.js}
	 
**/
@:native("THREE.WebGLRenderer") extern class WebGLRenderer implements js.three.renderers.Renderer {
	/**
		
			 * The WebGL renderer displays your beautifully crafted scenes using WebGL, if your device supports it.
			 * This renderer has way better performance than CanvasRenderer.
			 * 
			 * see {@link https://github.com/mrdoob/three.js/blob/master/src/renderers/WebGLRenderer.js|src/renderers/WebGLRenderer.js}
			 
	**/
	function new(?parameters:js.three.renderers.WebGLRendererParameters):Void;
	/**
		
			 * A Canvas where the renderer draws its output.
			 * This is automatically created by the renderer in the constructor (if not provided already); you just need to add it to your page.
			 * @default document.createElementNS( 'http://www.w3.org/1999/xhtml', 'canvas' )
			 
	**/
	var domElement : js.html.CanvasElement;
	/**
		
			 * Defines whether the renderer should automatically clear its output before rendering.
			 * @default true
			 
	**/
	var autoClear : Bool;
	/**
		
			 * If autoClear is true, defines whether the renderer should clear the color buffer. Default is true.
			 * @default true
			 
	**/
	var autoClearColor : Bool;
	/**
		
			 * If autoClear is true, defines whether the renderer should clear the depth buffer. Default is true.
			 * @default true
			 
	**/
	var autoClearDepth : Bool;
	/**
		
			 * If autoClear is true, defines whether the renderer should clear the stencil buffer. Default is true.
			 * @default true
			 
	**/
	var autoClearStencil : Bool;
	/**
		
			 * Debug configurations.
			 * @default { checkShaderErrors: true }
			 
	**/
	var debug : js.three.renderers.WebGLDebug;
	/**
		
			 * Defines whether the renderer should sort objects. Default is true.
			 * @default true
			 
	**/
	var sortObjects : Bool;
	/**
		
			 * @default []
			 
	**/
	var clippingPlanes : Array<Dynamic>;
	/**
		
			 * @default false
			 
	**/
	var localClippingEnabled : Bool;
	var extensions : js.three.renderers.webgl.WebGLExtensions;
	/**
		
			 * Default is LinearEncoding.
			 * @default THREE.LinearEncoding
			 * @deprecated Use {@link WebGLRenderer.outputColorSpace .outputColorSpace} in three.js r152+.
			 
	**/
	var outputEncoding : js.three.TextureEncoding;
	/**
		
			 * @deprecated Migrate your lighting according to the following guide:
			 * https://discourse.threejs.org/t/updates-to-lighting-in-three-js-r155/53733.
			 * @default true
			 
	**/
	var useLegacyLights : Bool;
	/**
		
			 * @default THREE.NoToneMapping
			 
	**/
	var toneMapping : js.three.ToneMapping;
	/**
		
			 * @default 1
			 
	**/
	var toneMappingExposure : Float;
	var info : js.three.renderers.webgl.WebGLInfo;
	var shadowMap : js.three.renderers.webgl.WebGLShadowMap;
	var pixelRatio : Float;
	var capabilities : js.three.renderers.webgl.WebGLCapabilities;
	var properties : js.three.renderers.webgl.WebGLProperties;
	var renderLists : js.three.renderers.webgl.WebGLRenderLists;
	var state : js.three.renderers.webgl.WebGLState;
	/**
		
			 * Compiles all materials in the scene with the camera. This is useful to precompile shaders before the first
			 * rendering. If you want to add a 3D object to an existing scene, use the third optional parameter for applying the
			 * target scene.
			 * Note that the (target) scene's lighting should be configured before calling this method.
			 
	**/
	var compile : (js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.cameras.Camera, js.three.scenes.Scene) -> js.lib.Set<js.three.materials.Material>;
	/**
		
			 * Asynchronous version of {@link compile}(). The method returns a Promise that resolves when the given scene can be
			 * rendered without unnecessary stalling due to shader compilation.
			 * This method makes use of the KHR_parallel_shader_compile WebGL extension.
			 
	**/
	var compileAsync : (js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.cameras.Camera, js.three.scenes.Scene) -> js.lib.Promise<js.three.core.Object3D<js.three.core.Object3DEventMap>>;
	/**
		
			 * @deprecated Use {@link WebGLRenderer#xr .xr} instead.
			 
	**/
	var vr : Bool;
	/**
		
			 * @deprecated Use {@link WebGLShadowMap#enabled .shadowMap.enabled} instead.
			 
	**/
	var shadowMapEnabled : Bool;
	/**
		
			 * @deprecated Use {@link WebGLShadowMap#type .shadowMap.type} instead.
			 
	**/
	var shadowMapType : js.three.ShadowMapType;
	/**
		
			 * @deprecated Use {@link WebGLShadowMap#cullFace .shadowMap.cullFace} instead.
			 
	**/
	var shadowMapCullFace : js.three.CullFace;
	/**
		
			 * Return the WebGL context.
			 
	**/
	function getContext():haxe.extern.EitherType<js.html.webgl.RenderingContext, js.html.webgl.WebGL2RenderingContext>;
	function getContextAttributes():Dynamic;
	function forceContextLoss():Void;
	function forceContextRestore():Void;
	/**
		
			 * @deprecated Use {@link WebGLCapabilities#getMaxAnisotropy .capabilities.getMaxAnisotropy()} instead.
			 
	**/
	function getMaxAnisotropy():Int;
	/**
		
			 * @deprecated Use {@link WebGLCapabilities#precision .capabilities.precision} instead.
			 
	**/
	function getPrecision():String;
	function getPixelRatio():Float;
	function setPixelRatio(value:Float):Void;
	function getDrawingBufferSize(target:js.three.math.Vector2):js.three.math.Vector2;
	function setDrawingBufferSize(width:Float, height:Float, pixelRatio:Float):Void;
	function getSize(target:js.three.math.Vector2):js.three.math.Vector2;
	/**
		
			 * Resizes the output canvas to (width, height), and also sets the viewport to fit that size, starting in (0, 0).
			 
	**/
	function setSize(width:Float, height:Float, ?updateStyle:Bool):Void;
	function getCurrentViewport(target:js.three.math.Vector4):js.three.math.Vector4;
	/**
		
			 * Copies the viewport into target.
			 
	**/
	function getViewport(target:js.three.math.Vector4):js.three.math.Vector4;
	/**
		
			 * Sets the viewport to render from (x, y) to (x + width, y + height).
			 * (x, y) is the lower-left corner of the region.
			 
	**/
	function setViewport(x:haxe.extern.EitherType<js.three.math.Vector4, Float>, ?y:Float, ?width:Float, ?height:Float):Void;
	/**
		
			 * Copies the scissor area into target.
			 
	**/
	function getScissor(target:js.three.math.Vector4):js.three.math.Vector4;
	/**
		
			 * Sets the scissor area from (x, y) to (x + width, y + height).
			 
	**/
	function setScissor(x:haxe.extern.EitherType<js.three.math.Vector4, Float>, ?y:Float, ?width:Float, ?height:Float):Void;
	/**
		
			 * Returns true if scissor test is enabled; returns false otherwise.
			 
	**/
	function getScissorTest():Bool;
	/**
		
			 * Enable the scissor test. When this is enabled, only the pixels within the defined scissor area will be affected by further renderer actions.
			 
	**/
	function setScissorTest(enable:Bool):Void;
	/**
		
			 * Sets the custom opaque sort function for the WebGLRenderLists. Pass null to use the default painterSortStable function.
			 
	**/
	function setOpaqueSort(method:(Dynamic, Dynamic) -> Float):Void;
	/**
		
			 * Sets the custom transparent sort function for the WebGLRenderLists. Pass null to use the default reversePainterSortStable function.
			 
	**/
	function setTransparentSort(method:(Dynamic, Dynamic) -> Float):Void;
	/**
		
			 * Returns a THREE.Color instance with the current clear color.
			 
	**/
	function getClearColor(target:js.three.math.Color):js.three.math.Color;
	/**
		
			 * Sets the clear color, using color for the color and alpha for the opacity.
			 
	**/
	function setClearColor(color:js.three.math.ColorRepresentation, ?alpha:Float):Void;
	/**
		
			 * Returns a float with the current clear alpha. Ranges from 0 to 1.
			 
	**/
	function getClearAlpha():Float;
	function setClearAlpha(alpha:Float):Void;
	/**
		
			 * Tells the renderer to clear its color, depth or stencil drawing buffer(s).
			 * Arguments default to true
			 
	**/
	function clear(?color:Bool, ?depth:Bool, ?stencil:Bool):Void;
	function clearColor():Void;
	function clearDepth():Void;
	function clearStencil():Void;
	function clearTarget(renderTarget:js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>, color:Bool, depth:Bool, stencil:Bool):Void;
	/**
		
			 * @deprecated Use {@link WebGLState#reset .state.reset()} instead.
			 
	**/
	function resetGLState():Void;
	function dispose():Void;
	function renderBufferDirect(camera:js.three.cameras.Camera, scene:js.three.scenes.Scene, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, material:js.three.materials.Material, object:js.three.core.Object3D<js.three.core.Object3DEventMap>, geometryGroup:Dynamic):Void;
	/**
		
			 * @deprecated Use {@link WebGLRenderer#setAnimationLoop .setAnimationLoop()} instead.
			 
	**/
	function animate(callback:() -> Void):Void;
	/**
		
			 * Render a scene or an object using a camera.
			 * The render is done to a previously specified {@link WebGLRenderTarget#renderTarget .renderTarget} set by calling
			 * {@link WebGLRenderer#setRenderTarget .setRenderTarget} or to the canvas as usual.
			 * 
			 * By default render buffers are cleared before rendering but you can prevent this by setting the property
			 * {@link WebGLRenderer#autoClear autoClear} to false. If you want to prevent only certain buffers being cleared
			 * you can set either the {@link WebGLRenderer#autoClearColor autoClearColor},
			 * {@link WebGLRenderer#autoClearStencil autoClearStencil} or {@link WebGLRenderer#autoClearDepth autoClearDepth}
			 * properties to false. To forcibly clear one ore more buffers call {@link WebGLRenderer#clear .clear}.
			 
	**/
	function render(scene:js.three.core.Object3D<js.three.core.Object3DEventMap>, camera:js.three.cameras.Camera):Void;
	/**
		
			 * Returns the current active cube face.
			 
	**/
	function getActiveCubeFace():Float;
	/**
		
			 * Returns the current active mipmap level.
			 
	**/
	function getActiveMipmapLevel():Float;
	/**
		
			 * Returns the current render target. If no render target is set, null is returned.
			 
	**/
	function getRenderTarget():js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>;
	/**
		
			 * @deprecated Use {@link WebGLRenderer#getRenderTarget .getRenderTarget()} instead.
			 
	**/
	function getCurrentRenderTarget():js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>;
	/**
		
			 * Sets the active render target.
			 * 
			 * @link WebGLRenderTarget renderTarget} that needs to be activated. When `null` is given, the canvas is set as the active render target instead.
			 * @link WebGLCubeRenderTarget}.
			 
	**/
	function setRenderTarget(renderTarget:haxe.extern.EitherType<js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>, js.three.renderers.WebGLMultipleRenderTargets>, ?activeCubeFace:Float, ?activeMipmapLevel:Float):Void;
	function readRenderTargetPixels(renderTarget:haxe.extern.EitherType<js.three.renderers.WebGLRenderTarget<js.three.textures.Texture>, js.three.renderers.WebGLMultipleRenderTargets>, x:Float, y:Float, width:Float, height:Float, buffer:Dynamic, ?activeCubeFaceIndex:Float):Void;
	/**
		
			 * Copies a region of the currently bound framebuffer into the selected mipmap level of the selected texture.
			 * This region is defined by the size of the destination texture's mip level, offset by the input position.
			 
	**/
	function copyFramebufferToTexture(position:js.three.math.Vector2, texture:js.three.textures.Texture, ?level:Float):Void;
	/**
		
			 * Copies srcTexture to the specified level of dstTexture, offset by the input position.
			 
	**/
	function copyTextureToTexture(position:js.three.math.Vector2, srcTexture:js.three.textures.Texture, dstTexture:js.three.textures.Texture, ?level:Float):Void;
	/**
		
			 * Copies the pixels of a texture in the bounds sourceBox in the desination texture starting from the given position.
			 
	**/
	function copyTextureToTexture3D(sourceBox:js.three.math.Box3, position:js.three.math.Vector3, srcTexture:js.three.textures.Texture, dstTexture:haxe.extern.EitherType<js.three.textures.Data3DTexture, js.three.textures.DataArrayTexture>, ?level:Float):Void;
	/**
		
			 * Initializes the given texture. Can be used to preload a texture rather than waiting until first render (which can cause noticeable lags due to decode and GPU upload overhead).
			 
	**/
	function initTexture(texture:js.three.textures.Texture):Void;
	/**
		
			 * Can be used to reset the internal WebGL state.
			 
	**/
	function resetState():Void;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'OES_texture_float' )} instead.
			 
	**/
	function supportsFloatTextures():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'OES_texture_half_float' )} instead.
			 
	**/
	function supportsHalfFloatTextures():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'OES_standard_derivatives' )} instead.
			 
	**/
	function supportsStandardDerivatives():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'WEBGL_compressed_texture_s3tc' )} instead.
			 
	**/
	function supportsCompressedTextureS3TC():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'WEBGL_compressed_texture_pvrtc' )} instead.
			 
	**/
	function supportsCompressedTexturePVRTC():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'EXT_blend_minmax' )} instead.
			 
	**/
	function supportsBlendMinMax():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLCapabilities#vertexTextures .capabilities.vertexTextures} instead.
			 
	**/
	function supportsVertexTextures():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLExtensions#get .extensions.get( 'ANGLE_instanced_arrays' )} instead.
			 
	**/
	function supportsInstancedArrays():Dynamic;
	/**
		
			 * @deprecated Use {@link WebGLRenderer#setScissorTest .setScissorTest()} instead.
			 
	**/
	function enableScissorTest(boolean:Dynamic):Dynamic;
}