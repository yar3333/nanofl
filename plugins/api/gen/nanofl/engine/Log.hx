package nanofl.engine;

extern class Log {
	static function init(fileSystem:nanofl.ide.sys.FileSystem, folders:nanofl.ide.sys.Folders, alerter:components.nanofl.others.alerter.Code):Void;
	static function logShapeCombineError(shapeA:nanofl.ide.undo.states.ShapeState, shapeB:nanofl.ide.undo.states.ShapeState):Void;
	static function toError(v:Dynamic):js.lib.Error;
	static var console(default, never) : Console;
}