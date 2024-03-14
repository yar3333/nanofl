package nanofl.engine;

import js.Browser;
import js.html.CanvasElement;
import easeljs.display.Container;
import easeljs.display.DisplayObject;

class MaskTools
{
    static var onePixTransarentCanvas : CanvasElement;
    static function getOnePixTransarentCanvas()
    {
        if (onePixTransarentCanvas == null)
        {
            onePixTransarentCanvas = Browser.document.createCanvasElement();
            onePixTransarentCanvas.width = 1;
            onePixTransarentCanvas.height = 1;
        }
        return onePixTransarentCanvas;
    }

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
		
        mask.transformMatrix = obj.getMatrix().invert();

	    final maskContainer = new Container();
		maskContainer.addChild(mask);
		
	    final maskContainerBounds = DisplayObjectTools.getOuterBounds(maskContainer);
		if (maskContainerBounds == null || maskContainerBounds.width == 0 || maskContainerBounds.height == 0)
        {
            obj.cache(0, 0, 1, 1);
            obj.cacheCanvas = getOnePixTransarentCanvas();
            return; 
        }
        
	    final intersection = maskContainerBounds.intersection(objBounds);
		if (intersection == null || intersection.width == 0 || intersection.height == 0)
        {
            obj.cache(0, 0, 1, 1);
            obj.cacheCanvas = getOnePixTransarentCanvas();
            return;
        }

        final cacheBounds = DisplayObjectTools.getRectangleForCaching(intersection);
		
        maskContainer.cache(cast cacheBounds.x, cast cacheBounds.y, cast cacheBounds.width, cast cacheBounds.height, 2); // cache scale > 1 to prevent blinking
        obj          .cache(cast cacheBounds.x, cast cacheBounds.y, cast cacheBounds.width, cast cacheBounds.height, 2);
		
		new easeljs.filters.AlphaMaskFilter(maskContainer.cacheCanvas)
            .applyFilter(obj.cacheCanvas.getContext2d(), 0, 0, 
                maskContainer.cacheCanvas.width, 
                maskContainer.cacheCanvas.height);
	}
}