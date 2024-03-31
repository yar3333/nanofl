package nanofl.ide.library.droppers;

extern class LibraryItemToLibraryItemDropProcessor extends nanofl.ide.library.droppers.BaseLibraryItemToLibraryDropProcessor {
	function new():Void;
	static function getTargetFolderForDrop(app:nanofl.ide.Application, e:js.JQuery.JqEvent):String;
}