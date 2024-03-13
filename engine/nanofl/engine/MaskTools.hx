package nanofl.engine;

import easeljs.display.Container;
import easeljs.display.DisplayObject;

class MaskTools
{
    public static function createMaskFromMovieClipLayer(mc:MovieClip, layerIndex:Int) : Container
    {
        final mask = new Container();
        for (obj in mc.getChildrenByLayerIndex(layerIndex))
        {
            final clonedObj = obj.clone(true);
            clonedObj.visible = true;
            mask.addChild(clonedObj);
        }
        return mask;
    }

    public static function applyMaskToDisplayObject(mask:DisplayObject, obj:DisplayObject) : Void
	{
	    final objBounds = DisplayObjectTools.getOuterBounds(obj);
		if (objBounds == null || objBounds.width == 0 || objBounds.height == 0) return;
		//trace("objBounds = " + objBounds);
		
        mask.transformMatrix = obj.getMatrix().invert();

	    final maskContainer = new Container();
		maskContainer.addChild(mask);
		
	    final maskContainerBounds = DisplayObjectTools.getOuterBounds(maskContainer);
		if (maskContainerBounds == null || maskContainerBounds.width == 0 || maskContainerBounds.height == 0) { obj.visible = false; return; }
        
	    final intersection = maskContainerBounds.intersection(objBounds);
		if (intersection == null || intersection.width == 0 || intersection.height == 0) { obj.visible = false; return; }

        obj.visible = true;
		
	    final union = objBounds.union(intersection);

        DisplayObjectTools.cache(maskContainer, union);
		
	    final objBounds2 = DisplayObjectTools.getOuterBounds(obj, true);
        DisplayObjectTools.cache(obj, objBounds2);
		
		new easeljs.filters.AlphaMaskFilter(maskContainer.cacheCanvas).applyFilter(obj.cacheCanvas.getContext2d(), 0, 0, Math.ceil(objBounds.width), Math.ceil(objBounds.height));
	}
}