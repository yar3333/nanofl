package nanofl;

import js.lib.Promise;
import easeljs.display.Container;
import easeljs.display.DisplayObject;
import nanofl.engine.IPathElement;
import nanofl.engine.LayerType;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.libraryitems.MovieClipItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
@:allow(nanofl.engine.MovieClipGotoHelper)
class MovieClip extends Container 
    #if !ide implements IEventHandlers #end
    implements InstanceDisplayObject
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

        #if !ide
        if (cast symbol.relatedSound)
        {
            final sound : nanofl.engine.libraryitems.SoundItem = cast Player.library.getItem(symbol.relatedSound);
            sound.play();
        }
        #end
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
		final helper = gotoFrame(labelOrIndex);
		stop();
        for (obj in helper.createdDisplayObjects) DisplayObjectTools.callMethod(obj, "init");
	}
	
	public function gotoAndPlay(labelOrIndex:Dynamic)
	{
		final helper = gotoFrame(labelOrIndex);
		play();
        for (obj in helper.createdDisplayObjects) DisplayObjectTools.callMethod(obj, "init");
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
	function gotoFrame(labelOrIndex:Dynamic) : nanofl.engine.MovieClipGotoHelper
	{
		final newFrameIndex = getFrameIndexByLabel(labelOrIndex);
        Debug.assert(newFrameIndex >= 0, "Frame index must not be negative.");
        Debug.assert(newFrameIndex < getTotalFrames(), "Frame index must be less than total frames count.");
        return new nanofl.engine.MovieClipGotoHelper(this, newFrameIndex);
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
	
	public function advance(?time:Float) : Void
	{
        final totalFrames = getTotalFrames();
    	
        final helper = gotoFrame
        (
            paused || totalFrames <= 1 || (!loop && currentFrame == totalFrames - 1)
                ? currentFrame 
                : (currentFrame + 1) % totalFrames
        );
        
        for (child in helper.keepedAdvancableChildren) child.advance();
        
        for (obj in helper.createdDisplayObjects) DisplayObjectTools.callMethod(obj, "init");
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
	
	#if !ide
	//{ IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	//}
	#end
}
