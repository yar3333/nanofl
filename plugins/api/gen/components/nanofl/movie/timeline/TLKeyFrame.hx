package components.nanofl.movie.timeline;

typedef TLKeyFrame = {
	function addDefaultMotionTween():Void;
	function clone():components.nanofl.movie.timeline.TLKeyFrame;
	var duration : Int;
	function getIndex():Int;
	function hasGoodMotionTween():Bool;
	function hasMotionTween():Bool;
	function isEmpty():Bool;
	var label : String;
	function removeMotionTween():Void;
};