package nanofl.ide.editor;

import nanofl.engine.MaskTools;
import easeljs.display.Container;
import nanofl.engine.movieclip.GuideLine;
import nanofl.engine.IPathElement;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.elements.TextElement;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.movieclip.Guide;
import nanofl.ide.editor.Editor;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.elements.EditorElementShape;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.ISelectable;
import nanofl.engine.LayerType;
import nanofl.engine.geom.Point;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.ui.View;
import nanofl.engine.elements.Element;
import stdlib.Debug;
using stdlib.Lambda;
using nanofl.engine.geom.PointTools;

#if profiler @:build(Profiler.buildMarked()) #end
class EditorLayer
{
	var editor : Editor;
	var navigator : Navigator;
	var view : View;
	
	var layer(default, null) : Layer;
	var frameIndex(default, null) : Int;
	var frame(default, null) : Frame;
	var items(default, null) = new Array<EditorElement>();
	
	public var editable(get, never) : Bool;
	@:noCompletion function get_editable() return layer.type != LayerType.folder
	                                           && frame != null
										       && layer.visible
										       && !layer.locked
										       && (!frame.keyFrame.hasMotionTween() || frame.subIndex == 0);
	
	public var parentIndex(get, never) : Int; function get_parentIndex() return layer.parentIndex;
	public var type(get, never) : LayerType; function get_type() return layer.type;
	
    public var shape(default, null) : EditorElementShape;
	
	public var container(default, null) = new Container();
	
	@:noapi 
	public function new(editor:Editor, navigator:Navigator, view:View, layer:Layer, frameIndex:Int)
	{
		this.editor = editor;
		this.navigator = navigator;
		this.view = view;
		
		this.layer = layer;
		this.frameIndex = frameIndex;
		this.frame = layer.getFrame(frameIndex);
		
		if (frame != null)
		{
			frame.keyFrame.getShape(true).deselectAll();
			
			for (tweenedElement in frame.keyFrame.getTweenedElements(frame.subIndex))
			{
				addDisplayObject(tweenedElement);
			}
			
			shape = cast(items[0], EditorElementShape);
		}
		
		update();
	}
	
	public function addElements(elements:Array<Element>, ?index:Int) : Array<EditorElement>
    {
        var elements = elements.copy();
        
        var r = [];
        while (elements.length > 0)
        {
            if (index != null)
            {
                r.unshift(addElement(elements.pop(), index));
            }
            else
            {
                r.push(addElement(elements.shift()));
            }
        }
        return r;
    }
    
    public function removeSelected()
    {
        var i = items.length - 1;
        while (i >= 0)
        {
            if (items[i].selected) removeItemAt(i);
            i--;
        }
    }
    
    @:noprofile
    public function hasItem(item:EditorElement) return items.has(item);
    
    public function show() layer.visible = true;
    public function hide() layer.visible = false;
    public function lock() layer.locked = true;
    public function unlock() layer.locked = false;
    
    public function getItemAtPos(pos:Point) : EditorElement
    {
        for (item in getItems())
        {
            if (item.hitTest(pos)) return item;
        }
        return null;
    }
    
    public function getEditablessReason() : String
    {
        if (!layer.visible) return "Layer is hidden.";
        if (layer.locked) return "Layer is locked.";
        if (frame == null) return "Layer has no frame.";
        if (frame.keyFrame.hasMotionTween() && frame.subIndex > 0) return "Layer's frame is intermediate tween frame.";
        
        Debug.assert(false);
        return null;
    }
    
    public function getIndex() return layer.getIndex();
    
    public function getTweenedElements(frameIndex:Int) : Array<TweenedElement> return layer.getTweenedElements(frameIndex);
    
    public function getChildLayers() : Array<EditorLayer>
    {
        var n = editor.layers.indexOf((cast this:EditorLayer));
        return editor.layers.filter(l -> l.parentIndex == n);
    }
    
    public function getElementIndex(element:Element) : Int
    {
        for (i in 0...items.length)
        {
            if (items[i].originalElement == element) return i;
        }
        return -1;
    }
    
    public function getElementByIndex(elementIndex:Int) : Element
    {
        return items[elementIndex].originalElement;
    }
    
    public function getElementsState() : { elements:Array<Element> }
    {
        return frame != null ? frame.keyFrame.getElementsState() : null;
    }
    
    public function duplicateSelected()
    {
        var i = 0; while (i < items.length)
        {
            if (items[i].selected)
            {
                addElement(items[i].originalElement.clone(), i);
                i++;
            }
            i++;
        }
    }
    
