package components.nanofl.others.mainmenu;

extern class Code extends wquery.Component implements nanofl.ide.ui.views.IMainMenuView {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function offset(pos:{ var left : Int; var top : Int; }):Void;
	function update():Void;
}