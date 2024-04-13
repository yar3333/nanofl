package nanofl.engine;

import easeljs.geom.Matrix2D;
import js.Browser;
import js.html.CanvasElement;
import easeljs.filters.BitmapCache;
import easeljs.geom.Rectangle;
import easeljs.display.DisplayObject;

class MaskTools
{
    static var onePixTransarentCanvas : CanvasElement;

    public static function processMovieClip(mc:MovieClip) : Void
    {
        final masks = new Map<Int, DisplayObject>();
        
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
                    MaskTools.applyMaskToDisplayObject(mask.bitmapCache, mask.cacheCanvas, child);
                }
            }
        }
    }

    static function createMaskFromMovieClipLayer(mc:MovieClip, layerIndex:Int) : DisplayObject
    {
        final savedVisible = mc.children.map(x -> x.visible);
        for (child in mc.children) child.visible = false;

        final maskDisplayObjects = mc.getChildrenByLayerIndex(layerIndex);
        for (child in maskDisplayObjects) child.visible = true;

        DisplayObjectTools.cache(mc);

        final maskBitmapCache = mc.bitmapCache;
        final maskCacheCanvas = mc.cacheCanvas;
        mc.bitmapCache = null;
        mc.cacheCanvas = null;

        for (i in 0...mc.children.length) mc.children[i].visible = savedVisible[i];
        
        final mask = new DisplayObject();
        mask.bitmapCache = maskBitmapCache;
        (cast mask.bitmapCache).target = mask;
        mask.cacheCanvas = maskCacheCanvas;

        return mask;
    }

    public static function applyMaskToDisplayObject(maskBitmapCache:BitmapCache, maskCacheCanvas:CanvasElement, obj:DisplayObject) : Void
    {
        if (!obj.visible) return;

        final mc = obj.parent;
        final savedVisible = mc.children.map(x -> x.visible);
        for (child in mc.children) child.visible = false;

        obj.visible = true;
        
        applyMaskToDisplayObjectInner(maskBitmapCache, maskCacheCanvas, obj);
        
        for (i in 0...mc.children.length) mc.children[i].visible = savedVisible[i];
    }

    static function applyMaskToDisplayObjectInner(maskBitmapCache:BitmapCache, maskCacheCanvas:CanvasElement, obj:DisplayObject) : Void
	{
        obj.transformMatrix = null;

        final mc = obj.parent;

        final objBounds = DisplayObjectTools.getInnerBounds(mc);
		if (objBounds == null || objBounds.width == 0 || objBounds.height == 0) return;

	    final maskBounds = new Rectangle(maskBitmapCache.x, maskBitmapCache.y, maskBitmapCache.width, maskBitmapCache.height);
        
	    final intersection = maskBounds.intersection(objBounds);
		if (intersection == null || intersection.width == 0 || intersection.height == 0)
        {
            obj.cache(0, 0, 1, 1);
            obj.cacheCanvas = getOnePixTransarentCanvas();
            return;
        }

        mc.cache(cast maskBounds.x, cast maskBounds.y, cast maskBounds.width, cast maskBounds.height, 1);
		
		new easeljs.filters.AlphaMaskFilter(maskCacheCanvas)
            .applyFilter(mc.cacheCanvas.getContext2d(), 0, 0, 
                maskCacheCanvas.width, 
                maskCacheCanvas.height);

        obj.bitmapCache = mc.bitmapCache;
        (cast obj.bitmapCache).target = obj;
        obj.cacheCanvas = mc.cacheCanvas;
        obj.transformMatrix = new Matrix2D();

        mc.bitmapCache = null;
        mc.cacheCanvas = null;
	}

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
}