package components.nanofl.movie.toolbar;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var SelectEditorTool(get, never) : js.JQuery;
	inline function get_SelectEditorTool() return component.q('#SelectEditorTool');
	
	public var TransformEditorTool(get, never) : js.JQuery;
	inline function get_TransformEditorTool() return component.q('#TransformEditorTool');
	
	public var TextEditorTool(get, never) : js.JQuery;
	inline function get_TextEditorTool() return component.q('#TextEditorTool');
	
	public var PencilEditorTool(get, never) : js.JQuery;
	inline function get_PencilEditorTool() return component.q('#PencilEditorTool');
	
	public var EraserEditorTool(get, never) : js.JQuery;
	inline function get_EraserEditorTool() return component.q('#EraserEditorTool');
	
	public var LineEditorTool(get, never) : js.JQuery;
	inline function get_LineEditorTool() return component.q('#LineEditorTool');
	
	public var RectangleEditorTool(get, never) : js.JQuery;
	inline function get_RectangleEditorTool() return component.q('#RectangleEditorTool');
	
	public var OvalEditorTool(get, never) : js.JQuery;
	inline function get_OvalEditorTool() return component.q('#OvalEditorTool');
	
	public var FillEditorTool(get, never) : js.JQuery;
	inline function get_FillEditorTool() return component.q('#FillEditorTool');
	
	public var GradientEditorTool(get, never) : js.JQuery;
	inline function get_GradientEditorTool() return component.q('#GradientEditorTool');
	
	public var DropperEditorTool(get, never) : js.JQuery;
	inline function get_DropperEditorTool() return component.q('#DropperEditorTool');

	public function new(component:wquery.Component) this.component = component;
}