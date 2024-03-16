package nanofl.ide.editor.elements;

import js.Browser;
import nanofl.ide.ElementLifeTracker.ElementLifeTrack;
import js.lib.Error;
import stdlib.Debug;
import easeljs.display.Container;
import easeljs.display.DisplayObject;
import easeljs.events.MouseEvent;
import easeljs.geom.Rectangle;
import easeljs.display.Shape;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.elements.TextElement;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.geom.BoundsTools;
import nanofl.engine.geom.Point;
import nanofl.engine.ISelectable;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.editor.Editor;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.EditorLayer;
import nanofl.ide.ui.View;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.MovieClipItemTools;
using nanofl.engine.geom.PointTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
abstract class EditorElement implements ISelectable
{
	@:isVar static var EMPTY_CLIP_SIZE(default, never) = 4.5;
	
	static var emptyClipMarkPattern : Shape;
	static var emptyClipMarkSelectedPattern : Shape;
	static var regPointMarkPattern : Shape;
	
	var layer : EditorLayer;
	var editor : Editor;
	var navigator : Navigator;
	var view : View;
	
	public var frame(default, null) : Frame;
	
	public var originalElement(default, null) : Element;
	public var currentElement(default, null) : Element;
	
	public var metaDispObj(default, null) : Container;
	
	@:allow(nanofl.ide.editor.tools.TransformEditorTool)
	@:allow(nanofl.ide.editor.tools.TextEditorTool)
	var dispObj : DisplayObject;
	var selectionBoxShape : Shape;
	var emptyClipMark : DisplayObject;
	var emptyClipMarkSelected : DisplayObject;
	var regPointMark : DisplayObject;
	
	var _selected = false;
	public var selected(get, set) : Bool;
	function get_selected() return _selected;
	function set_selected(v) { _selected = v; update(); return v; }
	
	public var width(get, set) : Float;
	public var height(get, set) : Float;

    final track : ElementLifeTrack;
    final framerate : Float;
	
	public static function create(layer:EditorLayer, editor:Editor, navigator:Navigator, view:View, frame:Frame, tweenedElement:TweenedElement, track:ElementLifeTrack, framerate:Float) : EditorElement
	{
        Debug.assert(track != null);
        
		if (Std.isOfType(tweenedElement.original, Instance))
		{
			return new EditorElementInstance(layer, editor, navigator, view, frame, tweenedElement, track, framerate);
		}
		else
		if (Std.isOfType(tweenedElement.original, ShapeElement))
		{
			return new EditorElementShape(layer, editor, navigator, view, frame, tweenedElement, track, framerate);
		}
		else
		if (Std.isOfType(tweenedElement.original, TextElement))
		{
			return new EditorElementText(layer, editor, navigator, view, frame, tweenedElement, track, framerate);
		}
		else
		{
			throw new Error("Unknow element type " + tweenedElement.original.toString() + ".");
		}
	}
	
	function new(layer:EditorLayer, editor:Editor, navigator:Navigator, view:View, frame:Frame, tweenedElement:TweenedElement, track:ElementLifeTrack, framerate:Float)
	{
		preparePatterns();
		
		this.layer = layer;
		this.editor = editor;
		this.navigator = navigator;
		this.view = view;
		this.frame = frame;
        this.track = track;
        this.framerate = framerate;
		
		originalElement = tweenedElement.original;
		currentElement = tweenedElement.current;

		metaDispObj = new Container();
		metaDispObj.mouseEnabled = !frame.keyFrame.layer.locked;
		
		metaDispObj.addChild(dispObj = new easeljs.display.Container()); // temporary, real object created in `update()` below
		metaDispObj.addChild(selectionBoxShape = new Shape());
		metaDispObj.addChild(emptyClipMark = emptyClipMarkPattern.clone());
		metaDispObj.addChild(emptyClipMarkSelected = emptyClipMarkSelectedPattern.clone());
		metaDispObj.addChild(regPointMark = regPointMarkPattern.clone());
		
		emptyClipMark.visible = false;
		emptyClipMarkSelected.visible = false;
		emptyClipMarkSelected.mouseEnabled = false;
		regPointMark.visible = false;
		
		attachEventHandlers();

        update();
	}

    function createDisplayObjectForElement() : DisplayObject
    {
        final dispObj = currentElement.createDisplayObject();

        if (Std.isOfType(dispObj, AdvancableDisplayObject))
        {
            (cast dispObj:AdvancableDisplayObject).advanceTo(navigator.pathItem.frameIndex - track.startFrameIndex, framerate);
        }

        return dispObj;
    }

	public function updateTransformations()
	{
		var properties = currentElement.matrix.decompose();
		
		dispObj.set(properties);
		selectionBoxShape.set(properties);
		
		emptyClipMark.x = properties.x;
		emptyClipMark.y = properties.y;
		emptyClipMarkSelected.x = properties.x;
		emptyClipMarkSelected.y = properties.y;
		
		var regPos = dispObj.localToLocal(currentElement.regX, currentElement.regY, metaDispObj);
		regPointMark.x = regPos.x;
		regPointMark.y = regPos.y;

        DisplayObjectTools.recache(dispObj);
	}
	
