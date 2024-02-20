package js.html.webgl;

/**
 The WebGLActiveInfo interface is part of the WebGL API and represents the information returned by calling the `WebGLRenderingContext.getActiveAttrib()` and `WebGLRenderingContext.getActiveUniform()` methods.
 
 Documentation [WebGLActiveInfo](https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo>
 */
/**
	
		The WebGLActiveInfo interface is part of the WebGL API and represents the information returned by calling the `WebGLRenderingContext.getActiveAttrib()` and `WebGLRenderingContext.getActiveUniform()` methods.
	
		Documentation [WebGLActiveInfo](https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLActiveInfo>
	
**/
@:native("WebGLActiveInfo") extern class ActiveInfo {
	/**
		
				The read-only size of the requested variable.
			
	**/
	var size(default, null) : Int;
	/**
		
				The read-only type of the requested variable.
			
	**/
	var type(default, null) : Int;
	/**
		
				The read-only name of the requested variable.
			
	**/
	var name(default, null) : String;
}