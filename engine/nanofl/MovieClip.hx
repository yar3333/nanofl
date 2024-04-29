package nanofl;

import stdlib.Std;
import js.lib.Map;
import easeljs.display.Container;
import easeljs.display.DisplayObject;
import nanofl.engine.LayerType;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.engine.movieclip.KeyFrame;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

typedef MovieClipParams =
{
    @:optional var currentFrame : Int;
}

@:expose
class MovieClip extends Container 
    implements InstanceDisplayObject
    implements AdvancableDisplayObject
    #if !ide implements IEventHandlers #end
{
	var layerOfChild : Map<DisplayObject, Int>;
	
	public var symbol(default, null) : MovieClipItem;
	
	public var currentFrame(default, null) : Int;
	
	public var paused : Bool;
	public var loop : Bool;
	
	public function new(symbol:MovieClipItem, params:MovieClipParams)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, MovieClipItem));
		
		this.symbol = symbol;
		currentFrame = params?.currentFrame ?? 0;
		paused = !symbol.autoPlay;
		loop = symbol.loop;
		
        layerOfChild = new Map<DisplayObject, Int>();
        var i = symbol.layers.length - 1; while (i >= 0)
        {
            for (tweenedElement in symbol.layers[i].getTweenedElements(currentFrame))
            {
                var obj = tweenedElement.current.createDisplayObject();
                obj.visible = symbol.layers[i].type == LayerType.normal;
                addChildToLayer(obj, i);
            }
            i--;
        }

        #if !ide
        if (cast symbol.relatedSound)
        {
            final sound : nanofl.engine.libraryitems.SoundItem = cast Player.library.getItem(symbol.relatedSound);
            sound.play();
        }
        #end
	}
	
	public function addChildToLayer(child:DisplayObject, layerIndex:Int, ?beforeChild:DisplayObject) : DisplayObject
	{
		layerOfChild.set(child, layerIndex);
		
        if (beforeChild != null)
        {
            final n = getChildIndex(beforeChild);
            if (n >= 0) return addChildAt(child, n);
        }
        
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
		layerOfChild.delete(child);
		return super.removeChild(child);
	}
	
	override public function removeChildAt(index:Int) : Bool
	{
		layerOfChild.delete(children[index]);
		return super.removeChildAt(index);
	}

    public function replaceChild(oldChild:DisplayObject, newChild:DisplayObject)
    {
        final layerIndex = layerOfChild.get(oldChild);
        final childIndex = getChildIndex(oldChild);
        removeChildAt(childIndex);
        layerOfChild.set(newChild, layerIndex);
        addChildAt(newChild, childIndex);
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

	public function getChildrenByLayerIndex(layerIndex:Int) : Array<DisplayObject>
	{
		var r = [];
		for (child in children)
		{
			if (layerOfChild.get(child) == layerIndex) r.push(child);
		}
		return r;
	}
	
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
    
	public function advanceTo(lifetimeOnParent:Int, framerate:Float, element:TweenedElement) : Void
	{
        final totalFrames = getTotalFrames();

        var newCurrentFrame = 0;
        if (!paused && totalFrames > 1)
        {
            newCurrentFrame = loop 
                ? lifetimeOnParent % totalFrames 
                : Std.min(lifetimeOnParent, totalFrames - 1);
        }
    	
        final helper = gotoFrame(newCurrentFrame);
        
        for (obj in helper.createdDisplayObjects) DisplayObjectTools.callMethod(obj, "init");
	}
    
    #if ide
    public function getChildByElement(elem:Element) : DisplayObject
    {
        final keyFrame : KeyFrame = cast elem.parent;
        final layerIndex = keyFrame.layer.getIndex();
        final elements = keyFrame.elements;
        final displayObjects = getChildrenByLayerIndex(layerIndex);
        final n = elements.indexOf(elem);
        Debug.assert(n >= 0);
        return displayObjects[n];
    }
    #end
	
	override public function clone(?recursive:Bool) : MovieClip 
	{
		return (cast this)._cloneProps
		(
			new MovieClip(symbol, { currentFrame:currentFrame })
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
