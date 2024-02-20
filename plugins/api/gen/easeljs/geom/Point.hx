package easeljs.geom;

/**
 * Represents a point on a 2 dimensional x / y coordinate system.
 *
 * <h4>Example</h4>
 *
 *      var point = new createjs.Point(0, 100);
 */
/**
	
	 * Represents a point on a 2 dimensional x / y coordinate system.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var point = new createjs.Point(0, 100);
	 
**/
@:native('createjs.Point') extern class Point {
	function new(?x:Float, ?y:Float):Void;
	/**
		
			 * X position.
			 
	**/
	var x : Float;
	/**
		
			 * Y position.
			 
	**/
	var y : Float;
	/**
		
			 * Sets the specified values on this instance.
			 
	**/
	function setValues(?x:Float, ?y:Float):easeljs.geom.Point;
	/**
		
			 * Copies all properties from the specified point to this point.
			 
	**/
	function copy(point:easeljs.geom.Point):easeljs.geom.Point;
	/**
		
			 * Returns a clone of the Point instance.
			 
	**/
	function clone():easeljs.geom.Point;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
}