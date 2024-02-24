package nanofl.ide;

#if ide

import nanofl.engine.Library;
import nanofl.engine.libraryitems.BitmapItem;

class BitmapItemTools
{
	public static function isTransparent(library:Library, item:BitmapItem) : Bool
	{
		return isImageTransparent(item.image);
	}
	
	static function isImageTransparent(image:js.html.ImageElement)
	{
		var canvas : js.html.CanvasElement = cast js.Browser.document.createElement("canvas");
		canvas.width = image.width; 
		canvas.height = image.height; 
		var ctx = canvas.getContext2d();
		ctx.drawImage(image, 0, 0); 
		var data = ctx.getImageData(0, 0, canvas.width, canvas.height);
		var size = data.width * data.height;
		var i = 3; while (i < size)
		{
			if (data.data[i] != 255) return true;
			i += 4;
		}
		return false;
	}
}

#end