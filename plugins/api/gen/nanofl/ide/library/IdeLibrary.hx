package nanofl.ide.library;

extern class IdeLibrary extends nanofl.engine.Library {
	function new(libraryDir:String, ?items:datatools.ArrayRO<nanofl.ide.libraryitems.IIdeLibraryItem>):Void;
	override function getItem(namePath:String):nanofl.ide.libraryitems.IIdeLibraryItem;
	override function getSceneItem():nanofl.ide.libraryitems.MovieClipItem;
	override function getSceneInstance():nanofl.engine.elements.Instance;
	function getInstancableItemsAsIde():Array<nanofl.ide.libraryitems.IIdeInstancableItem>;
	function getItemsAsIde(?includeScene:Bool):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function getBitmapsAsIde():Array<nanofl.ide.libraryitems.BitmapItem>;
	function getSoundsAsIde():Array<nanofl.ide.libraryitems.SoundItem>;
	function getFontItemsAsIde():Array<nanofl.ide.libraryitems.FontItem>;
	function getItemsInFolderAsIde(folderNamePath:String):Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	override function realUrl(url:String):String;
	function addSceneWithFrame(?elements:Array<nanofl.engine.elements.Element>, ?layerName:String):nanofl.ide.libraryitems.MovieClipItem;
	override function clone():nanofl.ide.library.IdeLibrary;
	function loadItems():js.lib.Promise<{ }>;
	function addFont(family:String, variants:Array<nanofl.engine.FontVariant>):Void;
	function canRenameItem(oldNamePath:String, newNamePath:String):Bool;
	function renameItem(oldNamePath:String, newNamePath:String):Void;
	function publishLibraryJsFile(destDir:String):Void;
	function removeUnusedItems():Void;
	function optimize():Void;
	function getSceneFramesIterator(documentProperties:nanofl.ide.DocumentProperties, applyBackgroundColor:Bool):nanofl.ide.library.SceneFramesIterator;
	static var SCENE_NAME_PATH(default, never) : String;
}