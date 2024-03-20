package components.nanofl.common.contextmenu;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function build(target:js.JQuery, ?selector:String, items:Array<nanofl.ide.ui.menu.MenuItem>, ?beforeShow:(nanofl.ide.ui.menu.ContextMenu, js.JQuery.JqEvent, js.JQuery) -> Bool):Void;
	function getItem(command:String):js.JQuery;
	function getAllItems():js.JQuery;
	function showItem(command:String):Void;
	function toggleItem(command:String, b:Bool):Void;
	function showItems(commands:Array<String>):Void;
	function enableItem(command:String, b:Bool):Void;
}