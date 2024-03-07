package nanofl.ide;

typedef ElementLifeTrack = {
	var element : nanofl.engine.elements.Element;
	var globalFrameIndex : Int;
	var lifetimeFrames : Int;
};

extern class ElementLifeTracker {
	function new(item:nanofl.ide.libraryitems.MovieClipItem, checkAutoPlay:Bool):Void;
	var tracks : Array<nanofl.ide.ElementLifeTracker.ElementLifeTrack>;
}