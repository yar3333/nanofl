package components.nanofl.others.bitmapselector;

import haxe.io.Path;
import nanofl.ide.libraryitems.BitmapItem;
import wquery.Event;
//using js.jquery.Spectrum;
using Lambda;
using StringTools;

class Code extends wquery.Component
{
    var event_change = new Event<{ bitmapPath:String }>();
	
	var bitmaps : Array<BitmapItem>;
	var bitmapPath : String;
	
	function init()
	{
		template().image.load(_ -> resizeImage());
	}
	
	function resizeImage()
	{
		var image = template().image;
		
		var width = (cast image[0]).naturalWidth;
		var height = (cast image[0]).naturalHeight;
		
		var containerWidth = template().content.width() - 2;
		var containerHeight = template().content.height() - 2;
		
		var k = Math.min(containerWidth / width, containerHeight / height);
		image.width(Math.round(k * width));
		image.height(Math.round(k * height));
		
		image.show();
	}
	
	public function bind(bitmaps:Array<BitmapItem>, ?bitmapPath:String)
	{
		this.bitmaps = bitmaps;
		
		if (bitmapPath != null) this.bitmapPath = bitmapPath;
		
		update(getIndex(bitmapPath));
	}
	
	function prev_click(e)
	{
		update(getIndex(bitmapPath) - 1);
	}
	
	function next_click(e)
	{
		update(getIndex(bitmapPath) + 1);
	}
	
	function update(n:Int)
	{
		var url = n >= 0 && n < bitmaps.length ? getUrl(bitmaps[n].namePath) : null;
		
		if (url != null)
		{
			if (bitmaps[n].namePath != bitmapPath)
			{
				bitmapPath = bitmaps[n].namePath;
				event_change.emit({ bitmapPath:bitmapPath });
			}
			
			if (template().image.attr("src") != url)
			{
				template().image.hide().attr("src", url);
			}
		}
		else
		{
			bitmapPath = null;
			template().image.attr("src", "../../" + Path.directory(Type.getClassName(Type.getClass(this)).replace(".", "/")) + "/support/nothing.png");
		}
		
		template().prev.toggleClass("~disabled", bitmaps.length == 0 || n < 0);
		template().next.toggleClass("~disabled", bitmaps.length == 0 || n >= bitmaps.length - 1);
	}
	
	function getUrl(bitmapPath:String) : String
	{
		if (bitmapPath == null) return null;
		var item = bitmaps.find(x -> x.namePath == bitmapPath);
		if (item == null) return null;
		return item.getUrl();
	}
	
	function getIndex(bitmapPath:String) : Int
	{
		for (i in 0...bitmaps.length)
		{
			if (bitmaps[i].namePath == bitmapPath) return i;
		}
		return -1;
	}
	
	public function show() template().container.show();
	public function hide() template().container.hide();
}