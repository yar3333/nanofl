package js.html.webgl;

/**
 The WebContextEvent interface is part of the WebGL API and is an interface for an event that is generated in response to a status change to the WebGL rendering context.
 
 Documentation [WebGLContextEvent](https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent>
 */
/**
	
		The WebContextEvent interface is part of the WebGL API and is an interface for an event that is generated in response to a status change to the WebGL rendering context.
	
		Documentation [WebGLContextEvent](https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WebGLContextEvent>
	
**/
@:native("WebGLContextEvent") extern class ContextEvent extends js.html.Event {
	/**
		 @throws DOMError 
	**/
	function new(type:String, ?eventInit:js.html.webgl.ContextEventInit):Void;
	/**
		
				A read-only property containing additional information about the event.
			
	**/
	var statusMessage(default, null) : String;
}