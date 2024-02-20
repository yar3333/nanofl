package components.nanofl.movie.toolbar;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var toolType(default, null) : Class<nanofl.ide.editor.tools.EditorTool>;
	function set(tool:nanofl.ide.editor.tools.EditorTool):Void;
	function switchTo<T:(nanofl.ide.editor.tools.EditorTool)>(clas:Class<T>):Void;
}