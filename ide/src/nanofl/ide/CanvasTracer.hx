package nanofl.ide;

class CanvasTracer
{
	public static function trace(canvas:js.html.CanvasElement, ?text:String)
	{
		var s = "";
		var context = canvas.getContext2d();
		var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
		var data = imageData.data;
		for (y in 0...imageData.height)
		{
			for (x in 0...imageData.width)
			{
				var pos = (y * imageData.width + x) * 4;
				s += (data[pos] != 255 ||  data[pos + 1] != 255 || data[pos + 2] != 255) && data[pos + 3] != 0 ? "X" : ".";
			}
			s += "\n";
		}
		trace("canvas " + (text != null ? text + " " : "") + imageData.width + " x " + imageData.height + ":\n" + StringTools.rtrim(s));
	}
}