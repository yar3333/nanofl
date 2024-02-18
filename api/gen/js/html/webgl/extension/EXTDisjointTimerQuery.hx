package js.html.webgl.extension;

/**
 The EXT_disjoint_timer_query extension is part of the WebGL API and provides a way to measure the duration of a set of GL commands, without stalling the rendering pipeline.
 
 Documentation [EXT_disjoint_timer_query](https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query>
 */
/**
	
		The EXT_disjoint_timer_query extension is part of the WebGL API and provides a way to measure the duration of a set of GL commands, without stalling the rendering pipeline.
	
		Documentation [EXT_disjoint_timer_query](https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_disjoint_timer_query>
	
**/
@:native("EXT_disjoint_timer_query") extern class EXTDisjointTimerQuery {
	/**
		
				
				 Creates a new `WebGLQuery`.
				 
			
	**/
	function createQueryEXT():js.html.webgl.Query;
	/**
		
				
				 Deletes a given `WebGLQuery`.
				 
			
	**/
	function deleteQueryEXT(query:js.html.webgl.Query):Void;
	/**
		
				
				 Returns `true` if a given object is a `WebGLQuery`.
				 
			
	**/
	function isQueryEXT(query:js.html.webgl.Query):Bool;
	/**
		
				The timer starts when all commands prior to `beginQueryEXT` have been fully executed.
			
	**/
	function beginQueryEXT(target:Int, query:js.html.webgl.Query):Void;
	/**
		
				The timer stops when all commands prior to `endQueryEXT` have been fully executed.
			
	**/
	function endQueryEXT(target:Int):Void;
	/**
		
				
				 Records the current time into the corresponding query object.
				 
			
	**/
	function queryCounterEXT(query:js.html.webgl.Query, target:Int):Void;
	/**
		
				Returns information about a query target.
			
	**/
	function getQueryEXT(target:Int, pname:Int):Dynamic;
	/**
		
				Return the state of a query object.
			
	**/
	function getQueryObjectEXT(query:js.html.webgl.Query, pname:Int):Dynamic;
	/**
		
				A `GLint` indicating the number of bits used to hold the query result for the given target.
			
	**/
	static var QUERY_COUNTER_BITS_EXT(default, never) : Int;
	/**
		
				A `WebGLQuery` object, which is the currently active query for the given target.
			
	**/
	static var CURRENT_QUERY_EXT(default, never) : Int;
	/**
		
				A `GLuint64EXT` containing the query result.
			
	**/
	static var QUERY_RESULT_EXT(default, never) : Int;
	/**
		
				A `GLboolean` indicating whether or not a query result is available.
			
	**/
	static var QUERY_RESULT_AVAILABLE_EXT(default, never) : Int;
	/**
		
				Elapsed time (in nanoseconds).
			
	**/
	static var TIME_ELAPSED_EXT(default, never) : Int;
	/**
		
				The current time.
			
	**/
	static var TIMESTAMP_EXT(default, never) : Int;
	/**
		
				A `GLboolean` indicating whether or not the GPU performed any disjoint operation.
			
	**/
	static var GPU_DISJOINT_EXT(default, never) : Int;
}