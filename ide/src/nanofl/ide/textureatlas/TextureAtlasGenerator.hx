package nanofl.ide.textureatlas;

import easeljs.display.DisplayObject;
import haxe.crypto.Base64;
import nanofl.ide.libraryitems.IIdeInstancableItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.textureatlas.TextureAtlas;
import nanofl.MovieClip;
import stdlib.Debug;
import stdlib.Std;

class TextureAtlasGenerator
{
	public var width   (default, null) : Int;
	public var height  (default, null) : Int;
	public var method  (default, null) : PackingMethod;
	public var sorter  (default, null) : Array<ImageData->ImageData->Int>;
	public var rotate  (default, null) : RotateMethod;
	public var padding (default, null) : Int;
	
	public function new(width=2048, height=2048, padding=1, ?packingMethod:PackingMethod, ?sortingMethods:Array<SortingMethod>, ?rotateMethod:RotateMethod)
	{
		if (packingMethod == null) packingMethod = PackingMethod.TopLeftPacking;
		if (sortingMethods == null) sortingMethods =
		[
			SortingMethod.SortByMaxSizeDesc,
			SortingMethod.SortByMinSizeDesc,
			SortingMethod.SortByWidthDesc,
			SortingMethod.SortByHeightDesc
		];
		if (rotateMethod == null) rotateMethod = RotateMethod.NoRotation;
		
		this.width   = width;
		this.height  = height;
		this.padding = padding;
		this.method  = packingMethod;
		this.sorter  = parseSorter(sortingMethods);
		this.rotate  = rotateMethod;
	}
	
	public function generate(items:Array<IIdeLibraryItem>) : TextureAtlas
	{
		var images = getImages(items);
		
		for (image in images)
		{
			if (image.canvas.width > width || image.canvas.height > height)
			{
				throw "There is one or more image that is bigger than the texture atlas size.";
			}
		}
		
		images.sort((a, b) ->
		{
			for (s in sorter)
			{
				var d = s(a, b);
				if (d != 0) return d;
			}
			return 0;
		});
		
		var packer = new Packer<ImageData>(width, height, padding, method, rotate);
		
		for (image in images)
		{
			if (!packer.add(image.canvas.width, image.canvas.height, image)) return null;
		}
		
		var canvas = js.Browser.document.createCanvasElement();
		canvas.width = width;
		canvas.height = height;
		
		// x, y, width, height, imageIndex*, regX*, regY*
		var frames = new Array<nanofl.ide.textureatlas.TextureAtlasFrame>();
		var ctx = canvas.getContext2d();
		var frameIndexes = new Map<String, Int>();
		for (p in packer)
		{
			Debug.assert(!p.rotated);
			ctx.drawImage(p.data.canvas, 0, 0, p.data.canvas.width, p.data.canvas.height, p.rect.x, p.rect.y, p.rect.width, p.rect.height);
			for (ref in p.data.refs)
			{
				var name = ref.namePath + (ref.frameIndex != null ? ":" + ref.frameIndex : "");
				Debug.assert(!frameIndexes.exists(name));
				frameIndexes.set(name, frames.length);
				frames.push
				({
					x: p.rect.x,
					y: p.rect.y,
					width: p.rect.width,
					height: p.rect.height,
					regX: ref.regX,
					regY: ref.regY
				});
			}
		}
		
		var itemFrames : Dynamic<Array<Int>> = {};
		for (item in items)
		{
			var indexes = [];
			var item : IIdeInstancableItem = cast item;
			if (Std.isOfType(item, MovieClipItem))
			{
				for (i in 0...(cast item:MovieClipItem).getTotalFrames())
				{
					indexes.push(frameIndexes.get(item.namePath + ":" + i));
				}
			}
			else
			{
				indexes.push(frameIndexes.get(item.namePath));
			}
			Reflect.setField(itemFrames, item.namePath, indexes);
		}
		
		var imagePngAsBase64 = canvas.toDataURL("image/png").substring("data:image/png;base64,".length);
		
		return { imagePngAsBase64:imagePngAsBase64, frames:frames, itemFrames:itemFrames };
	}
	
