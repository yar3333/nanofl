package easeljs.display;

/**
 * The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
 * you to create objects which encapsulate timeline animations, state changes, and synched actions. The MovieClip
 * class has been included in the EaselJS minified file since 0.7.0.
 *
 * Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
 * been made to support time-based timelines in the future.
 *
 * <h4>Example</h4>
 * This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
 * the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
 *
 *      var stage = new createjs.Stage("canvas");
 *      createjs.Ticker.addEventListener("tick", stage);
 *
 *      var mc = new createjs.MovieClip({loop:-1, labels:{myLabel:20}});
 *      stage.addChild(mc);
 *
 *      var child1 = new createjs.Shape(
 *          new createjs.Graphics().beginFill("#999999")
 *              .drawCircle(30,30,30));
 *      var child2 = new createjs.Shape(
 *          new createjs.Graphics().beginFill("#5a9cfb")
 *              .drawCircle(30,30,30));
 *
 *      mc.timeline.addTween(
 *          createjs.Tween.get(child1)
 *              .to({x:0}).to({x:60}, 50).to({x:0}, 50));
 *      mc.timeline.addTween(
 *          createjs.Tween.get(child2)
 *              .to({x:60}).to({x:0}, 50).to({x:60}, 50));
 *
 *      mc.gotoAndPlay("start");
 *
 * It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
 * immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
 * <code>tween.set()</code> method to affect properties will likely not provide the desired result.
 */
