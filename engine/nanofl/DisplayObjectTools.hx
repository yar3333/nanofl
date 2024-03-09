package nanofl;

import nanofl.engine.MaskTools;
import nanofl.engine.LayerType;
import easeljs.display.Container;
import easeljs.display.DisplayObject;
import easeljs.geom.Rectangle;
import easeljs.display.Shape;
import nanofl.engine.geom.BoundsTools;
using StringTools;

@:expose
class DisplayObjectTools
{
	public static var autoHitArea = #if ide true #else false #end;
	
	public static function getOuterBounds(obj:DisplayObject, ignoreSelf=false) : Rectangle
	{
		var r : Rectangle = null;
		
		if (Std.isOfType(obj, Container) && !Std.isOfType(obj, SolidContainer))
		{
			for (child in (cast obj:Container).children)
			{
				var b = BoundsTools.transform(getOuterBounds(child), child.getMatrix());
				if (b != null)
				{
					if (r != null) r = r.union(b);
					else r = b;
				}
			}
		}
		else
		{
			r = getInnerBounds(obj);
		}
		
		if (r == null) return null;
		
		if (!ignoreSelf && obj.filters != null)
		{
			for (f in obj.filters)
			{
				f.getBounds(r);
			}
		}
		
		return r;
	}
	
	public static function getInnerBounds(obj:DisplayObject) : Rectangle
	{
		var r : Rectangle = null;
		
		if (Std.isOfType(obj, Container) && !Std.isOfType(obj, SolidContainer))
		{
			for (child in (cast obj:Container).children)
			{
				var b = BoundsTools.transform(getInnerBounds(child), child.getMatrix());
				if (b != null)
				{
					if (r != null) r = r.union(b);
					else r = b;
				}
			}
			if (r == null) return null;
		}
		else
		{
			if (obj.cacheCanvas == null)
			{
				r = obj.getBounds();
			}
			else
			{
				var savedCacheCanvas = obj.cacheCanvas;
				obj.cacheCanvas = null;
				r = obj.getBounds();
				obj.cacheCanvas = savedCacheCanvas;
			}
			if (r == null) return null;
			r = r.clone();
		}
		
		return r;
	}

    public static function iterateTreeFromBottomToTop(parent:DisplayObject, callb:DisplayObject->Void) : Void
    {
		if (Std.isOfType(parent, Container) && !Std.isOfType(parent, SolidContainer))
		{
			for (child in (cast parent:Container).children) callb(child);
		}
        callb(parent);
    }
	
	public static function callMethod(parent:DisplayObject, name:String)
	{
        iterateTreeFromBottomToTop(parent, obj ->
        {
            var method = Reflect.field(obj, name);
            if (Reflect.isFunction(method))
            {
                Reflect.callMethod(obj, method, []);
            }
        });
	}

	public static function dispatchMouseEvent(parent:DisplayObject, name:String, e:nanofl.MouseEvent)
	{
		if (Std.isOfType(parent, Container) && !Std.isOfType(parent, SolidContainer))
		{
			final children = (cast parent:Container).children.copy();
            children.reverse();
            for (child in children)
            {
                if (child.parent != null) dispatchMouseEvent(child, name, e);
                if (e.canceled) return;
            }
		}
		
        if (parent.parent != null)
        {
            var method = Reflect.field(parent, name);
            if (Reflect.isFunction(method))
            {
                e._target = parent;
                Reflect.callMethod(parent, method, [ e ]);
            }
        }
	}

	public static function smartHitTest(obj:DisplayObject, x:Float, y:Float, minAlpha=1) : Bool
	{
		if (obj.cacheCanvas == null) return obj.hitTest(x, y);
		else
		{
			if (x < obj.bitmapCache.offX 
			 || y < obj.bitmapCache.offY
			 || x > obj.bitmapCache.offX + obj.bitmapCache.width
			 || y > obj.bitmapCache.offY + obj.bitmapCache.height
			 ) return false;
			
			x = Math.round((x - obj.bitmapCache.offX - obj.bitmapCache._filterOffX) * obj.bitmapCache.scale);
			y = Math.round((y - obj.bitmapCache.offY - obj.bitmapCache._filterOffY) * obj.bitmapCache.scale);
			var alpha = obj.cacheCanvas.getContext2d().getImageData(x, y, 1, 1).data[3];
			return alpha >= minAlpha;
		}
	}
	
