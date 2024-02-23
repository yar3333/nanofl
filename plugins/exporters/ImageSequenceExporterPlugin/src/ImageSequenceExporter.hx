import haxe.crypto.Base64;
import haxe.io.Path;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.sys.FileSystem;
using StringTools;

class ImageSequenceExporter
{
	public static function run(type:String, applyBackgroundColor:Bool, fileSystem:FileSystem, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		var totalFrames = library.getSceneItem().getTotalFrames();
		var digits = Std.string(totalFrames - 1).length;
		
		var baseDestFilePath = Path.withoutExtension(destFilePath) + "_";
		var ext = "." + Path.extension(destFilePath);

        var sceneFramesIterator = library.getSceneFramesIterator(documentProperties, applyBackgroundColor);

        var i = 0;
        while (sceneFramesIterator.hasNext())
        {
            var ctx = sceneFramesIterator.next();
			var data = ctx.canvas.toDataURL(type).split(",")[1];
			fileSystem.saveBinary(baseDestFilePath + Std.string(i++).lpad("0", digits) + ext, Base64.decode(data));
        }
		
		return true;
	}
}