/**
	
	 * The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
	 * you to create objects which encapsulate timeline animations, state changes, and synched actions. The MovieClip
	 * class has been included in the EaselJS minified file since 0.7.0.
	 * 
	 * Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
	 * been made to support time-based timelines in the future.
	 * 
	 * <h4>Example</h4>
	 * This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
	 * the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
	 * 
	 *      var stage = new createjs.Stage("canvas");
	 *      createjs.Ticker.addEventListener("tick", stage);
	 * 
	 *      var mc = new createjs.MovieClip({loop:-1, labels:{myLabel:20}});
	 *      stage.addChild(mc);
	 * 
	 *      var child1 = new createjs.Shape(
	 *          new createjs.Graphics().beginFill("#999999")
	 *              .drawCircle(30,30,30));
	 *      var child2 = new createjs.Shape(
	 *          new createjs.Graphics().beginFill("#5a9cfb")
	 *              .drawCircle(30,30,30));
	 * 
	 *      mc.timeline.addTween(
	 *          createjs.Tween.get(child1)
	 *              .to({x:0}).to({x:60}, 50).to({x:0}, 50));
	 *      mc.timeline.addTween(
	 *          createjs.Tween.get(child2)
	 *              .to({x:60}).to({x:0}, 50).to({x:60}, 50));
	 * 
	 *      mc.gotoAndPlay("start");
	 * 
	 * It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
	 * immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
	 * <code>tween.set()</code> method to affect properties will likely not provide the desired result.
	 
**/
@:native('createjs.MovieClip') extern class MovieClip extends easeljs.display.Container {
	function new(?props:easeljs.display.MovieClip.MovieClipInitProps):Void;
	/**
		
			 * Controls how this MovieClip advances its time. Must be one of 0 (INDEPENDENT), 1 (SINGLE_FRAME), or 2 (SYNCHED).
			 * See each constant for a description of the behaviour.
			 
	**/
	var mode : easeljs.display.MovieClip.MovieClipMode;
	/**
		
			 * Specifies what the first frame to play in this movieclip, or the only frame to display if mode is SINGLE_FRAME.
			 
	**/
	var startPosition : Int;
	/**
		
			 * Specifies how many times this MovieClip should loop. A value of -1 indicates it should loop indefinitely. A value of
			 * 1 would cause it to loop once (ie. play a total of twice).
			 
	**/
	var loop : Int;
	/**
		
			 * The current frame of the movieclip.
			 
	**/
	var currentFrame : Int;
	/**
		
			 * If true, the MovieClip's position will not advance when ticked.
			 
	**/
	var paused : Bool;
	/**
		
			 * If true, actions in this MovieClip's tweens will be run when the playhead advances.
			 
	**/
	var actionsEnabled : Bool;
	/**
		
			 * If true, the MovieClip will automatically be reset to its first frame whenever the timeline adds
			 * it back onto the display list. This only applies to MovieClip instances with mode=INDEPENDENT.
			 * <br><br>
			 * For example, if you had a character animation with a "body" child MovieClip instance
			 * with different costumes on each frame, you could set body.autoReset = false, so that
			 * you can manually change the frame it is on, without worrying that it will be reset
			 * automatically.
			 
	**/
	var autoReset : Bool;
	/**
		
			 * An array of bounds for each frame in the MovieClip. This is mainly intended for tool output.
			 
	**/
	var frameBounds : Array<Dynamic>;
	/**
		
			 * By default MovieClip instances advance one frame per tick. Specifying a framerate for the MovieClip
			 * will cause it to advance based on elapsed time between ticks as appropriate to maintain the target
			 * framerate.
			 * 
			 * For example, if a MovieClip with a framerate of 10 is placed on a Stage being updated at 40fps, then the MovieClip will
			 * advance roughly one frame every 4 ticks. This will not be exact, because the time between each tick will
			 * vary slightly between frames.
			 * 
			 * This feature is dependent on the tick event object (or an object with an appropriate "delta" property) being
			 * passed into {{#crossLink "Stage/update"}}{{/crossLink}}.
			 
	**/
	var framerate : Float;
	/**
		
			 * The TweenJS Timeline that is associated with this MovieClip. This is created automatically when the MovieClip
			 * instance is initialized. Animations are created by adding <a href="http://tweenjs.com">TweenJS</a> Tween
			 * instances to the timeline.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var tween = createjs.Tween.get(target).to({x:0}).to({x:100}, 30);
			 *      var mc = new createjs.MovieClip();
			 *      mc.timeline.addTween(tween);
			 * 
			 * Elements can be added and removed from the timeline by toggling an "_off" property
			 * using the <code>tweenInstance.to()</code> method. Note that using <code>Tween.set</code> is not recommended to
			 * create MovieClip animations. The following example will toggle the target off on frame 0, and then back on for
			 * frame 1. You can use the "visible" property to achieve the same effect.
			 * 
			 *      var tween = createjs.Tween.get(target).to({_off:false})
			 *          .wait(1).to({_off:true})
			 *          .wait(1).to({_off:false});
			 
	**/
	var timeline : tweenjs.Timeline;
	/**
		
			 * Returns an array of objects with label and position (aka frame) properties, sorted by position.
			 
	**/
	var labels : Array<Dynamic>;
	/**
		
			 * Returns the name of the label on or immediately before the current frame.
			 
	**/
	var currentLabel : String;
	/**
		
			 * Returns the duration of this MovieClip in frames.
			 
	**/
	var totalFrames : Int;
	/**
		
			 * Returns the duration of this MovieClip in seconds or ticks.
			 
	**/
	var duration : Float;
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
		
			 * Sets paused to false.
			 
	**/
	function play():Void;
	/**
		
			 * Sets paused to true.
			 
	**/
	function stop():Void;
	/**
		
			 * Advances this movie clip to the specified position or label and sets paused to false.
			 
	**/
	function gotoAndPlay(positionOrLabel:Dynamic):Void;
	/**
		
			 * Advances this movie clip to the specified position or label and sets paused to true.
			 
	**/
	function gotoAndStop(positionOrLabel:Dynamic):Void;
	/**
		
			 * Advances the playhead. This occurs automatically each tick by default.
			 
	**/
	function advance(?time:Float):Void;
	/**
		
			 * MovieClip instances cannot be cloned.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}

typedef MovieClipInitProps = {
	/**
		
		     * If true, actions in this MovieClip's tweens will be run when the playhead advances.
		     
	**/
	@:optional
	var actionsEnabled : Bool;
	/**
		
		     * If true, the MovieClip will automatically be reset to its first frame whenever the timeline adds
		     * it back onto the display list. This only applies to MovieClip instances with mode=INDEPENDENT.
		     * <br><br>
		     * For example, if you had a character animation with a "body" child MovieClip instance
		     * with different costumes on each frame, you could set body.autoReset = false, so that
		     * you can manually change the frame it is on, without worrying that it will be reset
		     * automatically.
		     
	**/
	@:optional
	var autoReset : Bool;
	/**
		
		     * The current frame of the movieclip.
		     
	**/
	@:optional
	var currentFrame : Int;
	/**
		
		     * Returns the name of the label on or immediately before the current frame.
		     
	**/
	@:optional
	var currentLabel : String;
	/**
		
		     * Returns the duration of this MovieClip in seconds or ticks.
		     
	**/
	@:optional
	var duration : Float;
	/**
		
		     * An array of bounds for each frame in the MovieClip. This is mainly intended for tool output.
		     
	**/
	@:optional
	var frameBounds : Array<Dynamic>;
	/**
		
		     * By default MovieClip instances advance one frame per tick. Specifying a framerate for the MovieClip
		     * will cause it to advance based on elapsed time between ticks as appropriate to maintain the target
		     * framerate.
		     * 
		     * For example, if a MovieClip with a framerate of 10 is placed on a Stage being updated at 40fps, then the MovieClip will
		     * advance roughly one frame every 4 ticks. This will not be exact, because the time between each tick will
		     * vary slightly between frames.
		     * 
		     * This feature is dependent on the tick event object (or an object with an appropriate "delta" property) being
		     * passed into {{#crossLink "Stage/update"}}{{/crossLink}}.
		     
	**/
	@:optional
	var framerate : Float;
	/**
		
		     * Returns an array of objects with label and position (aka frame) properties, sorted by position.
		     
	**/
	@:optional
	var labels : Array<Dynamic>;
	/**
		
		     * Specifies how many times this MovieClip should loop. A value of -1 indicates it should loop indefinitely. A value of
		     * 1 would cause it to loop once (ie. play a total of twice).
		     
	**/
	@:optional
	var loop : Int;
	/**
		
			 * Controls how this MovieClip advances its time. Must be one of 0 (INDEPENDENT), 1 (SINGLE_FRAME), or 2 (SYNCHED).
			 * See each constant for a description of the behaviour.
			 
	**/
	@:optional
	var mode : easeljs.display.MovieClip.MovieClipMode;
	/**
		
		     * If true, the MovieClip's position will not advance when ticked.
		     
	**/
	@:optional
	var paused : Bool;
	/**
		
		     * Specifies what the first frame to play in this movieclip, or the only frame to display if mode is SINGLE_FRAME.
		     
	**/
	@:optional
	var startPosition : Int;
	/**
		
		     * The TweenJS Timeline that is associated with this MovieClip. This is created automatically when the MovieClip
		     * instance is initialized. Animations are created by adding <a href="http://tweenjs.com">TweenJS</a> Tween
		     * instances to the timeline.
		     * 
		     * <h4>Example</h4>
		     * 
		     *      var tween = createjs.Tween.get(target).to({x:0}).to({x:100}, 30);
		     *      var mc = new createjs.MovieClip();
		     *      mc.timeline.addTween(tween);
		     * 
		     * Elements can be added and removed from the timeline by toggling an "_off" property
		     * using the <code>tweenInstance.to()</code> method. Note that using <code>Tween.set</code> is not recommended to
		     * create MovieClip animations. The following example will toggle the target off on frame 0, and then back on for
		     * frame 1. You can use the "visible" property to achieve the same effect.
		     * 
		     *      var tween = createjs.Tween.get(target).to({_off:false})
		     *          .wait(1).to({_off:true})
		     *          .wait(1).to({_off:false});
		     
	**/
	@:optional
	var timeline : tweenjs.Timeline;
	/**
		
		     * Returns the duration of this MovieClip in frames.
		     
	**/
	@:optional
	var totalFrames : Int;
};

@:enum @:native("createjs.MovieClip") typedef MovieClipMode = Int;