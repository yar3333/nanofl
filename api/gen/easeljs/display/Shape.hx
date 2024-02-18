package easeljs.display;

/**
 * A Shape allows you to display vector art in the display list. It composites a {{#crossLink "Graphics"}}{{/crossLink}}
 * instance which exposes all of the vector drawing methods. The Graphics instance can be shared between multiple Shape
 * instances to display the same vector graphics with different positions or transforms.
 *
 * If the vector art will not
 * change between draws, you may want to use the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method to reduce the
 * rendering cost.
 *
 * <h4>Example</h4>
 *
 *      var graphics = new createjs.Graphics().beginFill("#ff0000").drawRect(0, 0, 100, 100);
 *      var shape = new createjs.Shape(graphics);
 *
 *      //Alternatively use can also use the graphics property of the Shape class to renderer the same as above.
 *      var shape = new createjs.Shape();
 *      shape.graphics.beginFill("#ff0000").drawRect(0, 0, 100, 100);
 */
/**
	
	 * A Shape allows you to display vector art in the display list. It composites a {{#crossLink "Graphics"}}{{/crossLink}}
	 * instance which exposes all of the vector drawing methods. The Graphics instance can be shared between multiple Shape
	 * instances to display the same vector graphics with different positions or transforms.
	 * 
	 * If the vector art will not
	 * change between draws, you may want to use the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method to reduce the
	 * rendering cost.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var graphics = new createjs.Graphics().beginFill("#ff0000").drawRect(0, 0, 100, 100);
	 *      var shape = new createjs.Shape(graphics);
	 * 
	 *      //Alternatively use can also use the graphics property of the Shape class to renderer the same as above.
	 *      var shape = new createjs.Shape();
	 *      shape.graphics.beginFill("#ff0000").drawRect(0, 0, 100, 100);
	 
**/
@:native('createjs.Shape') extern class Shape extends easeljs.display.DisplayObject {
	function new(?graphics:easeljs.display.Graphics):Void;
	/**
		
			 * The graphics instance to display.
			 
	**/
	var graphics : easeljs.display.Graphics;
	/**
		
			 * Returns true or false indicating whether the Shape would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the Shape into the specified context ignoring its visible, alpha, shadow, and transform. Returns true if
			 * the draw was handled (useful for overriding functionality).
			 * 
			 * <i>NOTE: This method is mainly for internal use, though it may be useful for advanced uses.</i>
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Returns a clone of this Shape. Some properties that are specific to this instance's current context are reverted to
			 * their defaults (for example .parent).
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}