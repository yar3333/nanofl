package nanofl.ide.commands;

import nanofl.ide.libraryitems.IIdeInstancableItem;
import nanofl.engine.elements.Instance;
import nanofl.ide.Clipboard;
import nanofl.ide.editor.tools.*;
import nanofl.ide.editor.Editor;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;

@:rtti
class EditorGroup extends BaseGroup
{
	@inject var view : View;
	@inject var clipboard : Clipboard;
	@inject var popups : Popups;
	
	// common
	
	public function convertToSymbol()
	{
        app.document.editor.convertToSymbol();
	}
	
	public function selectAll()
	{
        app.document.editor.selectAll();
	}
	
	public function deselectAll()
	{
        app.document.editor.deselectAll();
	}
	
	public function toggleSelection()
	{
        app.document.editor.toggleSelection();
	}
	
	public function breakApart()
	{
        app.document.editor.breakApartSelected();
	}
	
	public function duplicate()
	{
        app.document.editor.duplicateSelected();
	}
	
	public function removeTransform()
	{
        app.document.editor.removeTransformFromSelected();
	}
	
	public function remove()
	{
        app.document.editor.removeSelected();
	}
	
	public function cut()				tempActiveView(ActiveView.EDITOR, clipboard.cut);
	public function copy()				tempActiveView(ActiveView.EDITOR, clipboard.copy);
	public function paste()				tempActiveView(ActiveView.EDITOR, clipboard.paste);
	
	public function properties()
	{
		var pathItem = app.document.navigator.pathItem;
        //if (Std.isOfType(pathItem.element, Instance)) // TODO: group
        {
            popups.symbolProperties.show(pathItem.mcItem);
        }
	}
	
	public function dump()
	{
        trace(app.document.editor.figure.getSelectedStrokeEdges().join("\n"));
	}
	
	public function switchToSelectTool() 	switchTool(SelectEditorTool);
	public function switchToTransformTool()	switchTool(TransformEditorTool);
	public function switchToTextTool()		switchTool(TextEditorTool);
	public function switchToPencilTool()	switchTool(PencilEditorTool);
	public function switchToEraserTool()	switchTool(EraserEditorTool);
	public function switchToLineTool()		switchTool(LineEditorTool);
	public function switchToRectangleTool()	switchTool(RectangleEditorTool);
	public function switchToOvalTool()		switchTool(OvalEditorTool);
	public function switchToFillTool()		switchTool(FillEditorTool);
	public function switchToGradientTool()	switchTool(GradientEditorTool);
	public function switchToDropperTool()	switchTool(DropperEditorTool);
	
	public function group()				editor.groupSelected();
	
	public function translateLeft()		translateSelected( -1,   0);
	public function translateRight()	translateSelected(  1,   0);
	public function translateUp()		translateSelected(  0,  -1);
	public function translateDown()		translateSelected(  0,   1);
	
	public function jumpLeft()			translateSelected(-10,   0);
	public function jumpRight()			translateSelected( 10,   0);
	public function jumpUp()			translateSelected(  0, -10);
	public function jumpDown()			translateSelected(  0,  10);
	
	public function moveForwards()		editor.moveSelectedForwards();
	public function moveBackwards()		editor.moveSelectedBackwards();
	public function moveFront()			editor.moveSelectedFront();
	public function moveBack()			editor.moveSelectedBack();
	
	public function flipHorizontal()	editor.flipSelectedHorizontal();
	public function flipVertical()		editor.flipSelectedVertical();
	
	var editor(get, never) : Editor; function get_editor() : Editor
	{
        return app.document.editor;
	}
	
	function switchTool<T:EditorTool>(klass:Class<T>)
	{
        view.movie.toolbar.switchTo(klass);
	}
	
	function translateSelected(dx:Float, dy:Float)
	{
        var k = 100 / app.document.editor.zoomLevel;
        app.document.editor.translateSelected(dx * k, dy * k);
	}
}
