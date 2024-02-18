import haxe.crypto.Base64;
import js.html.CanvasElement;
import nanofl.DisplayObjectTools;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.sys.FileSystem;

class ImageExporter
{
	public static function run(type:String, fileSystem:FileSystem, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		var instance = library.getSceneInstance();
		var scene : easeljs.display.DisplayObject = instance.createDisplayObject(null);
		DisplayObjectTools.smartCache(scene);
		
		var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
		canvas.width = documentProperties.width;
		canvas.height = documentProperties.height;
		
		var ctx = canvas.getContext2d();
		ctx.fillStyle = documentProperties.backgroundColor;
		ctx.fillRect(0, 0, documentProperties.width, documentProperties.height);
		scene.draw(ctx);
		
		var data = canvas.toDataURL(type).split(",")[1];
		fileSystem.saveBinary(destFilePath, Base64.decode(data));
		
		return true;
	}
}