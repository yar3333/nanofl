package js.html.webgl.extension;

/**
 The `EXT_blend_minmax` extension is part of the WebGL API and extends blending capabilities by adding two new blend equations: the minimum or maximum color components of the source and destination colors.
 
 Documentation [EXT_blend_minmax](https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax>
 */
/**
	
		The `EXT_blend_minmax` extension is part of the WebGL API and extends blending capabilities by adding two new blend equations: the minimum or maximum color components of the source and destination colors.
	
		Documentation [EXT_blend_minmax](https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_blend_minmax>
	
**/
@:native("EXT_blend_minmax") extern class EXTBlendMinmax {
	/**
		
				Produces the minimum color components of the source and destination colors.
			
	**/
	static var MIN_EXT(default, never) : Int;
	/**
		
				Produces the maximum color components of the source and destination colors.
			
	**/
	static var MAX_EXT(default, never) : Int;
}