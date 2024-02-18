package js.three.animation;

@:native("THREE.AnimationClip") extern class AnimationClip {
	function new(?name:String, ?duration:Float, ?tracks:Array<js.three.animation.KeyframeTrack>, ?blendMode:js.three.AnimationBlendMode):Void;
	var name : String;
	var tracks : Array<js.three.animation.KeyframeTrack>;
	/**
		
			 * @default THREE.NormalAnimationBlendMode
			 
	**/
	var blendMode : js.three.AnimationBlendMode;
	/**
		
			 * @default -1
			 
	**/
	var duration : Float;
	var uuid : String;
	var results : Array<Dynamic>;
	function resetDuration():js.three.animation.AnimationClip;
	function trim():js.three.animation.AnimationClip;
	function validate():Bool;
	function optimize():js.three.animation.AnimationClip;
	function clone():js.three.animation.AnimationClip;
	function toJSON(clip:js.three.animation.AnimationClip):Dynamic;
	static function CreateFromMorphTargetSequence(name:String, morphTargetSequence:Array<js.three.animation.MorphTarget>, fps:Float, noLoop:Bool):js.three.animation.AnimationClip;
	static function findByName(clipArray:Array<js.three.animation.AnimationClip>, name:String):js.three.animation.AnimationClip;
	static function CreateClipsFromMorphTargetSequences(morphTargets:Array<js.three.animation.MorphTarget>, fps:Float, noLoop:Bool):Array<js.three.animation.AnimationClip>;
	static function parse(json:Dynamic):js.three.animation.AnimationClip;
	static function parseAnimation(animation:Dynamic, bones:Array<js.three.objects.Bone<js.three.core.Object3DEventMap>>):js.three.animation.AnimationClip;
	static function toJSON(clip:js.three.animation.AnimationClip):Dynamic;
}