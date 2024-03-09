package nanofl.ide;

typedef ElementLifeTrack = {
	var lifetimeFrames : Int;
	var sameElementSequence : Array<nanofl.engine.elements.Element>;
	var startFrameIndex : Int;
};

extern class ElementLifeTracker {
	var tracks : Array<nanofl.ide.ElementLifeTracker.ElementLifeTrack>;
	function getTrackOne(element:nanofl.engine.elements.Element):nanofl.ide.ElementLifeTracker.ElementLifeTrack;
	static function createForMovieClip(item:nanofl.engine.libraryitems.MovieClipItem, deep:Bool):nanofl.ide.ElementLifeTracker;
	static function createForLayer(item:nanofl.engine.libraryitems.MovieClipItem, layerIndex:Int, deep:Bool):nanofl.ide.ElementLifeTracker;
}