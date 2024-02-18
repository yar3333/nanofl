package js.three.animation;

@:native("THREE.AnimationAction") extern class AnimationAction {
	function new(mixer:js.three.animation.AnimationMixer, clip:js.three.animation.AnimationClip, ?localRoot:js.three.core.Object3D<js.three.core.Object3DEventMap>, ?blendMode:js.three.AnimationBlendMode):Void;
	var blendMode : js.three.AnimationBlendMode;
	/**
		
			 * @default THREE.LoopRepeat
			 
	**/
	var loop : js.three.AnimationActionLoopStyles;
	/**
		
			 * @default 0
			 
	**/
	var time : Float;
	/**
		
			 * @default 1
			 
	**/
	var timeScale : Float;
	/**
		
			 * @default 1
			 
	**/
	var weight : Float;
	/**
		
			 * @default Infinity
			 
	**/
	var repetitions : Float;
	/**
		
			 * @default false
			 
	**/
	var paused : Bool;
	/**
		
			 * @default true
			 
	**/
	var enabled : Bool;
	/**
		
			 * @default false
			 
	**/
	var clampWhenFinished : Bool;
	/**
		
			 * @default true
			 
	**/
	var zeroSlopeAtStart : Bool;
	/**
		
			 * @default true
			 
	**/
	var zeroSlopeAtEnd : Bool;
	function play():js.three.animation.AnimationAction;
	function stop():js.three.animation.AnimationAction;
	function reset():js.three.animation.AnimationAction;
	function isRunning():Bool;
	function isScheduled():Bool;
	function startAt(time:Float):js.three.animation.AnimationAction;
	function setLoop(mode:js.three.AnimationActionLoopStyles, repetitions:Float):js.three.animation.AnimationAction;
	function setEffectiveWeight(weight:Float):js.three.animation.AnimationAction;
	function getEffectiveWeight():Float;
	function fadeIn(duration:Float):js.three.animation.AnimationAction;
	function fadeOut(duration:Float):js.three.animation.AnimationAction;
	function crossFadeFrom(fadeOutAction:js.three.animation.AnimationAction, duration:Float, warp:Bool):js.three.animation.AnimationAction;
	function crossFadeTo(fadeInAction:js.three.animation.AnimationAction, duration:Float, warp:Bool):js.three.animation.AnimationAction;
	function stopFading():js.three.animation.AnimationAction;
	function setEffectiveTimeScale(timeScale:Float):js.three.animation.AnimationAction;
	function getEffectiveTimeScale():Float;
	function setDuration(duration:Float):js.three.animation.AnimationAction;
	function syncWith(action:js.three.animation.AnimationAction):js.three.animation.AnimationAction;
	function halt(duration:Float):js.three.animation.AnimationAction;
	function warp(statTimeScale:Float, endTimeScale:Float, duration:Float):js.three.animation.AnimationAction;
	function stopWarping():js.three.animation.AnimationAction;
	function getMixer():js.three.animation.AnimationMixer;
	function getClip():js.three.animation.AnimationClip;
	function getRoot():js.three.core.Object3D<js.three.core.Object3DEventMap>;
}