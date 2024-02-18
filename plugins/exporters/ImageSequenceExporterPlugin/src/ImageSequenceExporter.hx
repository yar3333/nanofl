import haxe.crypto.Base64;
import haxe.io.Path;
import js.html.CanvasElement;
import nanofl.MovieClip;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.sys.FileSystem;
using StringTools;

class ImageSequenceExporter
{
	public static function run(type:String, fileSystem:FileSystem, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		var totalFrames = library.getSceneItem().getTotalFrames();
		var digits = Std.string(totalFrames - 1).length;
		
		var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
		canvas.width = documentProperties.width;
		canvas.height = documentProperties.height;
		
		var ctx = canvas.getContext2d();
		
		var baseDestFilePath = Path.withoutExtension(destFilePath) + "_";
		var ext = "." + Path.extension(destFilePath);
		
		for (i in 0...totalFrames)
		{
			var scene = new MovieClip(library.getSceneItem(), i, null);
			
			ctx.fillStyle = documentProperties.backgroundColor;
			ctx.fillRect(0, 0, documentProperties.width, documentProperties.height);
			scene.draw(ctx);
			
			var data = canvas.toDataURL(type).split(",")[1];
			fileSystem.saveBinary(baseDestFilePath + Std.string(i).lpad("0", digits) + ext, Base64.decode(data));
		}
		
		return true;
	}
}