package nanofl.engine;

import easeljs.display.Container;
import easeljs.display.DisplayObject;

class MaskTools
{
    public static function createMaskFromMovieClipLayer(mc:MovieClip, layerIndex:Int) : Container
    {
        var mask = new Container();
        for (obj in mc.getChildrenByLayerIndex(layerIndex))
        {
            var clonedObj = obj.clone(true);
            clonedObj.visible = true;
            mask.addChild(clonedObj);
        }
        return mask;
    }

    public static function applyMaskToDisplayObject(mask:DisplayObject, obj:DisplayObject) : Void
	{
		var objBounds = DisplayObjectTools.getOuterBounds(obj);
		if (objBounds == null || objBounds.width == 0 || objBounds.height == 0) return;
		//trace("objBounds = " + objBounds);
		
        mask.transformMatrix = obj.getMatrix().invert();

		var maskContainer = new Container();
		maskContainer.addChild(mask);
		
		var maskContainerBounds = DisplayObjectTools.getOuterBounds(maskContainer);
		if (maskContainerBounds == null || maskContainerBounds.width == 0 || maskContainerBounds.height == 0) { obj.visible = false; return; }
		//trace("maskContainerBounds = " + maskContainerBounds);
        
		var intersection = maskContainerBounds.intersection(objBounds);
		if (intersection == null || intersection.width == 0 || intersection.height == 0) { obj.visible = false; return; }
		//trace("intersection = " + intersection);

        obj.visible = true;
		
		var union = objBounds.union(intersection);
		//trace("union = " + union);
		
		maskContainer.cache(union.x, union.y, union.width, union.height);
		//nanofl.ide.CanvasTracer.trace(maskContainer.cacheCanvas, "maskContainer(2)");
		
		var objBounds2 = DisplayObjectTools.getOuterBounds(obj, true);
		obj.cache(objBounds2.x, objBounds2.y, objBounds2.width, objBounds2.height);
		//nanofl.ide.CanvasTracer.trace(obj.cacheCanvas, "obj(3)");
		
		new easeljs.filters.AlphaMaskFilter(maskContainer.cacheCanvas).applyFilter(obj.cacheCanvas.getContext2d(), 0, 0, Std.int(objBounds.width), Std.int(objBounds.height));
		//nanofl.ide.CanvasTracer.trace(obj.cacheCanvas, "obj(4)");
	}
}