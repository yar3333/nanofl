package js.html.webgl.extension;

/**
 The `OES_standard_derivatives` extension is part of the WebGL API and adds the GLSL derivative functions `dFdx`, `dFdy`, and `fwidth`.
 
 Documentation [OES_standard_derivatives](https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives>
 */
/**
	
		The `OES_standard_derivatives` extension is part of the WebGL API and adds the GLSL derivative functions `dFdx`, `dFdy`, and `fwidth`.
	
		Documentation [OES_standard_derivatives](https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/OES_standard_derivatives>
	
**/
@:native("OES_standard_derivatives") extern class OESStandardDerivatives {
	/**
		
				A `Glenum` indicating the accuracy of the derivative calculation for the GLSL built-in functions: `dFdx`, `dFdy`, and `fwidth`.
			
	**/
	static var FRAGMENT_SHADER_DERIVATIVE_HINT_OES(default, never) : Int;
}