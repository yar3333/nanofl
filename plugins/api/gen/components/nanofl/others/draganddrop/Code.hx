package components.nanofl.others.draganddrop;

extern class Code extends wquery.Component implements nanofl.ide.draganddrop.IDragAndDrop {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	/**
		
			 * Specify selector if you want to delegate from parent element specified by `elem`. In other case, set `selector` to null.
			 * If you use selector, then you must manualy add `draggable="true"` attribute to the draggable elements.
			 
	**/
	function draggable(elem:js.JQuery, selector:String, dragType:String, getData:(htmlparser.XmlBuilder, js.JQuery.JqEvent) -> nanofl.ide.draganddrop.AllowedDropEffect, ?removeMoved:htmlparser.HtmlNodeElement -> Void):Void;
	function droppable(elem:js.JQuery, ?selector:String, drops:Map<String, nanofl.ide.draganddrop.IDropArea>, ?filesDrop:(Array<js.html.File>, js.JQuery.JqEvent) -> Void):Void;
}