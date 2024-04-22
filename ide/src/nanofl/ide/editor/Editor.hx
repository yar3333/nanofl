package nanofl.ide.editor;

import js.lib.Promise;
import easeljs.display.Container;
import easeljs.geom.Rectangle;
import htmlparser.XmlBuilder;
import htmlparser.XmlNodeElement;
import nanofl.engine.ISelectable;
import nanofl.ide.MovieClipItemTools;
import nanofl.engine.Version;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Elements;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.editor.EditorLayer;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.tools.EditorTool;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.undo.states.ElementsState;
import nanofl.ide.undo.states.TransformationState;
import nanofl.ide.Document;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
using nanofl.engine.geom.BoundsTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Editor extends InjectContainer
{
	@:isVar static var HIT_TEST_GAP(default, never) = 3;
	
	@inject var view : View;
	@inject var popups : Popups;
	@inject var newObjectParams : NewObjectParams;
	@inject var clipboard : Clipboard;
	
	var document : Document;
    var pathItem : PathItem;
	
	public var tool(default, null) : EditorTool;
	
	public var container(default, null) = new Container();
	
	public var layers : Array<EditorLayer>;
	
	public var activeLayer(get, never) : EditorLayer;
	@:noCompletion function get_activeLayer() return pathItem.layerIndex < layers.length ? layers[pathItem.layerIndex] : null;
	
	public var activeShape(get, never) : ShapeElement;
	@:noCompletion function get_activeShape() return activeLayer.shape.element;
	
	public var figure(default, null) : Figure;
	
	@:noCompletion var _magnet = false;
	public var magnet(get, set) : Bool;
	@:noCompletion function get_magnet() return _magnet;
	@:noCompletion function set_magnet(value) { if (_magnet != value) { _magnet = value; view.movie.editor.update(); } return _magnet; }
	
	@:noCompletion var _shift = false;
	public var shift(get, set) : Bool;
	@:noCompletion function get_shift() return _shift;
	@:noCompletion function set_shift(value) { if (_shift != value) { _shift = value; view.movie.editor.update(); } return _shift; }
	
	public var zoomLevel(get, set) : Float;
	@:noCompletion function get_zoomLevel() return view.movie.editor.zoomLevel;
	@:noCompletion function set_zoomLevel(value:Float) return view.movie.editor.zoomLevel = value;
	
	public var ready(get, never) : Bool;
	@:noCompletion function get_ready() return tool != null;
	
	var savedViewState : { zoom:Float, x:Float, y:Float };
	
	public function new(document:Document)
    {
        super();
        
        this.document = document;
    }
        
    @:profile
	public function beginEditing(pathItem:PathItem, isCenterView=false)
	{
		if (figure != null)
		{
			deselectAllWoUpdate();
			figure.updateShapes();
		}
		
		this.pathItem = pathItem;
		
		view.movie.timeline.fixActiveLayer();
		rebind(isCenterView);
	}
	
	@:profile
	public function switchTool<T:EditorTool>(clas:Class<T>) : T
	{
		if (tool != null) tool.endEditing();
		tool = EditorTool.create(clas, this, document.library, document.navigator, view, newObjectParams, document.undoQueue);
		view.movie.toolbar.set(tool);
		view.movie.editor.updateToolControls();
		update();
		return cast tool;
	}
	
	@:profile
	public function updateShapes()
	{
		figure.updateShapes();
		tool.figureChanged();
		update();
	}
	
	@:profile
	public function updateElement(element:Element)
	{
		for (item in getElements(true))
		{
			if (item.currentElement == element)
			{
				item.update();
				tool.itemChanged(item);
				break;
			}
		}
		update();
	}
	
	public function hasSelected() : Bool
	{
		for (layer in layers)
		{
			if (layer.hasSelected()) return true;
		}
		return false;
	}
	
	public function toggleSelection() : Bool
	{
		for (layer in layers)
		{
			if (layer.editable && !layer.isAllSelected())
			{
				selectAll();
				return true;
			}
		}
		deselectAll();
		return false;
	}
	
	public function select(obj:ISelectable, deselectOthers=true)
	{
		selectWoUpdate(obj, deselectOthers);
		update();
	}
	
	public function selectWoUpdate(obj:ISelectable, deselectOthers=true)
	{
        log("editor.selectWoUpdate");

		var changed = false;
		
		if (deselectOthers)
		{
			deselectAllWoUpdate();
			changed = true;
		}
		
		if (obj != null && !obj.selected)
		{
			obj.selected = true;
			changed = true;
		}
		
		if (changed) tool.selectionChange();
	}
	
	public function deselect(obj:ISelectable)
	{
		deselectWoUpdate(obj);
		update();
	}
	
	public function deselectWoUpdate(obj:ISelectable)
	{
        log("editor.deselectWoUpdate");

		var changed = false;
		
		if (obj != null && obj.selected)
		{
			obj.selected = false;
			changed = true;
		}
		
		if (changed) tool.selectionChange();
	}
	
	public function selectAll()
	{
		figure.selectAll();
		for (item in getElements())
		{
			item.selected = true;
		}
		tool.selectionChange();
		update();
	}
	
	public function deselectAll()
	{
		deselectAllWoUpdate();
		tool.selectionChange();
		update();
	}
	
	public function deselectAllWoUpdate()
	{
		figure.deselectAll();
		
		for (item in getSelectedItems())
		{
			item.selected = false;
		}
	}
	
	public function selectLayers(layerIndexes:Array<Int>)
	{
		for (i in 0...layers.length)
		{
			if (layerIndexes.has(i)) layers[i].selectAll();
			else					 layers[i].deselectAll();
		}
		tool.selectionChange();
		update();
	}
	
	public function isSelectedAtPos(pos:Point) : Bool
	{
		var d = getObjectAtPosEx(pos);
		return d != null && d.obj.selected;
	}
	
	public function getItemAtPos(pos:Point) : EditorElement
	{
		for (layer in layers)
		{
			var item = layer.getItemAtPos(pos);
			if (item != null) return item;
		}
		return null;
	}
	
	public function getObjectAtPosEx(pos:Point) : { obj:ISelectable, layerIndex:Int }
	{
		for (layer in getEditableLayers())
		{
			var r = layer.getObjectAtPos(pos);
			if (r != null) return { obj:r, layerIndex:layer.getIndex() };
		}
		return null;
	}
	
	public function breakApartSelected()
	{
        if (!hasSelected()) return;
		
        document.undoQueue.beginTransaction({ figure:true, elements:true });
		for (layer in layers)
		{
			layer.breakApartSelectedItems();
		}
		document.undoQueue.commitTransaction();
		tool.selectionChange();
		update();
	}
	
	public function removeSelected()
	{
        if (!hasSelected()) return;

		document.undoQueue.beginTransaction({ figure:true, elements:true });
		removeSelectedInner();
		tool.selectionChange();
		document.undoQueue.commitTransaction();
		update();
	}
	
	function removeSelectedInner()
	{
		figure.removeSelected();
		for (layer in layers)
		{
			layer.removeSelected();
		}
	}
	
	public function translateSelected(dx:Float, dy:Float, ?lowLevel:Bool)
	{
        if (!hasSelected()) return;

		if (!lowLevel)
		{
			document.undoQueue.beginTransaction({ figure:true, elements:true });
		}
		
		figure.translateSelected(dx, dy);
		
		for (item in getSelectedItems())
		{
			item.currentElement.translate(dx, dy);
		}
		
		tool.onSelectedTranslate(dx, dy);
		
		if (!lowLevel)
		{
			document.undoQueue.commitTransaction();
			update();
		}
	}
	
	public function updateElements()
	{
		for (item in getElements())
		{
			item.update();
		}
	}
	
	@:noprofile
	public function getElements(includeShape=false) : Array<EditorElement>
	{
		var r = [];
		for (layer in layers)
		{
			layer.getElements(r, includeShape);
		}
		return r;
	}
	
	@:noprofile
	public function getSelectedItems() : Array<EditorElement>
	{
		var r = [];
		for (layer in layers) layer.getSelectedElements(r);
		return r;
	}
	
	public function getObjectLayerIndex(obj:ISelectable) : Int
	{
		if (obj == null) return null;
		
		if (Std.isOfType(obj, StrokeEdge))
		{
			var strokeEdge : StrokeEdge = cast obj;
		}
		
		if (Std.isOfType(obj, EditorElement))
		{
			var item : EditorElement = cast obj;
			var index = 0;
			for (layer in layers)
			{
				if (layer.hasItem(item)) return index;
				index++;
			}
		}
		
		return null;
	}
	
	public function extractSelected() : Array<Element>
	{
		var r = new Array<Element>();
		var shapeElement = figure.extractSelected();
		if (shapeElement != null && !shapeElement.isEmpty()) r.push(shapeElement);
		r = r.concat(getSelectedItems().map(item -> item.originalElement));
		return r;
	}
	
	public function isItemCanBeAdded(item:IIdeLibraryItem) : Bool
	{
		if (!Std.isOfType(item, InstancableItem)) return false;
		return document.navigator.getNamePaths().foreach(namePath ->
		{
			if (item.namePath == namePath) return false;
			if (Std.isOfType(item, MovieClipItem) && MovieClipItemTools.getUsedNamePaths((cast item:MovieClipItem), true, false).contains(namePath)) return false;
			return true;
		});
	}

	public function addElement(element:Element, addUndoTransaction=true) : EditorElement
	{
		if (!Std.isOfType(element, Instance) || isItemCanBeAdded(cast((cast element:Instance).symbol, IIdeLibraryItem)))
		{
			if (addUndoTransaction) document.undoQueue.beginTransaction({ elements:true });
			final r = activeLayer.addElement(element);
			//rebind(); // `rebind()` recreate `EditorElement` so returned `r` became unused!
			if (addUndoTransaction) document.undoQueue.commitTransaction();
			return r;
		}
		else
		{
			view.alerter.error("Can't add symbol '" + (cast element:Instance).namePath + "': recursion detected.");
			return null;
		}
	}
	
	public function convertToSymbol()
	{
		if (hasSelected())
		{
			popups.symbolAdd.show("Convert to Symbol", document.library.getNextItemName(), e ->
			{
                convertSelectionToInstance(e.name, e.regX, e.regY);
			});
		}
		else
		{
			view.alerter.warning("Select something first.");
		}
	}

    function convertSelectionToInstance(namePath:String, regX:Int, regY:Int)
    {
        document.undoQueue.beginTransaction({ figure:true, elements:true, libraryAddItems:true });
        var instance = convertSelectionToInstanceInner(namePath, regX, regY);
        if (instance != null)
        {
            var editedElement = activeLayer.addElement(instance);
            editedElement.selected = true;
            document.undoQueue.commitTransaction();
            tool.selectionChange();
            document.library.update();
            update();
        }
        else
        {
            document.undoQueue.forgetTransaction();
        }
        tool.selectionChange();
    }
	
	function convertSelectionToInstanceInner(namePath:String, regX:Int, regY:Int) : Instance
	{
		var elements = new Array<Element>();
		
		var bounds = { minX:1e100, minY:1e100, maxX:-1e100, maxY:-1e100 };
		
		if (figure.hasSelected())
		{
			var shape = figure.extractSelected();
			shape.deselectAll();
			elements.push(shape);
			shape.getBounds(bounds);
		}
		
		for (item in getSelectedItems())
		{
			elements.push(item.originalElement);
			bounds.extendR(item.getTransformedBounds());
		}
		
		removeSelectedInner();
		
		if (elements.length == 0) return null;
		
		for (element in elements)
		{
			element.translate
			(
				-bounds.minX - (bounds.maxX - bounds.minX) / 2 * (regX + 1),
				-bounds.minY - (bounds.maxY - bounds.minY) / 2 * (regY + 1)
			);
		}
		
		final symbol = MovieClipItem.createWithFrame(namePath, elements);
		
		document.library.addItems([ symbol ], false);
        if (!symbol.isGroup()) document.library.select([ symbol.namePath ]);
		
		final instance = symbol.newInstance();
		instance.translate
		(
			bounds.minX + (bounds.maxX - bounds.minX) / 2 * (regX + 1),
			bounds.minY + (bounds.maxY - bounds.minY) / 2 * (regY + 1)
		);
		
		return instance;
	}
	
	public function groupSelected()
	{
        convertSelectionToInstance(document.library.getRawLibrary().getNextGroupNamePath(), 0, 0);
	}
	
	public function translateVertex(point:Point, dx:Float, dy:Float, addUndoTransaction=true)
	{
		if (addUndoTransaction) document.undoQueue.beginTransaction({ figure:true });
		
		figure.translateVertex(point, dx, dy);
		figure.combineSelf();
		
		if (addUndoTransaction) document.undoQueue.commitTransaction();
		
		update();
	}
	
	@:profile
	public function rebind(isCenterView=false) : Promise<{}>
	{
        if (tool != null) tool.endEditing();
		
		view.movie.timeline.updateActiveLayerFrames();

		layers = [];
        DisplayObjectTools.callMethod(container, "dispose");
		container.removeAllChildren();

		for (layer in pathItem.mcItem.layers)
		{
			var editorLayer = new EditorLayer(this, document.navigator, view, layer, pathItem.frameIndex, document.properties.framerate);
			layers.push(editorLayer);
			container.addChildAt(editorLayer.container, 0);
		}
		
		figure = new Figure(this, layers);
		
		tool = EditorTool.create(view.movie.toolbar.toolType, this, document.library, document.navigator, view, newObjectParams, document.undoQueue);
		
		view.movie.editor.updateToolControls();
		final r = view.movie.editor.rebind(isCenterView);
		view.properties.update();
		view.movie.zoomer.update();

        return r;
	}
	
	@:profile
	public function update()
	{
		var startTime = Date.now().getTime();
		
		view.movie.timeline.updateActiveLayerFrames();
		view.movie.timeline.updateActiveFrame();
		for (layer in layers) layer.update();
		view.movie.editor.update();
		view.properties.update();
		view.movie.zoomer.update();
		
		view.fpsMeter.editorUpdateCounter++;
		view.fpsMeter.editorUpdateTime += Date.now().getTime() - startTime;
	}
	
	public function showAllLayers()
	{
		for (layer in layers) layer.show();
		rebind();
	}
	
	public function hideAllLayers()
	{
		for (layer in layers) layer.hide();
		rebind();
	}
	
	public function lockAllLayers()
	{
		for (layer in layers) layer.lock();
		rebind();
	}
	
	public function unlockAllLayers()
	{
		for (layer in layers) layer.unlock();
		rebind();
	}
	
	@:allow(nanofl.ide.undo)
	function getTransformationStates() : Array<TransformationState>
	{
        log("getTransformationStates");
		
		return getElements().map(x -> TransformationState.fromElement(x.originalElement));
	}
	
	@:profile
	@:allow(nanofl.ide.undo)
	function setTransformationStates(states:Array<TransformationState>)
	{
        log("setTransformationStates" + states.length);

		final items = getElements();
		for (i in 0...states.length)
		{
			states[i].toElement(items[i].originalElement);
		}
		updateElements();
	}
	
	@:allow(nanofl.ide.undo)
	function getElementsState() : ElementsState
	{
        log("getElementsState");
		
		return new ElementsState(layers.map(layer -> layer.getElementsState()));
	}
	
	@:profile
	@:allow(nanofl.ide.undo)
	function setElementsState(state:ElementsState)
	{
        log("setElementsState");
		
		var layers = pathItem.mcItem.layers;
		for (i in 0...state.layerElements.length)
		{
			var frame = layers[i].getFrame(pathItem.frameIndex);
			stdlib.Debug.assert(frame != null && state.layerElements[i] != null || frame == null && state.layerElements[i] == null);
			if (frame != null) frame.keyFrame.setElementsState(state.layerElements[i]);
		}
	}
	
	public function getSelectedLayerIndexes() : Array<Int>
	{
		var r = [];
		for (i in 0...layers.length)
		{
			if (layers[i].hasSelected()) r.push(i);
		}
		return r;
	}
	
	function ensureActiveLayerFrameExists()
	{
		if (!activeLayer.editable)
		{
			js.Browser.alert(activeLayer.getEditablessReason());
			return false;
		}
		
		return true;
	}
	
	@:profile
	public function getPropertiesObject() return tool.getPropertiesObject(getSelectedItems());
	
	public function removeTransformFromSelected()
	{
		document.undoQueue.beginTransaction({ transformations:true });
		
		for (item in getSelectedItems())
		{
			var m = item.currentElement.matrix;
			if (m.a != 1.0 || m.b != 0.0 || m.c != 0.0 || m.d != 1.0)
			{
				m.a = 1.0;
				m.b = 0.0;
				m.c = 0.0;
				m.d = 1.0;
				
				item.update();
				tool.itemChanged(item);
			}
		}
		
		document.undoQueue.commitTransaction();
		
		update();
	}
	
	public function moveSelectedFront()
	{
		for (layer in layers)
		{
			layer.moveSelectedFront();
		}
		update();
	}
	
	public function moveSelectedForwards()
	{
		for (layer in layers)
		{
			layer.moveSelectedForwards();
		}
		update();
	}
	
	public function moveSelectedBackwards()
	{
		for (layer in layers)
		{
			layer.moveSelectedBackwards();
		}
		update();
	}
	
	public function moveSelectedBack()
	{
		for (layer in layers)
		{
			layer.moveSelectedBack();
		}
		update();
	}
	
	public function magnetSelectedToGuide(?invalidater:Invalidater)
	{
		for (layer in layers)
		{
			layer.magnetSelectedToGuide();
		}
		if (invalidater != null) invalidater.invalidateEditorLight();
		else update();
	}
	
	public function swapInstance(instance:Instance, newNamePath:String)
	{
		if (instance.namePath == newNamePath) return;
		
		instance.namePath = newNamePath;
		updateElement(instance);
	}
	
	public function saveSelectedToXml(out:XmlBuilder) : Array<IIdeLibraryItem>
	{
		out.begin("elements");
		var elements = extractSelected();
		for (element in elements) element.save(out);
		out.end();
		return Elements.getUsedSymbolNamePaths(elements).iterator().map(document.library.getItem);
	}
	
	public function pasteFromXml(xml:XmlNodeElement, selectPasted=true)
	{
		if (!ensureActiveLayerFrameExists()) return false;
		
		var r = false;
		
		for (elementsNode in xml.find(">elements"))
		{
			var elements = Elements.parse(elementsNode, Version.document);
			for (e in elements)
			{
				if (!r) deselectAllWoUpdate();
				
				e.setLibrary(cast document.library.getRawLibrary());
				
				if (Std.isOfType(e, ShapeElement))
				{
					activeShape.combine(cast e);
				}
				else
				{
					var editorElement = activeLayer.addElement(e);
					if (selectPasted) editorElement.selected = true;
				}
				
				r = true;
			}
		}
		
		return r;
	}
	
	public function duplicateSelected()
	{
		for (layer in layers)
		{
			layer.duplicateSelected();
		}
		update();
	}
	
	public function getObjectsInRectangle(x:Float, y:Float, width:Float, height:Float) : Array<ISelectable>
	{
		var r = new Array<ISelectable>();
		for (layer in layers)
		{
			if (!layer.editable) continue;
			
			for (edge in layer.shape.element.edges)
			{
				if (edge.isInRectangle(x, y, width, height)) r.push(edge);
			}
			
			for (polygon in layer.shape.element.polygons)
			{
				if (polygon.isInRectangle(x, y, width, height)) r.push(polygon);
			}
			
			for (item in layer.getElements())
			{
				if (item.originalElement == item.currentElement)
				{
					var bounds = item.getTransformedBounds();
					if (bounds == null) bounds = new Rectangle(item.originalElement.matrix.tx, item.originalElement.matrix.ty, 0, 0);
					//trace("item bounds = " + bounds.toString());
					if (bounds.x >= x
					 && bounds.y >= y
					 && bounds.x + bounds.width  <= x + width
					 && bounds.y + bounds.height <= y + height
					) r.push(item);
				}
			}
		}
		return r;
	}
	
	public function flipSelectedHorizontal()
	{
		transformSelectedRelativeToCenterPoint(new Matrix().scale(-1, 1));
	}
	
	public function flipSelectedVertical()
	{
		transformSelectedRelativeToCenterPoint(new Matrix().scale(1, -1));
	}
	
	public function getSelectedBounds() : { x:Float, y:Float, width:Float, height:Float }
	{
		if (!hasSelected()) return null;
		
		var r = BoundsTools.toRectangle(figure.getSelectedBounds());
		for (item in getSelectedItems())
		{
			if (r != null) r = r.union(item.getTransformedBounds());
			else           r = item.getTransformedBounds();
		}
		return r;
	}
	
	function transformSelectedRelativeToCenterPoint(m:Matrix)
	{
		var bounds = getSelectedBounds();
		if (bounds == null) return;
		
		var cx = bounds.x + bounds.width / 2;
		var cy = bounds.y + bounds.height / 2;
		
		var matrix = new Matrix();
		matrix.translate(-cx, -cy);
		matrix.prependMatrix(m);
		matrix.translate( cx,  cy);
		
		figure.transformSelected(matrix);
		for (item in getSelectedItems())
		{
			item.originalElement.matrix.prependMatrix(matrix);
		}
		
		updateShapes();
	}
	
	public function getHitTestGap() : Float return HIT_TEST_GAP * 100 / zoomLevel;
	
	public function getEditableLayers() : Array<EditorLayer>
	{
		var r = [];
		for (layer in layers)
		{
			if (layer.editable) r.push(layer);
		}
		return r;
	}
	
	public function getSingleSelectedInstance() : Instance
	{
		if (figure.hasSelected()) return null;
		
		var selected = getSelectedItems();
		if (selected.length == 1 && Std.isOfType(selected[0].originalElement, Instance))
		{
			return cast selected[0].originalElement;
		}
		
		return null;
	}
	
	public function saveViewState()
	{
		savedViewState =
		{
			zoom: view.movie.editor.zoomLevel,
			x: view.movie.editor.viewX,
			y: view.movie.editor.viewY
		};
	}
	
	public function loadViewState()
	{
		if (savedViewState != null)
		{
			view.movie.editor.zoomLevel = savedViewState.zoom;
			view.movie.editor.viewX = savedViewState.x;
			view.movie.editor.viewY = savedViewState.y;
		}
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}