package nanofl.ide.undo.document;

extern class Transaction extends undoqueue.Transaction<nanofl.ide.undo.document.Operation> {
	function new(document:nanofl.ide.Document, view:nanofl.ide.ui.View, ?operations:Array<nanofl.ide.undo.document.Operation>):Void;
}