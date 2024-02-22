package nanofl.engine.libraryitems;

extern class LibraryItem implements nanofl.engine.ILibraryItem {
	var type(get, never) : nanofl.engine.LibraryItemType;
	private function get_type():nanofl.engine.LibraryItemType;
	var library(default, null) : nanofl.engine.Library;
	var namePath : String;
	function getIcon():String;
	function clone():nanofl.engine.libraryitems.LibraryItem;
	function preload():js.lib.Promise<{ }>;
	function setLibrary(library:nanofl.engine.Library):Void;
	function duplicate(newNamePath:String):nanofl.engine.libraryitems.LibraryItem;
	function remove():Void;
	function equ(item:nanofl.engine.ILibraryItem):Bool;
	function save(fileSystem:nanofl.ide.sys.FileSystem):Void;
	function saveToXml(xml:htmlparser.XmlBuilder):Void;
	function saveToJson():{ var type : String; };
	function loadPropertiesJson(obj:Dynamic):Void;
	function toString():String;
	static function loadFromJson(namePath:String, obj:{ var type : String; }):nanofl.engine.ILibraryItem;
}