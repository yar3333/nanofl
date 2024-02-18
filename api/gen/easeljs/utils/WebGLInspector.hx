package easeljs.utils;

/**
 * A utility and helper class designed to work with {{#crossLink "StageGL"}}{{/crossLink}} to help investigate and
 * test performance or display problems. It contains logging functions to analyze behaviour and performance testing
 * utilities.
 */
/**
	
	 * A utility and helper class designed to work with {{#crossLink "StageGL"}}{{/crossLink}} to help investigate and
	 * test performance or display problems. It contains logging functions to analyze behaviour and performance testing
	 * utilities.
	 
**/
@:native('createjs.WebGLInspector') extern class WebGLInspector {
	function new(stage:easeljs.display.StageGL):Void;
	/**
		
			 * Perform all of the logging reports at once.
			 
	**/
	function log(?stage:easeljs.display.StageGL):Void;
	/**
		
			 * Replace the stage's Draw command with an empty draw command. This is useful for testing performance, and ignoring
			 * rendering.
			 
	**/
	function toggleGPUDraw(?stage:easeljs.display.StageGL, enabled:Bool):Void;
	/**
		
			 * Recursively walk the entire display tree, log the attached items, and display it in a tree view.
			 
	**/
	function logDepth(?children:Array<Dynamic>, prepend:String, customLog:Dynamic):Void;
	/**
		
			 * Examine the context and provide information about its capabilities.
			 
	**/
	function logContextInfo(gl:js.html.webgl.WebGL2RenderingContext):Void;
	/**
		
			 * Simulate renders and watch what happens for textures moving around between draw calls. A texture moving between
			 * slots means it was removed and then re-added to draw calls. Performance may be better if it was allowed to stay
			 * in place.
			 
	**/
	function logTextureFill(?stage:easeljs.display.StageGL):Void;
	/**
		
			 * Utility function for use with {{#crossLink "logDepth"))((/crossLink}}. Logs an item's position and registration.
			 * Useful to see if something is being forced off screen or has an integer position.
			 
	**/
	static function dispProps(prepend:String, item:easeljs.display.DisplayObject):Void;
}