    public function isShowSelection() : Bool
    {
        return !layer.locked || layer.getChildLayers().exists(l -> !l.locked);
    }

	@:noprofile
	function addDisplayObject(tweenedElement:TweenedElement, ?index:Int) : EditorElement
	{
		var item = EditorElement.create(this, editor, navigator, view, frame, tweenedElement);
		
		container.addChildAt(item.metaDispObj, index != null ? index : container.numChildren);
		items.insert(index != null ? index : items.length, item);
		
		return item;
	}
	
	public function addElement(element:Element, ?index:Int) : EditorElement
	{
		frame.keyFrame.addElement(element, index);
		return addDisplayObject(new TweenedElement(element, element), index);
	}
	
	function removeItemAt(index:Int)
	{
		var item = items[index];
		container.removeChild(item.metaDispObj);
		item.frame.keyFrame.removeElementAt(index);
		items.splice(index, 1);
	}
	
	@:noprofile
	public function getItems(?r:Array<EditorElement>, includeShape=false) : Array<EditorElement>
	{
		if (r == null) r = [];
		
		if (!editable) return r;
		
		var i = items.length - 1; while (i >= 0)
		{
			if (includeShape || !Std.isOfType(items[i].originalElement, ShapeElement)) r.push(items[i]);
			i--;
		}
		
		return r;
	}
	
	@:noprofile
	public function getSelectedItems(?r:Array<EditorElement>) : Array<EditorElement>
	{
		if (r == null) r  = [];
		
		if (!editable) return r;
		
		var i = items.length - 1; while (i >= 0)
		{
			if (items[i].selected && !Std.isOfType(items[i].originalElement, ShapeElement)) r.push(items[i]);
			i--;
		}
		
		return r;
	}
	
	public function hasSelected() : Bool
	{
		if (!editable) return false;
		
		for (item in items) if (item.selected) return true;
		return shape.element.hasSelected();
	}
	
	public function isAllSelected() : Bool
	{
		if (!editable) return false;
		
		for (item in getItems()) if (!item.selected) return false;
		return shape.element.isAllSelected();
	}
	
	public function selectAll()
	{
		if (!editable) return;
		
		shape.element.selectAll();
		for (item in getItems()) item.selected = true;
	}
	
	public function deselectAll()
	{
		if (!editable) return;
		
		shape.element.deselectAll();
		for (item in getItems()) item.selected = false;
	}
	
	public function breakApartSelectedItems()
	{
		if (!editable) return;
		
		var i = 0; while (i < items.length)
		{
			var item = items[i];
			if (item.selected)
			{
				if (Std.isOfType(item.originalElement, IPathElement))
				{
					removeItemAt(i);
					var containerElement : IPathElement = cast item.originalElement;
					for (child in containerElement.getChildren())
					{
						if (Std.isOfType(child, ShapeElement))
						{
							var newShape = cast(child, ShapeElement);
							newShape.transform(item.originalElement.matrix);
							shape.element.combine(newShape);
						}
						else
						{
							child.matrix.prependMatrix(item.originalElement.matrix);
							var newItem = addElement(child, i); i++;
							newItem.selected = true;
						}
					}
					i--;
				}
				else
				if (Std.isOfType(item.originalElement, TextElement))
				{
					var texts = (cast item.originalElement:TextElement).breakApart();
					removeItemAt(i);
					for (item in addElements(texts.map(function(e) : Element return e), i))
					{
						item.selected = true;
					}
					i += texts.length - 1;
				}
			}
			i++;
		}
	}
	
	public function moveSelectedFront()
	{
		Debug.assert(items.length == frame.keyFrame.elements.length, "items.length=" + items.length + " != elements.length=" + frame.keyFrame.elements.length);
		
		var moved = 1;
		var i = 0; while (i < items.length - moved)
		{
			if (items[i].selected)
			{
				for (j in i...items.length - 1) swapItems(j, j + 1);
				moved++;
			}
			else
			{
				i++;
			}
		}
	}
	
	public function moveSelectedForwards()
	{
		Debug.assert(items.length == frame.keyFrame.elements.length, "items.length=" + items.length + " != elements.length=" + frame.keyFrame.elements.length);
		
		var i = items.length - 2; while (i >= 0)
		{
			if (items[i].selected && !items[i + 1].selected)
			{
				swapItems(i, i + 1);
			}
			else
			{
				i--;
			}
		}
	}
	