	public static function dump(obj:DisplayObject, level=0)
	{
		var s = StringTools.rpad("", "\t", level);
		
		if (Std.isOfType(obj, MovieClip))
		{
			s += "MovieClip(" + (cast obj:MovieClip).symbol.namePath + ")";
		}
		else
		if (Std.isOfType(obj, Mesh))
		{
			s += "Mesh(" + (cast obj:Mesh).symbol.namePath + ")";
		}
		else
		if (Std.isOfType(obj, TextField))
		{
			s += "TextField";
		}
		else
		if (Std.isOfType(obj, Bitmap))
		{
			s += "Bitmap(" + (cast obj:Bitmap).symbol.namePath + ")";
		}
		else
		if (Std.isOfType(obj, Container))
		{
			s += "Container";
		}
		else
		if (Std.isOfType(obj, Shape))
		{
			s += "Shape";
		}
		else
		if (Std.isOfType(obj, Video))
		{
			s += "Video(" + (cast obj:Video).symbol.namePath + ")";
		}
		else
		{
			s += "Unknow";
		}
		
		if (obj.cacheCanvas != null) s += " cached";
		if ((cast obj)._bounds != null) s += " fixed";
		s += " bounds(" + rectToString(obj.getBounds()) + ")";
		s += " outers(" + rectToString(getOuterBounds(obj)) + ")";
		
		if (Std.isOfType(obj, TextField))
		{
			s += " '" + (cast obj:TextField).text.replace("\r", " ").replace("\n", " ") + "'";
		}
		
		trace(s);
		
		if (Std.isOfType(obj, Container) && !Std.isOfType(obj, SolidContainer))
		{
			for (child in (cast obj:Container).children)
			{
				dump(child, level + 1);
			}
		}
	}
	
	static function rectToString(rect:Rectangle)
	{
		if (rect == null) return "null";
		return rect.x + "," + rect.y + " " + rect.width + " x " + rect.height;
	}

    public static function recache(dispObj:DisplayObject, force=false) : Bool
    {
		var childChanged = false;
        if (Std.isOfType(dispObj, Container) && !Std.isOfType(dispObj, SolidContainer))
		{
			for (child in (cast dispObj:Container).children) if (recache(child)) childChanged = true;
		}

        if (Std.isOfType(dispObj, MovieClip))
        {
            final mc : MovieClip = cast dispObj;
            final masks = new Map<Int, Container>();
            
            for (layerIndex in 0...mc.symbol.layers.length)
            {
                final layer = mc.symbol.layers[layerIndex];
                if (layer.parentLayer?.type == LayerType.mask)
                {
                    for (child in mc.getChildrenByLayerIndex(layerIndex))
                    {
                        var mask = masks.get(layer.parentIndex);
                        if (mask == null)
                        {
                            mask = MaskTools.createMaskFromMovieClipLayer(mc, layer.parentIndex);
                            masks.set(layer.parentIndex, mask);
                        }
                        MaskTools.applyMaskToDisplayObject(mask, child);
                    }
                }
            }
        }

        if (!force && !childChanged && dispObj.cacheCanvas == null && !isNeedCache(dispObj)) return false;
        
        dispObj.uncache();
        
        if (force || isNeedCache(dispObj))
        {
            cache(dispObj);
        }
        
        return true;
    } 

    static function cache(dispObj:DisplayObject)
    {
        var bounds = DisplayObjectTools.getInnerBounds(dispObj);
        if (bounds != null && bounds.width > 0 && bounds.height > 0)
        {
            dispObj.cache(bounds.x, bounds.y, bounds.width, bounds.height);
        }
    }

    static function isNeedCache(dispObj:DisplayObject) : Bool
    {
        return dispObj.alpha != 1 || dispObj.filters != null && dispObj.filters.length > 0;
    }  
}