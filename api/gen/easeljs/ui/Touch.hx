package easeljs.ui;

/**
 * Global utility for working with multi-touch enabled devices in EaselJS. Currently supports W3C Touch API (iOS and
 * modern Android browser) and the Pointer API (IE), including ms-prefixed events in IE10, and unprefixed in IE11.
 *
 * Ensure that you {{#crossLink "Touch/disable"}}{{/crossLink}} touch when cleaning up your application. You do not have
 * to check if touch is supported to enable it, as it will fail gracefully if it is not supported.
 *
 * <h4>Example</h4>
 *
 *      var stage = new createjs.Stage("canvasId");
 *      createjs.Touch.enable(stage);
 *
 * <strong>Note:</strong> It is important to disable Touch on a stage that you are no longer using:
 *
 *      createjs.Touch.disable(stage);
 */
/**
	
	 * Global utility for working with multi-touch enabled devices in EaselJS. Currently supports W3C Touch API (iOS and
	 * modern Android browser) and the Pointer API (IE), including ms-prefixed events in IE10, and unprefixed in IE11.
	 * 
	 * Ensure that you {{#crossLink "Touch/disable"}}{{/crossLink}} touch when cleaning up your application. You do not have
	 * to check if touch is supported to enable it, as it will fail gracefully if it is not supported.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var stage = new createjs.Stage("canvasId");
	 *      createjs.Touch.enable(stage);
	 * 
	 * <strong>Note:</strong> It is important to disable Touch on a stage that you are no longer using:
	 * 
	 *      createjs.Touch.disable(stage);
	 
**/
@:native('createjs.Touch') extern class Touch {
	/**
		
			 * Returns `true` if touch is supported in the current browser.
			 
	**/
	static function isSupported():Bool;
	/**
		
			 * Enables touch interaction for the specified EaselJS {{#crossLink "Stage"}}{{/crossLink}}. Currently supports iOS
			 * (and compatible browsers, such as modern Android browsers), and IE10/11. Supports both single touch and
			 * multi-touch modes. Extends the EaselJS {{#crossLink "MouseEvent"}}{{/crossLink}} model, but without support for
			 * double click or over/out events. See the MouseEvent {{#crossLink "MouseEvent/pointerId:property"}}{{/crossLink}}
			 * for more information.
			 
	**/
	static function enable(stage:easeljs.display.Stage, ?singleTouch:Bool, ?allowDefault:Bool):Bool;
	/**
		
			 * Removes all listeners that were set up when calling `Touch.enable()` on a stage.
			 
	**/
	static function disable(stage:easeljs.display.Stage):Void;
}