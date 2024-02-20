package undoqueue;

extern class UndoQueue<Changes, Operation:(EnumValue)> {
	/**
		
			 * This method may be called several times with different operations.
			 
	**/
	function beginTransaction(changes:Changes):Void;
	function cancelTransaction():Void;
	function revertTransaction():Void;
	function forgetTransaction():Void;
	function commitTransaction():Void;
	function undo():Void;
	function redo():Void;
	function canUndo():Bool;
	function canRedo():Bool;
	function documentSaved():Void;
	function isDocumentModified():Bool;
	function toString():String;
}