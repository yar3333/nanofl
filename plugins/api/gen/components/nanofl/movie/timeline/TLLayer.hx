package components.nanofl.movie.timeline;

typedef TLLayer = {
	function convertToKeyFrame(index:Int, ?blank:Bool):Bool;
	function getFrame(frameIndex:Int):components.nanofl.movie.timeline.TLFrame;
	function getHumanType():String;
	function getIcon():String;
	function getTotalFrames():Int;
	function insertFrame(index:Int):Void;
	var locked : Bool;
	var name : String;
	var parentIndex : Int;
	function removeFrame(frameIndex:Int):Void;
	function save(out:htmlparser.XmlBuilder):Void;
	var type : nanofl.engine.LayerType;
	var visible : Bool;
};