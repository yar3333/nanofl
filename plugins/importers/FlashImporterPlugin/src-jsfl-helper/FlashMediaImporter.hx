import haxe.io.Path;
import jsfl.BitmapInstance;
import jsfl.BitmapItem;
import jsfl.SoundItem;
import jsfl.Flash;
import jsfl.FLfile;
import jsfl.Item.ItemType;
import jsfl.SoundItem.SoundCompressionType;
using StringTools;

class FlashMediaImporter
{
	static var SRC_FILE = "{SRC_FILE}";
	static var DEST_DIR = "{DEST_DIR}";
	
	static var TEMP_MC_NAME = "__temp_fme";
	
	static function main()
	{
		var srcFilePath = "file:///" + SRC_FILE.replace("\\", "/");
		var destLibraryDir = "file:///" + Path.addTrailingSlash(DEST_DIR.replace("\\", "/")) + "library";
		
		log("Import media from '" + srcFilePath + "' to '" + destLibraryDir + "' directory:");
		
		var doc = Flash.openDocument(srcFilePath);
		
		FLfile.createFolder(destLibraryDir);
		
		for (i in 0...doc.library.items.length)
		{
			var item = doc.library.items[i];
			
			if (item != null)
			{
				switch (item.itemType)
				{
					case  ItemType.Bitmap:
						log("  Import: " + item.name + " / " + item.itemType + " / " + (cast item:BitmapItem).originalCompressionType);
						importBitmap(destLibraryDir, cast item);
						
					case ItemType.MovieClip, ItemType.Graphic, ItemType.Button, ItemType.Folder:
						// nothing to do
						
					case ItemType.Sound:
						log("  Import: " + item.name + " / " + item.itemType + " / " + (cast item:SoundItem).originalCompressionType);
						importSound(destLibraryDir, cast item);
						
					case _:
						log("    Skip: " + item.name + " / " + item.itemType);
				}
			}
		}
		
		doc.close(false);
		
		
		log("Done.");
		
		FLfile.write("file:///" + DEST_DIR.replace("\\", "/") + "/.done-import-media", "");
	}
	
	static function importBitmap(destLibraryDir:String, item:BitmapItem) : Bool
	{
		var savePath = destLibraryDir + "/" + item.name + ".png";
		if (!FLfile.exists(savePath))
		{
			FLfile.createFolder(Path.directory(savePath));
			
			var temp = Flash.createDocument();
			temp.addItem({ x:0, y:0 }, item);
			var image : BitmapInstance = cast temp.getTimeline().layers[0].frames[0].elements[0];
			temp.width = image.getBits().width;
			temp.height = image.getBits().height;
			image.x = 0;
			image.y = 0;
			image.setTransformationPoint({ x:0, y:0 });
			image.width = temp.width;
			image.height = temp.height;
			temp.exportPNG(savePath, false, true);
			temp.close(false);
		}
		return true;
	}
	
	static function importSound(destLibraryDir:String, item:SoundItem) : Bool
	{
		var savePath = destLibraryDir + "/" + Path.withoutExtension(item.name) + (item.originalCompressionType == SoundCompressionType.RAW ? ".wav" : ".mp3");
		if (!FLfile.exists(savePath))
		{
			FLfile.createFolder(Path.directory(savePath));
			item.exportToFile(savePath);
		}
		return true;
	}
	
	static function log(s:String) : Void
	{
		Flash.trace(s);
	}
}
