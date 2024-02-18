package components.nanofl.movie.toolbar;

import nanofl.ide.Globals;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.ui.View;
import js.JQuery;
import nanofl.ide.ActiveView;
import nanofl.ide.Application;
import nanofl.ide.editor.tools.*;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	@inject var keyboard : Keyboard;
	@inject var view : View;
	
	public var toolType(default, null) : Class<EditorTool> = SelectEditorTool;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		for (elem in template().container.find(">*"))
		{
			elem.css("background-image", "url(editortools/" + elem.attr("id").substring(prefixID.length) + ".png)");
		}
		
		setToolTitle(template().SelectEditorTool,		"editor.switchToSelectTool");
		setToolTitle(template().TransformEditorTool,	"editor.switchToTransformTool");
		setToolTitle(template().TextEditorTool,			"editor.switchToTextTool");
		setToolTitle(template().PencilEditorTool,		"editor.switchToPencilTool");
		setToolTitle(template().EraserEditorTool,		"editor.switchToEraserTool");
		setToolTitle(template().LineEditorTool,			"editor.switchToLineTool");
		setToolTitle(template().RectangleEditorTool,	"editor.switchToRectangleTool");
		setToolTitle(template().OvalEditorTool,			"editor.switchToOvalTool");
		setToolTitle(template().FillEditorTool,			"editor.switchToFillTool");
		setToolTitle(template().GradientEditorTool,		"editor.switchToGradientTool");
		setToolTitle(template().DropperEditorTool,		"editor.switchToDropperTool");
	}
	
	public function set(tool:EditorTool)
	{
		toolType = Type.getClass(tool);
		template().container.find(">button").removeClass("active");
		var s = Type.getClassName(toolType);
		s = s.substr(s.lastIndexOf(".") + 1);
		template().container.find("#" + prefixID + s).addClass("active");
	}
	
	public function switchTo<T:EditorTool>(clas:Class<T>)
	{
		app.activeView = ActiveView.EDITOR;
		app.document.editor.switchTool(clas);
		view.properties.activate();
	}
	
	function setToolTitle(tool:JQuery, command:String)
	{
		var shortcuts = keyboard.getShortcutsForCommand(command);
		if (shortcuts.length > 0)
		{
			tool.attr("title", tool.attr("title") + " (" + shortcuts.join(", ") + ")");
		}
	}
	
	function SelectEditorTool_click(e)		switchTo(SelectEditorTool);
	function TransformEditorTool_click(e)	switchTo(TransformEditorTool);
	function GradientEditorTool_click(e)	switchTo(GradientEditorTool);
	function TextEditorTool_click(e)		switchTo(TextEditorTool);
	function PencilEditorTool_click(e)		switchTo(PencilEditorTool);
	function EraserEditorTool_click(e)		switchTo(EraserEditorTool);
	function LineEditorTool_click(e)		switchTo(LineEditorTool);
	function RectangleEditorTool_click(e)	switchTo(RectangleEditorTool);
	function OvalEditorTool_click(e)		switchTo(OvalEditorTool);
	function FillEditorTool_click(e)		switchTo(FillEditorTool);
	function DropperEditorTool_click(e)		switchTo(DropperEditorTool);
}