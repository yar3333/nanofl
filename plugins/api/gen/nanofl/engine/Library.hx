package nanofl.engine;

extern class Library {
	var libraryDir(default, null) : String;
	function addItem<TLibraryItem:(nanofl.engine.ILibraryItem)>(item:TLibraryItem):Void;
	function removeItem(namePath:String):Void;
	function getItem(namePath:String):nanofl.engine.ILibraryItem;
	function getItems(?includeScene:Bool):Array<nanofl.engine.ILibraryItem>;
	function hasItem(namePath:String):Bool;
	function realUrl(url:String):String;
	function preload():js.lib.Promise<{ }>;
	function getItemCount():Int;
	function getItemsInFolder(folderNamePath:String):Array<nanofl.engine.ILibraryItem>;
	function clone():nanofl.engine.Library;
	function getSceneItem():nanofl.engine.libraryitems.MovieClipItem;
	function getSceneInstance():nanofl.engine.elements.Instance;
	function getInstancableItems():Array<nanofl.engine.libraryitems.InstancableItem>;
	function getBitmaps():Array<nanofl.engine.libraryitems.BitmapItem>;
	function getMeshes():Array<nanofl.engine.libraryitems.MeshItem>;
	function getSounds():Array<nanofl.engine.libraryitems.SoundItem>;
	function getFonts():Array<nanofl.engine.Font>;
	function equ(library:nanofl.engine.Library):Bool;
	static var SCENE_NAME_PATH(default, never) : String;
	static var GROUPS_NAME_PATH(default, never) : String;
}