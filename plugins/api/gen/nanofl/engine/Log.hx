package nanofl.engine;

extern class Log {
	static function init(app:nanofl.engine.Log.AppLike, fileSystem:nanofl.ide.sys.FileSystem, folders:nanofl.ide.sys.Folders):Void;
	static function logShapeCombineError(shapeA:nanofl.ide.undo.states.ShapeState, shapeB:nanofl.ide.undo.states.ShapeState):Void;
	static function toError(v:Dynamic):js.lib.Error;
	static var console(default, never) : Console;
}

typedef AppLike = {
	var document(get, never) : { var id(default, null) : String; var path(default, null) : String; };
};