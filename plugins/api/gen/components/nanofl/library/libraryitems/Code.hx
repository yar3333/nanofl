package components.nanofl.library.libraryitems;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var onActiveItemChange : wquery.Event<{ public var namePath(default, default) : String; }>;
	var readOnly : Bool;
	function filterItems(item:nanofl.ide.libraryitems.IIdeLibraryItem):Bool;
	function update():Void;
	function showPropertiesPopup():Void;
	function getItemElementBounds(namePath:String):easeljs.geom.Rectangle;
	function updateVisibility():Void;
	function removeSelected():Void;
	function renameSelectedByUser():Void;
	function getSelectedItems():Array<nanofl.ide.libraryitems.IIdeLibraryItem>;
	function deselectAll():Void;
	function select(namePaths:Array<String>):Void;
	function gotoPrevItem(overwriteSelection:Bool):Void;
	function gotoNextItem(overwriteSelection:Bool):Void;
}