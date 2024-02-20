package js.html.webgl;

/**
 The WebGLShaderPrecisionFormat interface is part of the WebGL API and represents the information returned by calling the `WebGLRenderingContext.getShaderPrecisionFormat()` method.
 
 Documentation [WebGLShaderPrecisionFormat](https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat>
 */
/**
	
		The WebGLShaderPrecisionFormat interface is part of the WebGL API and represents the information returned by calling the `WebGLRenderingContext.getShaderPrecisionFormat()` method.
	
		Documentation [WebGLShaderPrecisionFormat](https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLShaderPrecisionFormat>
	
**/
@:native("WebGLShaderPrecisionFormat") extern class ShaderPrecisionFormat {
	/**
		
				The base 2 log of the absolute value of the minimum value that can be represented.
			
	**/
	var rangeMin(default, null) : Int;
	/**
		
				The base 2 log of the absolute value of the maximum value that can be represented.
			
	**/
	var rangeMax(default, null) : Int;
	/**
		
				The number of bits of precision that can be represented. For integer formats this value is always 0.
			
	**/
	var precision(default, null) : Int;
}