package tweenjs;

/**
 * Base class that both {{#crossLink "Tween"}}{{/crossLink}} and {{#crossLink "Timeline"}}{{/crossLink}} extend. Should not be instantiated directly.
 */
/**
	
	 * Base class that both {{#crossLink "Tween"}}{{/crossLink}} and {{#crossLink "Timeline"}}{{/crossLink}} extend. Should not be instantiated directly.
	 
**/
@:native('createjs.AbstractTween') extern class AbstractTween extends createjs.events.EventDispatcher {
	function new(?props:Dynamic):Void;
	/**
		
			 * Causes this tween to continue playing when a global pause is active. For example, if TweenJS is using {{#crossLink "Ticker"}}{{/crossLink}},
			 * then setting this to false (the default) will cause this tween to be paused when `Ticker.paused` is set to
			 * `true`. See the {{#crossLink "Tween/tick"}}{{/crossLink}} method for more info. Can be set via the `props`
			 * parameter.
			 
	**/
	var ignoreGlobalPause : Bool;
	/**
		
			 * Indicates the number of times to loop. If set to -1, the tween will loop continuously.
			 * 
			 * Note that a tween must loop at _least_ once to see it play in both directions when `{{#crossLink "AbstractTween/bounce:property"}}{{/crossLink}}`
			 * is set to `true`.
			 
	**/
	var loop : Int;
	/**
		
			 * Uses ticks for all durations instead of milliseconds. This also changes the behaviour of some actions (such as `call`).
			 * Changing this value on a running tween could have unexpected results.
			 
	**/
	var useTicks : Bool;
	/**
		
			 * Causes the tween to play in reverse.
			 
	**/
	var reversed : Bool;
	/**
		
			 * Causes the tween to reverse direction at the end of each loop. Each single-direction play-through of the
			 * tween counts as a single bounce. For example, to play a tween once forward, and once back, set the
			 * `{{#crossLink "AbstractTween/loop:property"}}{{/crossLink}}` to `1`.
			 
	**/
	var bounce : Bool;
	/**
		
			 * Changes the rate at which the tween advances. For example, a `timeScale` value of `2` will double the
			 * playback speed, a value of `0.5` would halve it.
			 
	**/
	var timeScale : Float;
	/**
		
			 * Indicates the duration of this tween in milliseconds (or ticks if `useTicks` is true), irrespective of `loops`.
			 * This value is automatically updated as you modify the tween. Changing it directly could result in unexpected
			 * behaviour.
			 
	**/
	var duration(default, null) : Float;
	/**
		
			 * The current normalized position of the tween. This will always be a value between 0 and `duration`.
			 * Changing this property directly will have unexpected results, use {{#crossLink "Tween/setPosition"}}{{/crossLink}}.
			 
	**/
	var position(default, null) : Float;
	/**
		
			 * The raw tween position. This value will be between `0` and `loops * duration` while the tween is active, or -1 before it activates.
			 
	**/
	var rawPosition(default, null) : Float;
	/**
		
			 * Pauses or unpauses the tween. A paused tween is removed from the global registry and is eligible for garbage
			 * collection if no other references to it exist.
			 
	**/
	var paused : Bool;
	/**
		
			 * Returns the name of the label on or immediately before the current position. For example, given a tween with
			 * two labels, "first" on frame index 4, and "second" on frame 8, `currentLabel` would return:
			 * <UL>
			 * 		<LI>null if the current position is 2.</LI>
			 * 		<LI>"first" if the current position is 4.</LI>
			 * 		<LI>"first" if the current position is 7.</LI>
			 * 		<LI>"second" if the current position is 15.</LI>
			 * </UL>
			 
	**/
	var currentLabel : String;
	/**
		
			 * Advances the tween by a specified amount.
			 
	**/
	function advance(delta:Float, ?ignoreActions:Bool):Void;
	/**
		
			 * Advances the tween to a specified position.
			 
	**/
	function setPosition(rawPosition:Float, ?ignoreActions:Bool, ?jump:Bool, ?callback:haxe.Constraints.Function):Void;
	/**
		
			 * Calculates a normalized position based on a raw position. For example, given a tween with a duration of 3000ms set to loop:
			 * 	console.log(myTween.calculatePosition(3700); // 700
			 
	**/
	function calculatePosition(rawPosition:Float):Void;
	/**
		
			 * Returns a list of the labels defined on this tween sorted by position.
			 
	**/
	function getLabels():Array<{ public var position(default, default) : Float; public var label(default, default) : String; }>;
	/**
		
			 * Defines labels for use with gotoAndPlay/Stop. Overwrites any previously set labels.
			 
	**/
	function setLabels(labels:Dynamic<Float>):Void;
	/**
		
			 * Adds a label that can be used with {{#crossLink "Timeline/gotoAndPlay"}}{{/crossLink}}/{{#crossLink "Timeline/gotoAndStop"}}{{/crossLink}}.
			 
	**/
	function addLabel(label:String, position:Float):Void;
	/**
		
			 * Unpauses this timeline and jumps to the specified position or label.
			 
	**/
	function gotoAndPlay(positionOrLabel:haxe.extern.EitherType<Float, String>):Void;
	/**
		
			 * Pauses this timeline and jumps to the specified position or label.
			 
	**/
	function gotoAndStop(positionOrLabel:haxe.extern.EitherType<Float, String>):Void;
	/**
		
			 * If a numeric position is passed, it is returned unchanged. If a string is passed, the position of the
			 * corresponding frame label will be returned, or `null` if a matching label is not defined.
			 
	**/
	function resolve(positionOrLabel:haxe.extern.EitherType<Float, String>):Float;
}