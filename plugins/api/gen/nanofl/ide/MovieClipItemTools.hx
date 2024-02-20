package nanofl.ide;

extern class MovieClipItemTools {
	static function findInstances(item:nanofl.ide.libraryitems.MovieClipItem, callb:(nanofl.engine.elements.Instance, { public var layerIndex(default, default) : Int; public var keyFrameIndex(default, default) : Int; public var item(default, default) : nanofl.ide.libraryitems.MovieClipItem; }) -> Void):Void;
	static function iterateInstances(item:nanofl.ide.libraryitems.MovieClipItem, callb:nanofl.engine.elements.Instance -> Void):Void;
	static function getElements(item:nanofl.ide.libraryitems.MovieClipItem):Array<nanofl.engine.elements.Element>;
	static function getUsedNamePathCount(item:nanofl.ide.libraryitems.MovieClipItem, ?r:Map<String, Int>):Map<String, Int>;
	static function getUsedNamePaths(item:nanofl.ide.libraryitems.MovieClipItem, deep:Bool, useTextureAtlases:Bool, ?r:Array<String>):Array<String>;
}