	public function moveSelectedBackwards()
	{
		Debug.assert(items.length == frame.keyFrame.elements.length, "items.length=" + items.length + " != elements.length=" + frame.keyFrame.elements.length);
		
		var i = 1; while (i < items.length)
		{
			if (items[i].selected && !items[i - 1].selected)
			{
				swapItems(i, i - 1);
			}
			else
			{
				i++;
			}
		}
	}
	
	public function moveSelectedBack()
	{
		Debug.assert(items.length == frame.keyFrame.elements.length, "items.length=" + items.length + " != elements.length=" + frame.keyFrame.elements.length);
		
		var moved = 1;
		var i = items.length - 1; while (i >= moved)
		{
			if (items[i].selected)
			{
				var j = i; while (j > 0) { swapItems(j, j - 1); j--; }
				moved++;
			}
			else
			{
				i--;
			}
		}
	}
	
	public function magnetSelectedToGuide()
	{
		if (layer.parentLayer != null && layer.parentLayer.type == LayerType.guide)
		{
			var parentLayer = editor.layers[parentIndex];
			if (!parentLayer.shape.element.isEmpty())
			{
				for (item in getSelectedItems())
				{
					var elem = item.currentElement;
					
					var globReg = elem.matrix.transformPoint(elem.regX, elem.regY);
					var dx = globReg.x - elem.matrix.tx;
					var dy = globReg.y - elem.matrix.ty;
					
					var guide = new Guide(new GuideLine(parentLayer.shape.element));
					var srcProps = { x:globReg.x, y:globReg.y, rotation:0.0 };
					var resProps = guide.get(srcProps, srcProps, false, 0);
					
					log("magnetSelectedToGuide:\n\t    tx/ty = " + elem.matrix.tx + ", " + elem.matrix.ty + "\n\tregX/regY = " + elem.regX + ", " + elem.regY + "\n\t  globReg = " + globReg.x + ", " + globReg.y + "\n\t    dx/dy = " + dx + "," + dy + "\n\t resProps = " + resProps.x + ", " + resProps.y);
					
					elem.matrix.tx = resProps.x - dx;
					elem.matrix.ty = resProps.y - dy;
				}
			}
		}
	}
	
	public function update()
	{
		container.visible = layer.visible && (layer.type != LayerType.mask || !layer.locked || layer.getChildLayers().exists(e -> !e.locked));
		
		DisplayObjectTools.recache(container);
		
        if (layer.parentLayer?.type == LayerType.mask
		 && layer.parentLayer.locked
		 && layer.parentLayer.getChildLayers().foreach(x -> x.locked))
		{
            final mask = editor.layers[parentIndex].container;
            final saveVisible = mask.visible;
            mask.visible = true;
			MaskTools.applyMaskToDisplayObject(mask, container);
            mask.visible = saveVisible;
		}
	}
	
	public function getVertexAtPos(pt:Point) : Point
	{
		var r = shape.element.getNearestVertex(pt);
		return r != null && r.distMinusEdgeThickness < editor.getHitTestGap() ? r.point : null;
	}
	
	public function getEdgeAtPos(pos:Point) : Edge
	{
		var r : Edge = getStrokeEdgeAtPos(pos);
		if (r == null) r = getPolygonEdgeAtPos(pos);
		return r;
	}
	
	public function getStrokeEdgeAtPos(pos:Point) : StrokeEdge
	{
		var r = shape.element.getNearestStrokeEdge(pos);
		if (r != null)
		{
			var dist = pos.getDistP(r.edge.getNearestPointUseStrokeSize(pos.x, pos.y).point);
			if (dist < editor.getHitTestGap())
			{
				return r.edge;
			}
		}
		return null;
	}
	
	public function getPolygonEdgeAtPos(pt:Point) : Edge
	{
		var r = shape.element.getNearestPolygonEdge(pt);
		if (r != null && r.dist < editor.getHitTestGap())
		{
			return r.edge;
		}
		return null;
	}
	
	public function getPolygonAtPos(pt:Point) : Polygon
	{
		return shape.element.getPolygonAtPos(pt);
	}
	
	public function getObjectAtPos(pos:Point) : ISelectable
	{
		var r = getItemAtPos(pos);
		if (r != null) return r;
		
		var r = getStrokeEdgeAtPos(pos);
		if (r != null) return r;
		
		return getPolygonAtPos(pos);
	}
	
	function swapItems(i:Int, j:Int)
	{
		var item = items[i];
		items[i] = items[j];
		items[j] = item;
		
		frame.keyFrame.swapElement(i, j);
		
		container.swapChildrenAt(i, j);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
