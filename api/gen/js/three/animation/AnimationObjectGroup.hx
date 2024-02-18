package js.three.animation;

@:native("THREE.AnimationObjectGroup") extern class AnimationObjectGroup {
	function new(args:Dynamic):Void;
	var uuid : String;
	var stats : { var bindingsPerObject : Float; var objects : { var inUse : Float; var total : Float; }; };
	var isAnimationObjectGroup(default, null) : Bool;
	function add(args:Dynamic):Void;
	function remove(args:Dynamic):Void;
	function uncache(args:Dynamic):Void;
}