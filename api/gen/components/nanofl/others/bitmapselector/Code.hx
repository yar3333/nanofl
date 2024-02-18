package components.nanofl.others.bitmapselector;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function bind(bitmaps:Array<nanofl.ide.libraryitems.BitmapItem>, ?bitmapPath:String):Void;
	function show():Void;
	function hide():Void;
}