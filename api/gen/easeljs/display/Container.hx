package easeljs.display;

/**
 * A Container is a nestable display list that allows you to work with compound display elements. For  example you could
 * group arm, leg, torso and head {{#crossLink "Bitmap"}}{{/crossLink}} instances together into a Person Container, and
 * transform them as a group, while still being able to move the individual parts relative to each other. Children of
 * containers have their <code>transform</code> and <code>alpha</code> properties concatenated with their parent
 * Container.
 *
 * For example, a {{#crossLink "Shape"}}{{/crossLink}} with x=100 and alpha=0.5, placed in a Container with <code>x=50</code>
 * and <code>alpha=0.7</code> will be rendered to the canvas at <code>x=150</code> and <code>alpha=0.35</code>.
 * Containers have some overhead, so you generally shouldn't create a Container to hold a single child.
 *
 * <h4>Example</h4>
 *
 *      var container = new createjs.Container();
 *      container.addChild(bitmapInstance, shapeInstance);
 *      container.x = 100;
 */
/**
	
	 * A Container is a nestable display list that allows you to work with compound display elements. For  example you could
	 * group arm, leg, torso and head {{#crossLink "Bitmap"}}{{/crossLink}} instances together into a Person Container, and
	 * transform them as a group, while still being able to move the individual parts relative to each other. Children of
	 * containers have their <code>transform</code> and <code>alpha</code> properties concatenated with their parent
	 * Container.
	 * 
	 * For example, a {{#crossLink "Shape"}}{{/crossLink}} with x=100 and alpha=0.5, placed in a Container with <code>x=50</code>
	 * and <code>alpha=0.7</code> will be rendered to the canvas at <code>x=150</code> and <code>alpha=0.35</code>.
	 * Containers have some overhead, so you generally shouldn't create a Container to hold a single child.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var container = new createjs.Container();
	 *      container.addChild(bitmapInstance, shapeInstance);
	 *      container.x = 100;
	 
**/
@:native('createjs.Container') extern class Container extends easeljs.display.DisplayObject {
	function new():Void;
	/**
		
			 * The array of children in the display list. You should usually use the child management methods such as
			 * {{#crossLink "Container/addChild"}}{{/crossLink}}, {{#crossLink "Container/removeChild"}}{{/crossLink}},
			 * {{#crossLink "Container/swapChildren"}}{{/crossLink}}, etc, rather than accessing this directly, but it is
			 * included for advanced uses.
			 
	**/
	var children : Array<easeljs.display.DisplayObject>;
	/**
		
			 * Indicates whether the children of this container are independently enabled for mouse/pointer interaction.
			 * If false, the children will be aggregated under the container - for example, a click on a child shape would
			 * trigger a click event on the container.
			 
	**/
	var mouseChildren : Bool;
	/**
		
			 * If false, the tick will not be propagated to children of this Container. This can provide some performance benefits.
			 * In addition to preventing the "tick" event from being dispatched, it will also prevent tick related updates
			 * on some display objects (ex. Sprite & MovieClip frame advancing, DOMElement visibility handling).
			 
	**/
	var tickChildren : Bool;
	/**
		
			 * Returns the number of children in the container.
			 
	**/
	var numChildren : Int;
	/**
		
			 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
			 * Returns true if the draw was handled (useful for overriding functionality).
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Adds a child to the top of the display list.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 		container.addChild(bitmapInstance);
			 * 
			 * You can also add multiple children at once:
			 * 
			 * 		container.addChild(bitmapInstance, shapeInstance, textInstance);
			 
	**/
	function addChild(child:easeljs.display.DisplayObject):easeljs.display.DisplayObject;
	/**
		
			 * Adds a child to the display list at the specified index, bumping children at equal or greater indexes up one, and
			 * setting its parent to this Container.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      addChildAt(child1, index);
			 * 
			 * You can also add multiple children, such as:
			 * 
			 *      addChildAt(child1, child2, ..., index);
			 * 
			 * The index must be between 0 and numChildren. For example, to add myShape under otherShape in the display list,
			 * you could use:
			 * 
			 *      container.addChildAt(myShape, container.getChildIndex(otherShape));
			 * 
			 * This would also bump otherShape's index up by one. Fails silently if the index is out of range.
			 
	**/
	function addChildAt(child:easeljs.display.DisplayObject, index:Int):easeljs.display.DisplayObject;
	/**
		
			 * Removes the specified child from the display list. Note that it is faster to use removeChildAt() if the index is
			 * already known.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      container.removeChild(child);
			 * 
			 * You can also remove multiple children:
			 * 
			 *      removeChild(child1, child2, ...);
			 * 
			 * Returns true if the child (or children) was removed, or false if it was not in the display list.
			 
	**/
	function removeChild(child:easeljs.display.DisplayObject):Bool;
	/**
		
			 * Removes the child at the specified index from the display list, and sets its parent to null.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      container.removeChildAt(2);
			 * 
			 * You can also remove multiple children:
			 * 
			 *      container.removeChild(2, 7, ...)
			 * 
			 * Returns true if the child (or children) was removed, or false if any index was out of range.
			 
	**/
	function removeChildAt(index:Int):Bool;
	/**
		
			 * Removes all children from the display list.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 	container.removeAllChildren();
			 
	**/
	function removeAllChildren():Void;
	/**
		
			 * Returns the child at the specified index.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      container.getChildAt(2);
			 
	**/
	function getChildAt(index:Int):easeljs.display.DisplayObject;
	/**
		
			 * Returns the child with the specified name.
			 
	**/
	function getChildByName(name:String):easeljs.display.DisplayObject;
	/**
		
			 * Performs an array sort operation on the child list.
			 * 
			 * <h4>Example: Display children with a higher y in front.</h4>
			 * 
			 *      var sortFunction = function(obj1, obj2, options) {
			 *          if (obj1.y > obj2.y) { return 1; }
			 *          if (obj1.y < obj2.y) { return -1; }
			 *          return 0;
			 *      }
			 *      container.sortChildren(sortFunction);
			 
	**/
	function sortChildren(sortFunction:Dynamic):Void;
	/**
		
			 * Returns the index of the specified child in the display list, or -1 if it is not in the display list.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var index = container.getChildIndex(child);
			 
	**/
	function getChildIndex(child:easeljs.display.DisplayObject):Int;
	/**
		
			 * Swaps the children at the specified indexes. Fails silently if either index is out of range.
			 
	**/
	function swapChildrenAt(index1:Float, index2:Float):Void;
	/**
		
			 * Swaps the specified children's depth in the display list. Fails silently if either child is not a child of this
			 * Container.
			 
	**/
	function swapChildren(child1:easeljs.display.DisplayObject, child2:easeljs.display.DisplayObject):Void;
	/**
		
			 * Changes the depth of the specified child. Fails silently if the child is not a child of this container, or the index is out of range.
			 
	**/
	function setChildIndex(child:easeljs.display.DisplayObject, index:Int):Void;
	/**
		
			 * Returns true if the specified display object either is this container or is a descendent (child, grandchild, etc)
			 * of this container.
			 
	**/
	function contains(child:easeljs.display.DisplayObject):Bool;
	/**
		
			 * Tests whether the display object intersects the specified local point (ie. draws a pixel with alpha > 0 at the
			 * specified position). This ignores the alpha, shadow and compositeOperation of the display object, and all
			 * transform properties including regX/Y.
			 
	**/
	override function hitTest(x:Float, y:Float):Bool;
	/**
		
			 * Similar to {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}}, but returns only the top-most display
			 * object. This runs significantly faster than <code>getObjectsUnderPoint()</code>, but is still potentially an expensive
			 * operation. See {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}} for more information.
			 
	**/
	function getObjectUnderPoint(x:Float, y:Float, ?mode:Int):easeljs.display.DisplayObject;
	/**
		
			 * Returns a clone of this Container. Some properties that are specific to this instance's current context are
			 * reverted to their defaults (for example .parent).
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}