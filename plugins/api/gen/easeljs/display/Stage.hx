package easeljs.display;

/**
 * A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
 * method is called, it will render its display list to its target canvas.
 *
 * <h4>Example</h4>
 * This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
 * and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
 *
 *      var stage = new createjs.Stage("canvasElementId");
 *      var image = new createjs.Bitmap("imagePath.png");
 *      stage.addChild(image);
 *      createjs.Ticker.addEventListener("tick", handleTick);
 *      function handleTick(event) {
 *          image.x += 10;
 *          stage.update();
 *      }
 */
/**
	
	 * A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
	 * method is called, it will render its display list to its target canvas.
	 * 
	 * <h4>Example</h4>
	 * This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
	 * and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
	 * 
	 *      var stage = new createjs.Stage("canvasElementId");
	 *      var image = new createjs.Bitmap("imagePath.png");
	 *      stage.addChild(image);
	 *      createjs.Ticker.addEventListener("tick", handleTick);
	 *      function handleTick(event) {
	 *          image.x += 10;
	 *          stage.update();
	 *      }
	 
**/
@:native('createjs.Stage') extern class Stage extends easeljs.display.Container {
	function new(canvas:Dynamic):Void;
	/**
		
			 * Indicates whether the stage should automatically clear the canvas before each render. You can set this to <code>false</code>
			 * to manually control clearing (for generative art, or when pointing multiple stages at the same canvas for
			 * example).
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var stage = new createjs.Stage("canvasId");
			 *      stage.autoClear = false;
			 
	**/
	var autoClear : Bool;
	/**
		
			 * The canvas the stage will render to. Multiple stages can share a single canvas, but you must disable autoClear for all but the
			 * first stage that will be ticked (or they will clear each other's render).
			 * 
			 * When changing the canvas property you must disable the events on the old canvas, and enable events on the
			 * new canvas or mouse events will not work as expected. For example:
			 * 
			 *      myStage.enableDOMEvents(false);
			 *      myStage.canvas = anotherCanvas;
			 *      myStage.enableDOMEvents(true);
			 
	**/
	var canvas : js.html.CanvasElement;
	/**
		
			 * The current mouse X position on the canvas. If the mouse leaves the canvas, this will indicate the most recent
			 * position over the canvas, and mouseInBounds will be set to false.
			 
	**/
	var mouseX : Float;
	/**
		
			 * The current mouse Y position on the canvas. If the mouse leaves the canvas, this will indicate the most recent
			 * position over the canvas, and mouseInBounds will be set to false.
			 
	**/
	var mouseY : Float;
	/**
		
			 * Specifies the area of the stage to affect when calling update. This can be use to selectively
			 * re-draw specific regions of the canvas. If null, the whole canvas area is drawn.
			 
	**/
	var drawRect : easeljs.geom.Rectangle;
	/**
		
			 * Indicates whether display objects should be rendered on whole pixels. You can set the
			 * {{#crossLink "DisplayObject/snapToPixel"}}{{/crossLink}} property of
			 * display objects to false to enable/disable this behaviour on a per instance basis.
			 
	**/
	var snapToPixelEnabled : Bool;
	/**
		
			 * Indicates whether the mouse is currently within the bounds of the canvas.
			 
	**/
	var mouseInBounds : Bool;
	/**
		
			 * If true, tick callbacks will be called on all display objects on the stage prior to rendering to the canvas.
			 
	**/
	var tickOnUpdate : Bool;
	/**
		
			 * If true, mouse move events will continue to be called when the mouse leaves the target canvas. See
			 * {{#crossLink "Stage/mouseInBounds:property"}}{{/crossLink}}, and {{#crossLink "MouseEvent"}}{{/crossLink}}
			 * x/y/rawX/rawY.
			 
	**/
	var mouseMoveOutside : Bool;
	/**
		
			 * Prevents selection of other elements in the html page if the user clicks and drags, or double clicks on the canvas.
			 * This works by calling `preventDefault()` on any mousedown events (or touch equivalent) originating on the canvas.
			 
	**/
	var preventSelection : Bool;
	/**
		
			 * Specifies a target stage that will have mouse / touch interactions relayed to it after this stage handles them.
			 * This can be useful in cases where you have multiple layered canvases and want user interactions
			 * events to pass through. For example, this would relay mouse events from topStage to bottomStage:
			 * 
			 *      topStage.nextStage = bottomStage;
			 * 
			 * To disable relaying, set nextStage to null.
			 * 
			 * MouseOver, MouseOut, RollOver, and RollOut interactions are also passed through using the mouse over settings
			 * of the top-most stage, but are only processed if the target stage has mouse over interactions enabled.
			 * Considerations when using roll over in relay targets:<OL>
			 * <LI> The top-most (first) stage must have mouse over interactions enabled (via enableMouseOver)</LI>
			 * <LI> All stages that wish to participate in mouse over interaction must enable them via enableMouseOver</LI>
			 * <LI> All relay targets will share the frequency value of the top-most stage</LI>
			 * </OL>
			 * To illustrate, in this example the targetStage would process mouse over interactions at 10hz (despite passing
			 * 30 as it's desired frequency):
			 * 	topStage.nextStage = targetStage;
			 * 	topStage.enableMouseOver(10);
			 * 	targetStage.enableMouseOver(30);
			 * 
			 * If the target stage's canvas is completely covered by this stage's canvas, you may also want to disable its
			 * DOM events using:
			 * 
			 * 	targetStage.enableDOMEvents(false);
			 
	**/
	var nextStage : easeljs.display.Stage;
	/**
		
			 * Default event handler that calls the Stage {{#crossLink "Stage/update"}}{{/crossLink}} method when a {{#crossLink "DisplayObject/tick:event"}}{{/crossLink}}
			 * event is received. This allows you to register a Stage instance as a event listener on {{#crossLink "Ticker"}}{{/crossLink}}
			 * directly, using:
			 * 
			 *      Ticker.addEventListener("tick", myStage);
			 * 
			 * Note that if you subscribe to ticks using this pattern, then the tick event object will be passed through to
			 * display object tick handlers, instead of <code>delta</code> and <code>paused</code> parameters.
			 
	**/
	var handleEvent : Dynamic;
	/**
		
			 * Each time the update method is called, the stage will call {{#crossLink "Stage/tick"}}{{/crossLink}}
			 * unless {{#crossLink "Stage/tickOnUpdate:property"}}{{/crossLink}} is set to false,
			 * and then render the display list to the canvas.
			 
	**/
	function update(?props:Dynamic):Void;
	/**
		
			 * Propagates a tick event through the display list. This is automatically called by {{#crossLink "Stage/update"}}{{/crossLink}}
			 * unless {{#crossLink "Stage/tickOnUpdate:property"}}{{/crossLink}} is set to false.
			 * 
			 * If a props object is passed to `tick()`, then all of its properties will be copied to the event object that is
			 * propagated to listeners.
			 * 
			 * Some time-based features in EaselJS (for example {{#crossLink "Sprite/framerate"}}{{/crossLink}} require that
			 * a {{#crossLink "Ticker/tick:event"}}{{/crossLink}} event object (or equivalent object with a delta property) be
			 * passed as the `props` parameter to `tick()`. For example:
			 * 
			 * 	Ticker.on("tick", handleTick);
			 * 	function handleTick(evtObj) {
			 * 		// clone the event object from Ticker, and add some custom data to it:
			 * 		var evt = evtObj.clone().set({greeting:"hello", name:"world"});
			 * 		
			 * 		// pass it to stage.update():
			 * 		myStage.update(evt); // subsequently calls tick() with the same param
			 * 	}
			 * 	
			 * 	// ...
			 * 	myDisplayObject.on("tick", handleDisplayObjectTick);
			 * 	function handleDisplayObjectTick(evt) {
			 * 		console.log(evt.delta); // the delta property from the Ticker tick event object
			 * 		console.log(evt.greeting, evt.name); // custom data: "hello world"
			 * 	}
			 
	**/
	function tick(?props:Dynamic):Void;
	/**
		
			 * Clears the target canvas. Useful if {{#crossLink "Stage/autoClear:property"}}{{/crossLink}} is set to `false`.
			 
	**/
	function clear():Void;
	/**
		
			 * Returns a data url that contains a Base64-encoded image of the contents of the stage. The returned data url can
			 * be specified as the src value of an image element.
			 
	**/
	function toDataURL(?backgroundColor:String, ?mimeType:String):String;
	/**
		
			 * Enables or disables (by passing a frequency of 0) mouse over ({{#crossLink "DisplayObject/mouseover:event"}}{{/crossLink}}
			 * and {{#crossLink "DisplayObject/mouseout:event"}}{{/crossLink}}) and roll over events ({{#crossLink "DisplayObject/rollover:event"}}{{/crossLink}}
			 * and {{#crossLink "DisplayObject/rollout:event"}}{{/crossLink}}) for this stage's display list. These events can
			 * be expensive to generate, so they are disabled by default. The frequency of the events can be controlled
			 * independently of mouse move events via the optional `frequency` parameter.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var stage = new createjs.Stage("canvasId");
			 *      stage.enableMouseOver(10); // 10 updates per second
			 
	**/
	function enableMouseOver(?frequency:Float):Void;
	/**
		
			 * Enables or disables the event listeners that stage adds to DOM elements (window, document and canvas). It is good
			 * practice to disable events when disposing of a Stage instance, otherwise the stage will continue to receive
			 * events from the page.
			 * 
			 * When changing the canvas property you must disable the events on the old canvas, and enable events on the
			 * new canvas or mouse events will not work as expected. For example:
			 * 
			 *      myStage.enableDOMEvents(false);
			 *      myStage.canvas = anotherCanvas;
			 *      myStage.enableDOMEvents(true);
			 
	**/
	function enableDOMEvents(?enable:Bool):Void;
	/**
		
			 * Stage instances cannot be cloned.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}