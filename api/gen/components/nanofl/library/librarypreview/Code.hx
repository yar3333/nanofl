package components.nanofl.library.librarypreview;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var item(default, set) : nanofl.engine.ILibraryItem;
	private function set_item(item:nanofl.engine.ILibraryItem):nanofl.engine.ILibraryItem;
	function resize(maxWidth:Int, maxHeight:Int):Void;
}