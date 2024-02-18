package components.nanofl.library.libraryitems;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var preview : components.nanofl.library.librarypreview.Code;
	var active(get, set) : nanofl.ide.libraryitems.IIdeLibraryItem;
	private function get_active():nanofl.ide.libraryitems.IIdeLibraryItem;
	private function set_active(v:nanofl.ide.libraryitems.IIdeLibraryItem):nanofl.ide.libraryitems.IIdeLibraryItem;
	var readOnly : Bool;
	function filterItems(item:nanofl.ide.libraryitems.IIdeLibraryItem):Bool;
	function update():Void;
	function showPropertiesPopup():Void;
	function removeSelected():Void;
	function renameByUser(namePath:String):Void;
	function getSelectedItems():Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function deselectAll():Void;
	function select(namePaths:Array<String>):Void;
	function gotoPrevItem(overwriteSelection:Bool):Void;
	function gotoNextItem(overwriteSelection:Bool):Void;
}