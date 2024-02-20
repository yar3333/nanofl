package components.nanofl.movie.movie;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var navigator : components.nanofl.movie.navigator.Code;
	var timeline : components.nanofl.movie.timeline.Code;
	var editor : components.nanofl.movie.editor.Code;
	var toolbar : components.nanofl.movie.toolbar.Code;
	var statusBar : components.nanofl.others.statusbar.Code;
	var zoomer : components.nanofl.movie.zoomer.Code;
	function resize():Void;
	function show():Void;
	function hide():Void;
}