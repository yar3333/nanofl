package js.three.loaders;

@:native("THREE.AnimationLoader") extern class AnimationLoader extends js.three.loaders.Loader<Array<js.three.animation.AnimationClip>, String> {
	function new(?manager:js.three.loaders.LoadingManager):Void;
	@:haxe.arguments(function(json:Dynamic))
	function parse(json:Dynamic):Array<js.three.animation.AnimationClip>;
}