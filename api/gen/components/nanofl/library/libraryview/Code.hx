package components.nanofl.library.libraryview;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var activeItem(get, set) : nanofl.ide.libraryitems.IIdeLibraryItem;
	private function get_activeItem():nanofl.ide.libraryitems.IIdeLibraryItem;
	private function set_activeItem(v:nanofl.ide.libraryitems.IIdeLibraryItem):nanofl.ide.libraryitems.IIdeLibraryItem;
	var readOnly(get, set) : Bool;
	private function get_readOnly():Bool;
	private function set_readOnly(v:Bool):Bool;
	var filterItems(get, set) : nanofl.ide.libraryitems.IIdeLibraryItem -> Bool;
	private function get_filterItems():nanofl.ide.libraryitems.IIdeLibraryItem -> Bool;
	private function set_filterItems(f:nanofl.ide.libraryitems.IIdeLibraryItem -> Bool):nanofl.ide.libraryitems.IIdeLibraryItem -> Bool;
	function resize(maxWidth:Int, maxHeight:Int):Void;
	function updateLayout():Void;
	function show():Void;
	function hide():Void;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function gotoPrevItem(overwriteSelection:Bool):Void;
	function gotoNextItem(overwriteSelection:Bool):Void;
	function showPropertiesPopup():Void;
	function update():Void;
	function getSelectedItems():Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function select(namePaths:Array<String>):Void;
}