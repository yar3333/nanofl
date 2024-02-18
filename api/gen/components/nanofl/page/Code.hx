package components.nanofl.page;

extern class Code extends wquery.Component implements nanofl.ide.ILayout {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var view(default, null) : nanofl.ide.ui.View;
	var popups(default, null) : nanofl.ide.ui.Popups;
	var openedFiles(default, null) : nanofl.ide.OpenedFiles;
	var dragAndDrop(default, null) : nanofl.ide.draganddrop.DragAndDrop;
	function getTemplate():components.nanofl.page.Template;
	function showLibraryPanel():Void;
	function showPropertiesPanel():Void;
	function showOutputPanel():Void;
}