	public function update()
	{
        final n = metaDispObj.children.indexOf(dispObj);
        metaDispObj.removeChildAt(n);
        metaDispObj.addChildAt(dispObj = createDisplayObjectForElement(), n);
        updateTransformations();
	}
	
	public function getBounds() : Rectangle
	{
		var r = DisplayObjectTools.getInnerBounds(dispObj);
		return r != null ? r : new Rectangle(0, 0, 0, 0);
	}
	
	public function getTransformedBounds() : Rectangle
	{
		return BoundsTools.transform(getBounds(), dispObj.getMatrix());
	}
	
	public function hitTest(pos:Point) : Bool
	{
		if (emptyClipMark.visible)
		{
			var posOnMark = metaDispObj.parent.localToLocal(pos.x, pos.y, emptyClipMark);
			if (emptyClipMark.hitTest(posOnMark.x, posOnMark.y)) return true;
		}
		
		if (dispObj.visible)
		{
			var posOnObj = metaDispObj.parent.localToLocal(pos.x, pos.y, dispObj);
			if (DisplayObjectTools.smartHitTest(dispObj, posOnObj.x, posOnObj.y, 10)) return true;
			
			var pt = currentElement.getNearestPoint(pos);
			if (PointTools.getDistP(pos, pt) < editor.getHitTestGap()) return true;
		}
		
		return false;
	}
	
	public abstract function getPropertiesObject(newObjectParams:NewObjectParams) : PropertiesObject;
	
	function get_width()
	{
		var bounds = getBounds();
		var pt0 = dispObj.localToLocal(bounds.x, bounds.y, metaDispObj);
		var pt1 = dispObj.localToLocal(bounds.x + bounds.width, bounds.y, metaDispObj);
		return pt0.getDistP(pt1);
	}
	
	function set_width(v:Float)
	{
		var old = get_width();
		if (old != 0)
		{
			dispObj.scaleX *= v / old;
			currentElement.matrix = nanofl.engine.geom.Matrix.fromNative(dispObj.getMatrix());
		}
		return v;
	}
	
	function get_height()
	{
		var bounds = getBounds();
		var pt0 = dispObj.localToLocal(bounds.x, bounds.y, metaDispObj);
		var pt1 = dispObj.localToLocal(bounds.x, bounds.y + bounds.height, metaDispObj);
		return pt0.getDistP(pt1);
	}
	
	function set_height(v:Float)
	{
		var old = get_height();
		if (old != 0)
		{
			dispObj.scaleY *= v / old;
			currentElement.matrix = nanofl.engine.geom.Matrix.fromNative(dispObj.getMatrix());
		}
		return v;
	}
	
	@:noprofile
	function preparePatterns()
	{
		if (emptyClipMarkPattern == null)
		{
			emptyClipMarkPattern = new Shape();
			emptyClipMarkPattern.graphics
				.beginStroke("black")
				.beginFill("white")
				.drawCircle(0, 0, EMPTY_CLIP_SIZE)
				.endFill()
				.endStroke();
		}
		
		if (emptyClipMarkSelectedPattern == null)
		{
			emptyClipMarkSelectedPattern = new Shape();
			emptyClipMarkSelectedPattern.graphics
				.beginStroke("black")
				.moveTo(0, -EMPTY_CLIP_SIZE).lineTo(0, EMPTY_CLIP_SIZE)
				.moveTo(-EMPTY_CLIP_SIZE, 0).lineTo(EMPTY_CLIP_SIZE, 0)
				.endStroke();
		}
		
		if (regPointMarkPattern == null)
		{
			regPointMarkPattern = new Shape();
			regPointMarkPattern.graphics
				.beginStroke("black")
				.drawCircle(0, 0, EMPTY_CLIP_SIZE)
				.endStroke()
				.beginStroke("white")
				.drawCircle(0, 0, EMPTY_CLIP_SIZE - 1)
				.endStroke();
		}
	}
	
	final function attachEventHandlers()
	{
		var pressed = false;
		
		metaDispObj.addClickEventListener(onClick);
		
		metaDispObj.addMouseDownEventListener(function(e)
		{
			if (!frame.keyFrame.layer.locked && e.nativeEvent.which == 1)
			{
				log("EditorElementSelectBox: metaDispObj mousedown");
				pressed = true;
				onMouseDown(e);
			}			
		});
		
		metaDispObj.addPressUpEventListener(function(e)
		{
			if (!frame.keyFrame.layer.locked && pressed)
			{
				log("EditorElementSelectBox: metaDispObj mouseup");
				pressed = false;
				onMouseUp(e);
			}
		});
		
		metaDispObj.addDblClickEventListener(function(e)
		{
			if (!frame.keyFrame.layer.locked)
			{
				log("EditorElementSelectBox: metaDispObj doubleclick");
				onDoubleClick(e);
			}
		});
	}
	
	public function onClick(e:MouseEvent) {}
	public function onMouseDown(e:MouseEvent) {}
	public function onMouseUp(e:MouseEvent) {}
	public function onDoubleClick(e:MouseEvent) {}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
