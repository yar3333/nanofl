package nanofl.ide.editor.tools;

import easeljs.display.Container;
import easeljs.display.Shape;
import nanofl.ide.editor.Editor;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.EditorLibrary;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.tools.DropperEditorTool;
import nanofl.ide.undo.document.UndoQueue;
import nanofl.ide.ui.View;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.PointTools;

#if profiler @:build(Profiler.buildMarked()) #end
class EditorTool
{
	var editor : Editor;
	var library : EditorLibrary;
	var navigator : Navigator;
	var view : View;
	
	var newObjectParams : NewObjectParams;
	var undoQueue : UndoQueue;
	
	function new(editor:Editor, library:EditorLibrary, navigator:Navigator, view:View, newObjectParams:NewObjectParams, undoQueue:UndoQueue)
	{
		this.editor = editor;
		this.library = library;
		this.navigator = navigator;
		this.view = view;
		
		this.newObjectParams = newObjectParams;
		this.undoQueue = undoQueue;
		
		view.movie.statusBar.text = getStatusBarText();
		
		init();
	}
	
	function init() {}
	
	public static function create<T:EditorTool>(clas:Class<T>, editor:Editor, library:EditorLibrary, navigator:Navigator, view:View, newObjectParams:NewObjectParams, undoQueue:UndoQueue) : T
	{
		switch (clas)
		{
			case SelectEditorTool:		return cast new SelectEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case TransformEditorTool:	return cast new TransformEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case GradientEditorTool:	return cast new GradientEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case TextEditorTool:		return cast new TextEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case LineEditorTool:		return cast new LineEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case RectangleEditorTool:	return cast new RectangleEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case OvalEditorTool:		return cast new OvalEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case FillEditorTool:		return cast new FillEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case DropperEditorTool:		return cast new DropperEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case PencilEditorTool:		return cast new PencilEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case EraserEditorTool:		return cast new EraserEditorTool(editor, library, navigator, view, newObjectParams, undoQueue);
			case _:						throw "Unknow tool class = " + Type.getClassName(clas) + ".";
		};
	}
	
	//@:allow(components.nanofl.movie.part2D.editor)
	public function createControls(controls:Container) {}
	
	public function beginEditing(item:EditorElement) {}
	public function endEditing() {}
	
	public function isShowCenterCross() return true;
	public function isShowRegPoints() return true;
	
	public function getCursor() return "default";
	
	public function stageClick(e:EditorMouseEvent) {}
	
	public function stageMouseDown(e:EditorMouseEvent) {}
	public function stageMouseMove(e:EditorMouseEvent) {}
	public function stageMouseUp(e:EditorMouseEvent) {}
	public function stageDoubleClick(e:EditorMouseEvent) navigator.navigateUp();
	public function stageRightMouseDown(e:EditorMouseEvent) {}
	public function stageRightMouseUp(e:EditorMouseEvent) {}

	public function itemMouseDown(e:EditorMouseEvent, item:EditorElement) {}
	public function itemPressUp(e:EditorMouseEvent) {}
	
	public function itemChanged(item:EditorElement) {}
	public function figureChanged() {}
	
	public function onSelectedTranslate(dx:Float, dy:Float) {}
	
	public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject return PropertiesObject.NONE;
	
	function getStatusBarText() : String return "";
	
	public function allowContextMenu() return true;
	
	@:profile
	public function draw(shapeSelections:Shape, itemSelections:Shape)
	{
		editor.updateElements();
	}
	
	public function selectionChange()
	{
		view.movie.timeline.selectLayersActiveFrames(editor.getSelectedLayerIndexes());
		editor.updateShapes();
	}
	
	function isActiveLayerEditable() : Bool
	{
		if (editor.activeLayer == null)
		{
			view.alerter.warning("There is no active layer.");
			return false;
			
		}
		
		if (!editor.activeLayer.editable)
		{
			view.alerter.warning(editor.activeLayer.getEditablessReason());
			return false;
		}
		
		return true;
	}
	
	function getMagnetPoint(x:Float, y:Float) : Point
	{
		return editor.magnet ? editor.figure.getMagnetPointEx(x, y).point : { x:x, y:y };
	}
	
	function getShiftPoint(startPos:Point, newPos:Point) : Point
	{
		if (!editor.shift) return newPos;
		
		var dx = newPos.x - startPos.x;
		var dy = newPos.y - startPos.y;
		
		var magnetPoints = [];
		for (a in [ -75, -60, -45, -30, -15, 0, 15, 30, 45, 60, 75, 90 ])
		{
			magnetPoints.push( { x:startPos.x + dy * Math.tan(Math.PI * a / 180), y:newPos.y } );
			magnetPoints.push( { x:newPos.x, y:startPos.y + dx * Math.tan(Math.PI * a / 180) } );
		}
		
		return newPos.getNearest(magnetPoints);
	}
}
