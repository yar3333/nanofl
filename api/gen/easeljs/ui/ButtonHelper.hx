package easeljs.ui;

/**
 * The ButtonHelper is a helper class to create interactive buttons from {{#crossLink "MovieClip"}}{{/crossLink}} or
 * {{#crossLink "Sprite"}}{{/crossLink}} instances. This class will intercept mouse events from an object, and
 * automatically call {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}},
 * to the respective animation labels, add a pointer cursor, and allows the user to define a hit state frame.
 *
 * The ButtonHelper instance does not need to be added to the stage, but a reference should be maintained to prevent
 * garbage collection.
 *
 * Note that over states will not work unless you call {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}}.
 *
 * <h4>Example</h4>
 *
 *      var helper = new createjs.ButtonHelper(myInstance, "out", "over", "down", false, myInstance, "hit");
 *      myInstance.addEventListener("click", handleClick);
 *      function handleClick(event) {
 *          // Click Happened.
 *      }
 */
/**
	
	 * The ButtonHelper is a helper class to create interactive buttons from {{#crossLink "MovieClip"}}{{/crossLink}} or
	 * {{#crossLink "Sprite"}}{{/crossLink}} instances. This class will intercept mouse events from an object, and
	 * automatically call {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}},
	 * to the respective animation labels, add a pointer cursor, and allows the user to define a hit state frame.
	 * 
	 * The ButtonHelper instance does not need to be added to the stage, but a reference should be maintained to prevent
	 * garbage collection.
	 * 
	 * Note that over states will not work unless you call {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}}.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var helper = new createjs.ButtonHelper(myInstance, "out", "over", "down", false, myInstance, "hit");
	 *      myInstance.addEventListener("click", handleClick);
	 *      function handleClick(event) {
	 *          // Click Happened.
	 *      }
	 
**/
@:native('createjs.ButtonHelper') extern class ButtonHelper {
	function new(target:Dynamic, ?outLabel:String, ?overLabel:String, ?downLabel:String, ?play:Bool, ?hitArea:easeljs.display.DisplayObject, ?hitLabel:String):Void;
	/**
		
			 * The target for this button helper.
			 
	**/
	var target : Dynamic;
	/**
		
			 * The label name or frame number to display when the user mouses out of the target. Defaults to "over".
			 
	**/
	var overLabel : Dynamic;
	/**
		
			 * The label name or frame number to display when the user mouses over the target. Defaults to "out".
			 
	**/
	var outLabel : Dynamic;
	/**
		
			 * The label name or frame number to display when the user presses on the target. Defaults to "down".
			 
	**/
	var downLabel : Dynamic;
	/**
		
			 * If true, then ButtonHelper will call gotoAndPlay, if false, it will use gotoAndStop. Default is false.
			 
	**/
	var play : Bool;
	/**
		
			 * Enables or disables the button functionality on the target.
			 
	**/
	var enabled : Bool;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
}