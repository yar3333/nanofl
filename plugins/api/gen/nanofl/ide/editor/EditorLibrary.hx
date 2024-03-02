package nanofl.ide.editor;

extern class EditorLibrary extends nanofl.ide.InjectContainer {
	function new(library:nanofl.ide.library.IdeLibrary, document:nanofl.ide.Document):Void;
	var libraryDir(get, never) : String;
	private function get_libraryDir():String;
	var activeItem(get, set) : nanofl.ide.libraryitems.IIdeLibraryItem;
	private function get_activeItem():nanofl.ide.libraryitems.IIdeLibraryItem;
	private function set_activeItem(v:nanofl.ide.libraryitems.IIdeLibraryItem):nanofl.ide.libraryitems.IIdeLibraryItem;
	function addItems(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>, ?addUndoTransaction:Bool):Void;
	function canRenameItem(oldNamePath:String, newNamePath:String):Bool;
	function renameItems(itemRenames:Array<{ public var oldNamePath(default, default) : String; public var newNamePath(default, default) : String; }>):Void;
	function removeItems(namePaths:Array<String>):Void;
	function copyAndChangeDir(libraryDir:String):Void;
	function getNextItemName():String;
	function hasItem(namePath:String):Bool;
	function addFont(family:String, variants:Array<nanofl.engine.FontVariant>):Void;
	function preload():js.lib.Promise<{ }>;
	function getItem(namePath:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	function getSceneInstance():nanofl.engine.elements.Instance;
	function getSceneItem():nanofl.ide.libraryitems.MovieClipItem;
	function getItems(?includeScene:Bool):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function getRawLibrary():nanofl.ide.library.IdeLibrary;
	function getSelectedItemsWithDependencies():Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function hasSelected():Bool;
	function removeSelected():Void;
	function renameByUser(namePath:String):Void;
	function deselectAll():Void;
	function update():Void;
	function getSelectedItems():Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function gotoPrevItem(overwriteSelection:Bool):Void;
	function gotoNextItem(overwriteSelection:Bool):Void;
	function showPropertiesPopup():Void;
	function createEmptyMovieClip():Void;
	function createFolder():Void;
	function importFiles(?folderPath:String):js.lib.Promise<{ }>;
	function importFont():Void;
	function addUploadedFiles(files:Array<js.html.File>, ?folderPath:String):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
	function addFilesFromClipboard():Bool;
	function copyFilesIntoLibrary(srcDir:String, relativePaths:Array<String>):Void;
	function selectUnusedItems():Void;
	function removeUnusedItems():Void;
	function optimize():Void;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, folder:String):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
	function getWithExandedFolders(items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function fixErrors():Void;
	function publishItems(settings:nanofl.ide.PublishSettings, destDir:String):nanofl.ide.library.IdeLibrary;
}