package js.three.animation;

@:native("THREE.AnimationMixer") extern class AnimationMixer extends js.three.core.EventDispatcher<js.three.animation.AnimationMixerEventMap> {
	function new(root:haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>):Void;
	/**
		
			 * @default 0
			 
	**/
	var time : Float;
	/**
		
			 * @default 1.0
			 
	**/
	var timeScale : Float;
	function clipAction(clip:js.three.animation.AnimationClip, ?root:haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>, ?blendMode:js.three.AnimationBlendMode):js.three.animation.AnimationAction;
	function existingAction(clip:js.three.animation.AnimationClip, ?root:haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>):js.three.animation.AnimationAction;
	function stopAllAction():js.three.animation.AnimationMixer;
	function update(deltaTime:Float):js.three.animation.AnimationMixer;
	function setTime(timeInSeconds:Float):js.three.animation.AnimationMixer;
	function getRoot():haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>;
	function uncacheClip(clip:js.three.animation.AnimationClip):Void;
	function uncacheRoot(root:haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>):Void;
	function uncacheAction(clip:js.three.animation.AnimationClip, ?root:haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, js.three.animation.AnimationObjectGroup>):Void;
}