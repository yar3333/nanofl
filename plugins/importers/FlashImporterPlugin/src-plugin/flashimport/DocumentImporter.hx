package flashimport;

import nanofl.ide.plugins.PluginApi;
import js.lib.Promise;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.libraryitems.FolderItem;
import haxe.io.Path;
import htmlparser.XmlDocument;
import nanofl.ide.DocumentProperties;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.Fonts;
import nanofl.ide.sys.ProcessManager;
using htmlparser.HtmlParserTools;
using StringTools;

class DocumentImporter
{
	public static function process(api:PluginApi, importMediaScriptTemplate:String, srcFilePath:String, destFilePath:String, destDocProp:DocumentProperties, destLibrary:IdeLibrary, runFlashToImportMedia:Bool) : Promise<Bool>
	{
		log("DocumentImporter.process");
		
		if (runFlashToImportMedia && hasMedia(api, srcFilePath))
		{
			return importMedia(api, importMediaScriptTemplate, srcFilePath, destFilePath, destLibrary).then(function(success)
			{
				return success 
						? importXmlFiles(api, srcFilePath, destDocProp, destLibrary)
						: Promise.resolve(false);
			});
		}
		else
		{
			return importXmlFiles(api, srcFilePath, destDocProp, destLibrary);
		}
	}
	
	static function hasMedia(api:PluginApi, srcFilePath:String) : Bool
	{
		var doc = new XmlDocument(api.fileSystem.getContent(Path.directory(srcFilePath) + "/DOMDocument.xml"));
		return doc.findOne(">DOMDocument>media>*") != null;
	}
	
	static function importMedia(api:PluginApi, importMediaScriptTemplate:String, srcFilePath:String, destFilePath:String, destLibrary:IdeLibrary) : Promise<Bool>
	{
		log("DocumentImporter.importMedia");
		
		var destDir = Path.directory(destFilePath);
		
		var scriptFilePath = api.folders.temp + "/flashImporter.jsfl";
		
		var script = importMediaScriptTemplate
			.replace("{SRC_FILE}", srcFilePath.replace("\\", "/"))
			.replace("{DEST_DIR}", destDir.replace("\\", "/"));
		
		api.fileSystem.saveContent(scriptFilePath, script);
		
		var doneFile = destDir + "/.done-import-media";
		api.fileSystem.deleteFile(doneFile);
		api.processManager.run(scriptFilePath, [], false);
		
		return waitFor(600, function() return api.fileSystem.exists(doneFile)).then(function(success:Bool)
		{
			if (success)
			{
				api.fileSystem.deleteFile(doneFile);
				destLibrary.loadItems();
				return true;
			}
			else
			{
				return false;
			}
		});
	}
	
	static function importXmlFiles(api:PluginApi, srcFilePath:String, destDocProp:DocumentProperties, destLibrary:IdeLibrary) : Promise<Bool>
	{
		log("DocumentImporter.importXmlFiles BEGIN");
		
		var srcDir = Path.directory(srcFilePath);
		
		var srcDoc = new XmlDocument(api.fileSystem.getContent(srcDir + "/DOMDocument.xml"));
		
		var srcLibDir = srcDir + "/LIBRARY";
		var symbolLoader = new SymbolLoader(api.fileSystem, api.fonts, srcDoc, srcLibDir, destLibrary);
		var docPropNode = srcDoc.findOne(">DOMDocument");
		destDocProp.width = docPropNode.getAttr("width", 550);
		destDocProp.height = docPropNode.getAttr("height", 400);
		destDocProp.backgroundColor = docPropNode.getAttr("backgroundColor", "#ffffff");
		destDocProp.framerate = docPropNode.getAttr("frameRate", 24);
		
		log("DocumentImporter.importXmlFiles load media");
		for (node in docPropNode.find(">media>DOMSoundItem"))
		{
			var soundItem = destLibrary.getItem(node.getAttr("name"));
			if (Std.is(soundItem, SoundItem))
			{
				if (node.getAttr("linkageExportForAS", false))
				{
					(cast soundItem:SoundItem).linkage = node.getAttr("linkageIdentifier");
				}
			}
		}
		
		log("DocumentImporter.importXmlFiles load folders");
		for (node in docPropNode.find(">folders>DOMFolderItem"))
		{
			if (node.hasAttribute("name"))
			{
				var namePath = node.getAttr("name", "");
				if (namePath != "")
				{
					destLibrary.addItem(new FolderItem(namePath));
				}
			}
		}
		
		log("DocumentImporter.importXmlFiles load document");
		symbolLoader.loadFromXml(IdeLibrary.SCENE_NAME_PATH, srcDoc);
		
		log("DocumentImporter.importXmlFiles load symbols");
		var hrefs = docPropNode.find(">symbols>Include").map(function(node) return node.getAttrString("href"));
		
		log("DocumentImporter.importXmlFiles load library");
		return new Promise<Bool>(function(resolve, reject)
		{
			function loadNext()
			{
				if (hrefs.length == 0)
				{
					log("DocumentImporter.importXmlFiles END");
					resolve(true);
				}
				else
				{
					symbolLoader.loadFromFile(hrefs.shift());
					haxe.Timer.delay(loadNext, 10);
				}
			}
			loadNext();
		});
	}
	
	static function waitFor(maxSeconds=0, condition:Void->Bool) : Promise<Bool>
	{
		return new Promise<Bool>(function(resolve, reject)
		{
			if (condition()) resolve(true);
			else
			{
				var start = Date.now().getTime();
				var timer = new haxe.Timer(200);
				timer.run = function()
				{
					if (condition())
					{
						timer.stop();
						resolve(true);
					}
					else
					if (maxSeconds > 0 && Date.now().getTime() - start > maxSeconds * 1000)
					{
						timer.stop();
						resolve(false);
					}
				};
			}
		});
	}	
	
	static function log(s:String, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(s, infos);
	}
}