package components.nanofl.movie.timeline;

typedef TLKeyFrame =
{
	var duration : Int;
	var label : String;
	
	function isEmpty() : Bool;
	function hasGoodMotionTween() : Bool;
	function getIndex() : Int;
	function hasMotionTween() : Bool;
	function addDefaultMotionTween() : Void;
	function removeMotionTween() : Void;
	
	function clone() : TLKeyFrame;
}