package nanofl.ide;

extern class ElementLifeTracker {
	var tracks : Array<nanofl.ide.ElementLifeTrack>;
	function getTrackOne(element:nanofl.engine.elements.Element):nanofl.ide.ElementLifeTrack;
	static function createForMovieClip(item:nanofl.engine.libraryitems.MovieClipItem, deep:Bool):nanofl.ide.ElementLifeTracker;
	static function createForLayer(item:nanofl.engine.libraryitems.MovieClipItem, layerIndex:Int, deep:Bool):nanofl.ide.ElementLifeTracker;
}