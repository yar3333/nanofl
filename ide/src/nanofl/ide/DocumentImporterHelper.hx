package nanofl.ide;

import js.lib.Promise;
import nanofl.ide.Application;
import nanofl.ide.Document;
import nanofl.ide.plugins.Importer;
import nanofl.ide.SafeCode;
import nanofl.engine.Library;
import nanofl.engine.ILibraryItem;
import stdlib.Std;

class DocumentImporterHelper
{
	public static function run(path:String, document:Document, importer:Importer) : Promise<Document>
	{
		return new Promise<Document>(function(resolve, reject)
		{
			trace("Import document " + path + " => " + document.path);
			
			var success = SafeCode.run("Error during importing", function()
			{
				log("Import1");
				importer.run(path, document.path, document.properties, document.library.getRawLibrary()).then(function(success:Bool)
				{
					log("Import4 " + success);
					resolve(success ? document : null);
				});
				log("Import2");
			});
			
			log("Import3 " + success);
			if (!success) resolve(null);
		});
	}
	
 	static function log(v:Dynamic, ?infos:haxe.PosInfos)
 	{
		//haxe.Log.trace(v, infos);
 	}
}