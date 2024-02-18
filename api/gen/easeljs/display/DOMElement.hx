package easeljs.display;

typedef DOMElementTickEvent = {
	var params : Array<Dynamic>;
	var target : Dynamic;
	var type : String;
};

/**
 * <b>This class is still experimental, and more advanced use is likely to be buggy. Please report bugs.</b>
 *
 * A DOMElement allows you to associate a HTMLElement with the display list. It will be transformed
 * within the DOM as though it is child of the {{#crossLink "Container"}}{{/crossLink}} it is added to. However, it is
 * not rendered to canvas, and as such will retain whatever z-index it has relative to the canvas (ie. it will be
 * drawn in front of or behind the canvas).
 *
 * The position of a DOMElement is relative to their parent node in the DOM. It is recommended that
 * the DOM Object be added to a div that also contains the canvas so that they share the same position
 * on the page.
 *
 * DOMElement is useful for positioning HTML elements over top of canvas content, and for elements
 * that you want to display outside the bounds of the canvas. For example, a tooltip with rich HTML
 * content.
 *
 * <h4>Mouse Interaction</h4>
 *
 * DOMElement instances are not full EaselJS display objects, and do not participate in EaselJS mouse
 * events or support methods like hitTest. To get mouse events from a DOMElement, you must instead add handlers to
 * the htmlElement (note, this does not support EventDispatcher)
 *
 *      var domElement = new createjs.DOMElement(htmlElement);
 *      domElement.htmlElement.onclick = function() {
 *          console.log("clicked");
 *      }
 *
 * <strong>Important:</strong> This class needs to be notified it is about to be drawn, this will happen automatically
 * if you call stage.update, calling stage.draw or disabling tickEnabled will miss important steps and it will render
 * stale information.
 */
/**
	
	 * <b>This class is still experimental, and more advanced use is likely to be buggy. Please report bugs.</b>
	 * 
	 * A DOMElement allows you to associate a HTMLElement with the display list. It will be transformed
	 * within the DOM as though it is child of the {{#crossLink "Container"}}{{/crossLink}} it is added to. However, it is
	 * not rendered to canvas, and as such will retain whatever z-index it has relative to the canvas (ie. it will be
	 * drawn in front of or behind the canvas).
	 * 
	 * The position of a DOMElement is relative to their parent node in the DOM. It is recommended that
	 * the DOM Object be added to a div that also contains the canvas so that they share the same position
	 * on the page.
	 * 
	 * DOMElement is useful for positioning HTML elements over top of canvas content, and for elements
	 * that you want to display outside the bounds of the canvas. For example, a tooltip with rich HTML
	 * content.
	 * 
	 * <h4>Mouse Interaction</h4>
	 * 
	 * DOMElement instances are not full EaselJS display objects, and do not participate in EaselJS mouse
	 * events or support methods like hitTest. To get mouse events from a DOMElement, you must instead add handlers to
	 * the htmlElement (note, this does not support EventDispatcher)
	 * 
	 *      var domElement = new createjs.DOMElement(htmlElement);
	 *      domElement.htmlElement.onclick = function() {
	 *          console.log("clicked");
	 *      }
	 * 
	 * <strong>Important:</strong> This class needs to be notified it is about to be drawn, this will happen automatically
	 * if you call stage.update, calling stage.draw or disabling tickEnabled will miss important steps and it will render
	 * stale information.
	 
**/
@:native('createjs.DOMElement') extern class DOMElement extends easeljs.display.DisplayObject {
	function new(htmlElement:js.html.Element):Void;
	/**
		
			 * The DOM object to manage.
			 
	**/
	var htmlElement : js.html.Element;
	/**
		
			 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
			 * Returns true if the draw was handled (useful for overriding functionality).
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function cache(x:Float, y:Float, width:Float, height:Float, ?scale:Float, ?options:Dynamic):Void;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function uncache():Void;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function updateCache(compositeOperation:String):Void;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function hitTest(x:Float, y:Float):Bool;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function localToGlobal(x:Float, y:Float, ?pt:Dynamic):easeljs.geom.Point;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function globalToLocal(x:Float, y:Float, ?pt:Dynamic):easeljs.geom.Point;
	/**
		
			 * Not applicable to DOMElement.
			 
	**/
	override function localToLocal(x:Float, y:Float, target:easeljs.display.DisplayObject, ?pt:Dynamic):easeljs.geom.Point;
	/**
		
			 * DOMElement cannot be cloned. Throws an error.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}