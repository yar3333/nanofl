package nanofl.engine;

extern class MovieClipItemTools {
	static function findShapes(item:nanofl.engine.libraryitems.MovieClipItem, allFrames:Bool, ?matrix:nanofl.engine.geom.Matrix, callb:(nanofl.engine.elements.ShapeElement, { public var matrix(default, default) : nanofl.engine.geom.Matrix; public var layerIndex(default, default) : Int; public var item(default, default) : nanofl.engine.libraryitems.MovieClipItem; public var insideMask(default, default) : Bool; }) -> Void):Void;
	static function findMovieClipItems(item:nanofl.engine.libraryitems.MovieClipItem, allFrames:Bool, ?matrix:nanofl.engine.geom.Matrix, callb:(nanofl.engine.libraryitems.MovieClipItem, nanofl.engine.geom.Matrix, Bool) -> Void):Void;
	static function findInstances(item:nanofl.engine.libraryitems.MovieClipItem, allFrames:Bool, ?matrix:nanofl.engine.geom.Matrix, callb:(nanofl.engine.elements.Instance, { public var matrix(default, default) : nanofl.engine.geom.Matrix; public var layerIndex(default, default) : Int; public var keyFrameIndex(default, default) : Int; public var item(default, default) : nanofl.engine.libraryitems.MovieClipItem; public var insideMask(default, default) : Bool; }) -> Void, ?insideMask:Bool):Void;
	static function iterateInstances(item:nanofl.engine.libraryitems.MovieClipItem, allFrames:Bool, ?insideMask:Bool, callb:(nanofl.engine.elements.Instance, { public var layerIndex(default, default) : Int; public var keyFrameIndex(default, default) : Int; public var insideMask(default, default) : Bool; }) -> Void):Void;
	static function iterateElements(item:nanofl.engine.libraryitems.MovieClipItem, allFrames:Bool, ?insideMask:Bool, callb:(nanofl.engine.elements.Element, { public var layerIndex(default, default) : Int; public var keyFrameIndex(default, default) : Int; public var insideMask(default, default) : Bool; }) -> Void):Void;
}