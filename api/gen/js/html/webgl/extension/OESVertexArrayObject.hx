package js.html.webgl.extension;

/**
 The OES_vertex_array_object extension is part of the WebGL API and provides vertex array objects (VAOs) which encapsulate vertex array states. These objects keep pointers to vertex data and provide names for different sets of vertex data.
 
 Documentation [OES_vertex_array_object](https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object>
 */
/**
	
		The OES_vertex_array_object extension is part of the WebGL API and provides vertex array objects (VAOs) which encapsulate vertex array states. These objects keep pointers to vertex data and provide names for different sets of vertex data.
	
		Documentation [OES_vertex_array_object](https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/OES_vertex_array_object>
	
**/
@:native("OES_vertex_array_object") extern class OESVertexArrayObject {
	/**
		
				
					Creates a new `WebGLVertexArrayObject`.
					
			
	**/
	function createVertexArrayOES():js.html.webgl.VertexArrayObject;
	/**
		
				
					Deletes a given `WebGLVertexArrayObject`.
					
			
	**/
	function deleteVertexArrayOES(arrayObject:js.html.webgl.VertexArrayObject):Void;
	/**
		
				
					Returns `true` if a given object is a `WebGLVertexArrayObject`.
					
			
	**/
	function isVertexArrayOES(arrayObject:js.html.webgl.VertexArrayObject):Bool;
	/**
		
				
					Binds a given `WebGLVertexArrayObject` to the buffer.
					
			
	**/
	function bindVertexArrayOES(arrayObject:js.html.webgl.VertexArrayObject):Void;
	/**
		
				Returns a `WebGLVertexArrayObject` object when used in the `WebGLRenderingContext.getParameter()` method as the `pname` parameter.
			
	**/
	static var VERTEX_ARRAY_BINDING_OES(default, never) : Int;
}