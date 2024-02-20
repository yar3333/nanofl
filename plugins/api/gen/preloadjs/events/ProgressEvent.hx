package preloadjs.events;

/**
 * A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
 */
/**
	
	 * A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
	 
**/
@:native('createjs.ProgressEvent') extern class ProgressEvent {
	function new(loaded:Float, ?total:Float):Void;
	/**
		
			 * The amount that has been loaded (out of a total amount)
			 
	**/
	var loaded : Float;
	/**
		
			 * The total "size" of the load.
			 
	**/
	var total : Float;
	/**
		
			 * The percentage (out of 1) that the load has been completed. This is calculated using `loaded/total`.
			 
	**/
	var progress : Float;
	/**
		
			 * Returns a clone of the ProgressEvent instance.
			 
	**/
	function clone():preloadjs.events.ProgressEvent;
}