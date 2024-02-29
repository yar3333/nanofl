package nanofl;

import easeljs.display.Container;
import easeljs.display.DisplayObject;
import easeljs.events.MouseEvent;
import nanofl.engine.IPathElement;
import nanofl.engine.LayerType;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.libraryitems.MovieClipItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
class MovieClip extends Container 
    implements IEventHandlers
    implements AdvancableDisplayObject
{
	var layerOfChild : Map<DisplayObject, Int>;
	
	public var symbol(default, null) : MovieClipItem;
	
	public var currentFrame(default, null) : Int;
	
	public var paused : Bool;
	public var loop : Bool;
	
	public function new(symbol:MovieClipItem, initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, MovieClipItem));
		
        layerOfChild = new Map<DisplayObject, Int>();
		this.symbol = symbol;
		currentFrame = initFrameIndex ?? 0;
		symbol.updateDisplayObject(this, childFrameIndexes);
		
		paused = !symbol.autoPlay;
		loop = symbol.loop;
	}
	
	public function addChildToLayer(child:DisplayObject, layerIndex:Int) : DisplayObject
	{
		layerOfChild.set(child, layerIndex);
		for (i in 0...children.length)
		{
			if (layerOfChild.get(children[i]) < layerIndex)
			{
				return addChildAt(child, i);
			}
		}
		return addChild(child);
	}
	
	override public function removeAllChildren() : Void
	{
		super.removeAllChildren();
		layerOfChild = new Map<DisplayObject, Int>();
	}
	
	override public function removeChild(child:DisplayObject) : Bool
	{
		layerOfChild.remove(child);
		return super.removeChild(child);
	}
	
	override public function removeChildAt(index:Int) : Bool
	{
		layerOfChild.remove(children[index]);
		return super.removeChildAt(index);
	}
	
	public function play()
	{
		paused = false;
	}
	
	public function stop()
	{
		paused = true;
	}
	
	public function gotoAndStop(labelOrIndex:Dynamic)
	{
		gotoFrame(labelOrIndex);
		stop();
	}
	
	public function gotoAndPlay(labelOrIndex:Dynamic)
	{
		gotoFrame(labelOrIndex);
		play();
	}
	
	public function getTotalFrames()
	{
		return symbol.getTotalFrames();
	}
	
	public function maskChild(child:DisplayObject)
	{
		var n = layerOfChild.get(child);
		if (n != null)
		{
			var parentLayerIndex = symbol.layers[n].parentIndex;
			if (parentLayerIndex != null && symbol.layers[parentLayerIndex].type == LayerType.mask)
			{
				var mask = new Container();
				for (obj in getLayerChildren(parentLayerIndex))
				{
					var clonedObj = obj.clone(true);
					clonedObj.visible = true;
					DisplayObjectTools.smartCache(clonedObj);
					mask.addChild(clonedObj);
				}
				return applyMask(mask, child);
			}
		}
		return false;
	}
	
	public function uncacheChild(child:DisplayObject)
	{
		child.uncache();
		if (DisplayObjectTools.autoHitArea) child.hitArea = null;
		var layerIndex = layerOfChild.get(child);
		if (layerIndex != null && symbol.layers[layerIndex].type == LayerType.mask)
		{
			for (c in children)
			{
				var n = layerOfChild.get(c);
				if (n != null && symbol.layers[n].parentIndex == layerIndex)
				{
					c.uncache();
					if (DisplayObjectTools.autoHitArea) c.hitArea = null;
				}
			}
		}
	}
	
	public static function applyMask(mask:DisplayObject, obj:DisplayObject) : Bool
	{
		var objBounds = DisplayObjectTools.getOuterBounds(obj);
		if (objBounds == null || objBounds.width == 0 || objBounds.height == 0) return false;
		//trace("objBounds = " + objBounds);
		
		mask = mask.clone(true);
		mask.transformMatrix = obj.getMatrix().invert();
		mask.visible = true;
		
		var maskContainer = new Container();
		maskContainer.addChild(mask);
		
		var maskContainerBounds = DisplayObjectTools.getOuterBounds(maskContainer);
		if (maskContainerBounds == null || maskContainerBounds.width == 0 || maskContainerBounds.height == 0) { obj.visible = false; return false; }
		//trace("maskContainerBounds = " + maskContainerBounds);
		
		DisplayObjectTools.smartCache(mask);
		
		if (Std.isOfType(obj, Container))
		{
			for (child in (cast obj:Container).children)
			{
				DisplayObjectTools.smartCache(child);
			}
		}
		
		var intersection = maskContainerBounds.intersection(objBounds);
		if (intersection == null || intersection.width == 0 || intersection.height == 0) { obj.visible = false; return false; }
		//trace("intersection = " + intersection);
		
		var union = objBounds.union(intersection);
		//trace("union = " + union);
		
		maskContainer.cache(union.x, union.y, union.width, union.height);
		//nanofl.ide.CanvasTracer.trace(maskContainer.cacheCanvas, "maskContainer(2)");
		
		var objBounds2 = DisplayObjectTools.getOuterBounds(obj, true);
		obj.cache(objBounds2.x, objBounds2.y, objBounds2.width, objBounds2.height);
		//nanofl.ide.CanvasTracer.trace(obj.cacheCanvas, "obj(3)");
		
		new easeljs.filters.AlphaMaskFilter(maskContainer.cacheCanvas).applyFilter(obj.cacheCanvas.getContext2d(), 0, 0, Std.int(objBounds.width), Std.int(objBounds.height));
		//nanofl.ide.CanvasTracer.trace(obj.cacheCanvas, "obj(4)");
		
		return true;
	}
	
	function getLayerChildren(layerIndex:Int) : Array<DisplayObject>
	{
		var r = [];
		for (child in children)
		{
			if (layerOfChild.get(child) == layerIndex) r.push(child);
		}
		return r;
	}
	
	/**
	 * Return keeped children MovieClips. Return null if all children are keeped.
	 */
	#if ide public #end
	function gotoFrame(labelOrIndex:Dynamic) : Array<AdvancableDisplayObject>
	{
		var frameIndex = getFrameIndexByLabel(labelOrIndex);
		
		if (currentFrame == frameIndex) return null;
		
		var movieClipChanged = false;
		
		var createdDisplayObjects = new Array<DisplayObject>();
		var keepedAdvancableChildren = new Array<AdvancableDisplayObject>();
		
		for (i in 0...symbol.layers.length)
		{
			var layerChanged = false;
			
			var layer = symbol.layers[i];
			var oldFrame = layer.getFrame(currentFrame);
			var newFrame = layer.getFrame(frameIndex);
			
			if (oldFrame != null && newFrame != null && oldFrame.keyFrame == newFrame.keyFrame)
			{
                var tweenedElements = layer.getTweenedElements(frameIndex);
                var layerChildren = getLayerChildren(i);
                Debug.assert(tweenedElements.length == layerChildren.length, "tweenedElements.length=" + tweenedElements.length + " != layerChildren.length=" + layerChildren.length);
                for (i in 0...tweenedElements.length)
                {
                    if (tweenedElements[i].current != tweenedElements[i].original)
                    {
                        tweenedElements[i].current.updateDisplayObject(layerChildren[i], null);
                    }
                    layerChildren[i].visible = layer.type == LayerType.normal;
                    if (Std.isOfType(layerChildren[i], AdvancableDisplayObject))
                    {
                        keepedAdvancableChildren.push((cast layerChildren[i] : AdvancableDisplayObject));
                    }
                }
                layerChanged = true;
			}
			else
			if (oldFrame != null || newFrame != null)
			{
				if (oldFrame != null)
				{
					var j = 0; while (j < children.length)
					{
						if (layerOfChild.get(children[j]) == i) removeChildAt(j);
						else j++;
					}
				}
				
				if (newFrame != null)
				{
					for (tweenedElement in layer.getTweenedElements(frameIndex))
					{
						var obj = tweenedElement.current.createDisplayObject(null);
						obj.visible = layer.type == LayerType.normal;
						addChildToLayer(obj, i);
						createdDisplayObjects.push(obj);
					}
				}
				
				layerChanged = true;
			}
			
			if (layerChanged)
			{
				movieClipChanged = true;
				
				if (layer.type == LayerType.mask)
				{
					for (j in 0...symbol.layers.length)
					{
						if (symbol.layers[j].parentIndex == i)
						{
							for (child in getLayerChildren(j)) child.uncache();
						}
					}
				}
			}
		}
		
		if (movieClipChanged) DisplayObjectTools.smartUncache(this);
		
		currentFrame = frameIndex;
		
		for (obj in createdDisplayObjects) DisplayObjectTools.callMethod(obj, "init");
		
		return keepedAdvancableChildren;
	}
	
	function getFrameIndexByLabel(labelOrIndex:Dynamic) : Int
	{
		if (Std.isOfType(labelOrIndex, Int)) return labelOrIndex;
		
		for (layer in symbol.layers)
		{
			for (keyFrame in layer.keyFrames)
			{
				if (keyFrame.label == labelOrIndex) return keyFrame.getIndex();
			}
		}
		
		return null;
	}
	
	public function advance(?time:Float)
	{
		var childrenToAdvance : Array<AdvancableDisplayObject> = null;
		
		if (!paused)
		{
			childrenToAdvance = gotoFrame(loop ? (currentFrame + 1) % getTotalFrames() : stdlib.Std.min(currentFrame + 1, getTotalFrames() - 1));
		}
		
		if (childrenToAdvance == null)
		{
			for (child in children.filterByType(AdvancableDisplayObject))
			{
				child.advance();
			}
		}
		else
		{
			for (child in childrenToAdvance) child.advance();
		}
	}
	
	override public function clone(?recursive:Bool) : MovieClip 
	{
		return (cast this)._cloneProps
		(
			new MovieClip(symbol, currentFrame, null)
		);
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}
	
	//{ IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:MouseEvent) : Void {}
	public function onMouseMove(e:MouseEvent) : Void {}
	public function onMouseUp(e:MouseEvent) : Void {}
	//}
}
