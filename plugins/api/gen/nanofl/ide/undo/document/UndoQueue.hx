package nanofl.ide.undo.document;

extern class UndoQueue extends undoqueue.UndoQueue<nanofl.ide.undo.document.Changes, nanofl.ide.undo.document.Operation> {
	override function beginTransaction(changes:nanofl.ide.undo.document.Changes):Void;
	override function commitTransaction():Void;
	override function documentSaved():Void;
}