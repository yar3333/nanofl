package components.nanofl.movie.toolbar;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var SelectEditorTool(get, never) : js.JQuery;
	var TransformEditorTool(get, never) : js.JQuery;
	var TextEditorTool(get, never) : js.JQuery;
	var PencilEditorTool(get, never) : js.JQuery;
	var EraserEditorTool(get, never) : js.JQuery;
	var LineEditorTool(get, never) : js.JQuery;
	var RectangleEditorTool(get, never) : js.JQuery;
	var OvalEditorTool(get, never) : js.JQuery;
	var FillEditorTool(get, never) : js.JQuery;
	var GradientEditorTool(get, never) : js.JQuery;
	var DropperEditorTool(get, never) : js.JQuery;
}