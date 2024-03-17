package components.nanofl.page;

extern class Code extends wquery.Component implements nanofl.ide.ILayout {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function getTemplate():components.nanofl.page.Template;
	function showLibraryPanel():Void;
	function showPropertiesPanel():Void;
	function showOutputPanel():Void;
}