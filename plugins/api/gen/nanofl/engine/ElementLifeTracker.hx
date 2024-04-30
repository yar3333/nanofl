package nanofl.engine;

extern class ElementLifeTracker {
	var tracks : Array<nanofl.engine.ElementLifeTrack>;
	function getTrackOne(element:nanofl.engine.elements.Element):nanofl.engine.ElementLifeTrack;
	static function createForMovieClip(item:nanofl.engine.libraryitems.MovieClipItem, deep:Bool):nanofl.engine.ElementLifeTracker;
	static function createForLayer(item:nanofl.engine.libraryitems.MovieClipItem, layerIndex:Int, deep:Bool):nanofl.engine.ElementLifeTracker;
}