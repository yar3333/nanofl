package js.html.webgl.extension;

/**
 The `ANGLE_instanced_arrays` extension is part of the WebGL API and allows to draw the same object, or groups of similar objects multiple times, if they share the same vertex data, primitive count and type.
 
 Documentation [ANGLE_instanced_arrays](https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays>
 */
/**
	
		The `ANGLE_instanced_arrays` extension is part of the WebGL API and allows to draw the same object, or groups of similar objects multiple times, if they share the same vertex data, primitive count and type.
	
		Documentation [ANGLE_instanced_arrays](https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/ANGLE_instanced_arrays>
	
**/
@:native("ANGLE_instanced_arrays") extern class ANGLEInstancedArrays {
	/**
		
				
				 Behaves identically to `WebGLRenderingContext.drawArrays()` except that multiple instances of the range of elements are executed, and the instance advances for each iteration.
				 
			
	**/
	function drawArraysInstancedANGLE(mode:Int, first:Int, count:Int, primcount:Int):Void;
	/**
		
				
				 Behaves identically to `WebGLRenderingContext.drawElements()` except that multiple instances of the set of elements are executed and the instance advances between each set.
				 
			
	**/
	function drawElementsInstancedANGLE(mode:Int, count:Int, type:Int, offset:Int, primcount:Int):Void;
	/**
		
				
				 Modifies the rate at which generic vertex attributes advance when rendering multiple instances of primitives with `ANGLE_instanced_arrays.drawArraysInstancedANGLE()` and `ANGLE_instanced_arrays.drawElementsInstancedANGLE()`.
				 
			
	**/
	function vertexAttribDivisorANGLE(index:Int, divisor:Int):Void;
	/**
		
				Returns a `GLint` describing the frequency divisor used for instanced rendering when used in the `WebGLRenderingContext.getVertexAttrib()` as the `pname` parameter.
			
	**/
	static var VERTEX_ATTRIB_ARRAY_DIVISOR_ANGLE(default, never) : Int;
}