package components.nanofl.movie.timeline;

import htmlparser.XmlBuilder;
import nanofl.engine.LayerType;

typedef TLLayer =
{
	var name : String;
	var type : LayerType;
	var locked : Bool;
	var visible : Bool;
	var parentIndex : Int;
	
	function getIcon() : String;
	function save(out:XmlBuilder) : Void;
	function getTotalFrames() : Int;
	function getFrame(frameIndex:Int) : TLFrame;
	function removeFrame(frameIndex:Int) : Void;
	function getHumanType() : String;
	
	function insertFrame(index:Int) : Void;
	function convertToKeyFrame(index:Int, ?blank:Bool) : Bool;
}