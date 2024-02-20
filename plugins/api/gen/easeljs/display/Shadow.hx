package easeljs.display;

/**
 * This class encapsulates the properties required to define a shadow to apply to a {{#crossLink "DisplayObject"}}{{/crossLink}}
 * via its <code>shadow</code> property.
 *
 * <h4>Example</h4>
 *
 *      myImage.shadow = new createjs.Shadow("#000000", 5, 5, 10);
 */
/**
	
	 * This class encapsulates the properties required to define a shadow to apply to a {{#crossLink "DisplayObject"}}{{/crossLink}}
	 * via its <code>shadow</code> property.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      myImage.shadow = new createjs.Shadow("#000000", 5, 5, 10);
	 
**/
@:native('createjs.Shadow') extern class Shadow {
	function new(color:String, offsetX:Float, offsetY:Float, blur:Float):Void;
	/**
		
			 * The color of the shadow. This can be any valid CSS color value.
			 
	**/
	var color : String;
	var offsetX : Float;
	var offsetY : Float;
	var blur : Float;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
	/**
		
			 * Returns a clone of this Shadow instance.
			 
	**/
	function clone():easeljs.display.Shadow;
	/**
		
			 * An identity shadow object (all properties are set to 0).
			 
	**/
	static var identity : easeljs.display.Shadow;
}