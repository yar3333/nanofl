package easeljs.geom;

/**
 * Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
 *
 * <h4>Example</h4>
 *
 *      var rect = new createjs.Rectangle(0, 0, 100, 100);
 */
/**
	
	 * Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var rect = new createjs.Rectangle(0, 0, 100, 100);
	 
**/
@:native('createjs.Rectangle') extern class Rectangle {
	function new(?x:Float, ?y:Float, ?width:Float, ?height:Float):Void;
	/**
		
			 * X position.
			 
	**/
	var x : Float;
	/**
		
			 * Y position.
			 
	**/
	var y : Float;
	/**
		
			 * Width.
			 
	**/
	var width : Float;
	/**
		
			 * Height.
			 
	**/
	var height : Float;
	/**
		
			 * Sets the specified values on this instance.
			 
	**/
	function setValues(?x:Float, ?y:Float, ?width:Float, ?height:Float):easeljs.geom.Rectangle;
	/**
		
			 * Extends the rectangle's bounds to include the described point or rectangle.
			 
	**/
	function extend(x:Float, y:Float, ?width:Float, ?height:Float):easeljs.geom.Rectangle;
	/**
		
			 * Adds the specified padding to the rectangle's bounds.
			 
	**/
	function pad(top:Float, left:Float, bottom:Float, right:Float):easeljs.geom.Rectangle;
	/**
		
			 * Copies all properties from the specified rectangle to this rectangle.
			 
	**/
	function copy(rectangle:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
	/**
		
			 * Returns true if this rectangle fully encloses the described point or rectangle.
			 
	**/
	function contains(x:Float, y:Float, ?width:Float, ?height:Float):Bool;
	/**
		
			 * Returns a new rectangle which contains this rectangle and the specified rectangle.
			 
	**/
	function union(rect:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
	/**
		
			 * Returns a new rectangle which describes the intersection (overlap) of this rectangle and the specified rectangle,
			 * or null if they do not intersect.
			 
	**/
	function intersection(rect:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
	/**
		
			 * Returns true if the specified rectangle intersects (has any overlap) with this rectangle.
			 
	**/
	function intersects(rect:easeljs.geom.Rectangle):Bool;
	/**
		
			 * Returns true if the width or height are equal or less than 0.
			 
	**/
	function isEmpty():Bool;
	/**
		
			 * Returns a clone of the Rectangle instance.
			 
	**/
	function clone():easeljs.geom.Rectangle;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
}