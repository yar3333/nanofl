package js.three.core;

extern interface RenderTargetOptions {
	@:optional
	var wrapS : js.three.Wrapping;
	@:optional
	var wrapT : js.three.Wrapping;
	@:optional
	var magFilter : js.three.MagnificationTextureFilter;
	@:optional
	var minFilter : js.three.MinificationTextureFilter;
	@:optional
	var generateMipmaps : Bool;
	@:optional
	var format : Float;
	@:optional
	var type : js.three.TextureDataType;
	@:optional
	var anisotropy : Float;
	@:optional
	var colorSpace : js.three.ColorSpace;
	@:optional
	var internalFormat : js.three.PixelFormatGPU;
	@:optional
	var depthBuffer : Bool;
	@:optional
	var stencilBuffer : Bool;
	@:optional
	var depthTexture : js.three.textures.DepthTexture;
	/**
		
			 * Defines the count of MSAA samples. Can only be used with WebGL 2. Default is **0**.
			 * @default 0
			 
	**/
	@:optional
	var samples : Float;
	/**
		
			 * @deprecated Use 'colorSpace' in three.js r152+. 
			 
	**/
	@:optional
	var encoding : js.three.TextureEncoding;
}