	function getImages(items:Array<IIdeLibraryItem>) : Array<ImageData>
	{
		var images = new Array<ImageData>();
		var datas = [];
		
		var oldSnapToPixelEnabled = (cast DisplayObject)._snapToPixelEnabled;
		(cast DisplayObject)._snapToPixelEnabled = true;
		
		for (item in items)
		{
			if (Std.isOfType(item, IIdeInstancableItem))
			{
				var item : IIdeInstancableItem = cast item;
				var instance = item.newInstance();
				var dispObj = instance.createDisplayObject(null);
				
				if (Std.isOfType(dispObj, MovieClip))
				{
					var mc : MovieClip = cast dispObj;
					
					var totalFrames = mc.getTotalFrames();
					for (frameIndex in 0...totalFrames)
					{
						mc.gotoFrame(frameIndex);
						
						cacheDisplayObject(mc);
						
						if (mc.cacheCanvas != null)
						{
							var newImageData = mc.cacheCanvas.toDataURL("image/bmp");
							if (datas.indexOf(newImageData) < 0)
							{
								images.push({ canvas:mc.cacheCanvas, refs:[ newImageRef(item, frameIndex, mc) ] });
								//trace("add " + item.namePath + ":" + frameIndex + " / " + mc.cacheCanvas.width + " x " + mc.cacheCanvas.height);
								datas.push(newImageData);
							}
							else
							{
								images[images.length - 1].refs.push(newImageRef(item, frameIndex, mc));
							}
						}
					}
				}
				else
				{
					cacheDisplayObject(dispObj);
					if (dispObj.cacheCanvas != null)
					{
						images.push({ canvas:dispObj.cacheCanvas, refs:[ newImageRef(item, null, dispObj) ] });
					}
				}
			}
			else
			{
				Debug.assert(false, item.toString());
			}
		}
		
		(cast DisplayObject)._snapToPixelEnabled = oldSnapToPixelEnabled;
		
		return images;
	}
	
	function parseSorter(sortingMethods:Array<SortingMethod>) : Array<ImageData->ImageData->Int>
	{
		var r = [];
		for (sortingMethod in sortingMethods)
		{
			switch (sortingMethod)
			{
				case SortingMethod.SortByMinSizeDesc:	r.push((a:ImageData, b:ImageData) -> Std.min(b.canvas.width, b.canvas.height) - Std.min(a.canvas.width, a.canvas.height));
				case SortingMethod.SortByMaxSizeDesc:	r.push((a:ImageData, b:ImageData) -> Std.max(b.canvas.width, b.canvas.height) - Std.max(a.canvas.width, a.canvas.height));
				case SortingMethod.SortByWidthDesc:		r.push((a:ImageData, b:ImageData) -> b.canvas.width  - a.canvas.width);
				case SortingMethod.SortByHeightDesc:	r.push((a:ImageData, b:ImageData) -> b.canvas.height - a.canvas.height);
				case SortingMethod.SortByAreaDesc:		r.push((a:ImageData, b:ImageData) -> (b.canvas.width * b.canvas.height) - (a.canvas.width * a.canvas.height));
			}
		}
		return r;
	}
	
	function newImageRef(item:IIdeLibraryItem, frameIndex:Int,  dispObj:DisplayObject)
	{
		return
		{
			namePath: item.namePath,
			frameIndex: frameIndex,
			regX: -dispObj.bitmapCache.offX,
			regY: -dispObj.bitmapCache.offY,
		};
	}
	
	function cacheDisplayObject(obj:DisplayObject)
	{
        DisplayObjectTools.recache(obj, true);

		if (obj.cacheCanvas != null) return;
		
		var bounds = DisplayObjectTools.getOuterBounds(obj);
		if (bounds != null && bounds.width > 0 && bounds.height > 0)
		{
			bounds.x = Math.floor(bounds.x) - 1;
			bounds.y = Math.floor(bounds.y) - 1;
			bounds.width = Math.ceil(bounds.width) + 2;
			bounds.height = Math.ceil(bounds.height) + 2;
			obj.cache(bounds.x, bounds.y, bounds.width, bounds.height);
			
			var minX = 0;
			var minY = 0;
			var maxX = obj.cacheCanvas.width - 1;
			var maxY = obj.cacheCanvas.height- 1;
			while (minY < maxY && isCacheRectEmpty(obj, 0, minY, cast bounds.width, 1)) minY++;
			while (minY < maxY && isCacheRectEmpty(obj, 0, maxY, cast bounds.width, 1)) maxY--;
			while (minX < maxX && isCacheRectEmpty(obj, minX, 0, 1, cast bounds.height)) minX++;
			while (minX < maxX && isCacheRectEmpty(obj, maxX, 0, 1, cast bounds.height)) maxX--;
			if (minX != 0 || minY != 0 || maxX != obj.cacheCanvas.width - 1 || maxY != obj.cacheCanvas.height - 1)
			{
				obj.uncache();
				if (maxX - minX >= 0 && maxY - minY >= 0)
				{
					obj.cache(bounds.x + minX, bounds.y + minY, maxX - minX + 1, maxY - minY + 1);
				}
			}
		}
	}
	
	function isCacheRectEmpty(obj:DisplayObject, x:Int, y:Int, w:Int, h:Int) : Bool
	{
		var imageData = obj.cacheCanvas.getContext2d({ willReadFrequently:true }).getImageData(x, y, w, h);
		var size = imageData.width * imageData.height * 4;
		var i = 0; while (i < size)
		{
			if (imageData.data[i + 3] != 0) return false;
			i += 4;
		}
		return true;
	}
	
	public function toString()
	{
		return '{ width:$width, height:$height, method:$method, sorter:$sorter, rotate:$rotate }';
	}
}
