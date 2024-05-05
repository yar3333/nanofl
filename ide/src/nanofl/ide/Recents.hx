package nanofl.ide;

import haxe.io.Path;
import htmlparser.XmlBuilder;
import htmlparser.XmlDocument;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.ui.View;
import nanofl.ide.ui.menu.MenuTools;
import stdlib.Std;
using StringTools;

@:rtti
class Recents extends InjectContainer
{
	static inline var COUNT_LIMIT = 30;
	static inline var LENGTH_LIMIT = 50;
	
	@inject var fileSystem : FileSystem;
	@inject var preferences : Preferences;
	@inject var folders : Folders;
	@inject var keyboard : Keyboard;
	
	var paths(default, null) : Array<String>;
	
	public function new()
	{
		super();
		
		if (preferences.application.recentDocuments == null)
		{
			preferences.application.recentDocuments = getExamples().map(FilePathTools.normalize).join("*");
		}
		
		var v = preferences.application.recentDocuments;
		paths = v != null && v != "" ? v.split("*") : [];
	}
	
	public function add(path:String, view:View) : Void
	{
		log("recents.add " + path);
		
		path = FilePathTools.normalize(fileSystem.absolutePath(path));
		log("recents postprocessed path(1) = " + path);
		
		var appDir = FilePathTools.normalize(folders.application) + "/";
		log("recents appDir = " + appDir);
		if (path.startsWith(appDir)) path = path.substring(appDir.length);
		
		log("recents postprocessed path(2) = " + path);
		
		paths = paths.filter(s -> s != path);
		paths.unshift(path);
		trimPaths();
		preferences.application.recentDocuments = paths.join("*");
		
		view.mainMenu.update();
		view.startPage.update();
	}
	
	public function getAsMenuItems(prefixID:String, ?options:{ ?addEmptyIfNoRecents:Bool, ?countLimit:Int, ?lengthLimit:Int }) : XmlDocument
	{
		if (options == null) options = {};
		
		var out = new XmlBuilder();
		
		if (paths.length > 0)
		{
			trimPaths();
			
			var paths = options.countLimit == null ? this.paths 
			                          : this.paths.slice(0, Std.min(options.countLimit, this.paths.length));
			for (path in paths)
			{
				log("recent getAsMenuItems path = " + path);
				
				MenuTools.writeItem
				(
					{
						name: getShortPath(path, options.lengthLimit == null ? LENGTH_LIMIT : options.lengthLimit),
						title: path,
						icon: getDocumentIcon(path),
						command: "document.open",
						params: [ path ]
					},
					keyboard,
					prefixID,
					out
				);
			}
		}
		else
		{
			if (options.addEmptyIfNoRecents)
			{
				MenuTools.writeItem({ name:"Empty" }, keyboard, prefixID, out);
			}
		}
		
		return out.xml;
	}
	
	function getShortPath(path:String, lengthLimit:Int)
	{
		if (path.endsWith(".nfl"))
		{
			path = Path.withoutExtension(path);
			if (Path.withoutDirectory(path) == Path.withoutDirectory(Path.directory(path)))
			{
				path = Path.directory(path);
			}
		}
		
		var dir = Path.directory(path);
		var file = Path.withoutDirectory(path);
		
		if (dir == "") return file;
		
		if (dir.length + file.length + 1 <= lengthLimit) return dir + "/" + file;
		
		var lenDir = lengthLimit - ".../".length - file.length;
		if (lenDir <= 0) return ".../" + file;
		
		var dirFromChar = Std.max(dir.length - lenDir, 0);
		if (dirFromChar == 0) return dir + "/" + file;
		
		return "..." + dir.substr(dirFromChar) + "/" + file;
	}
	
	function getDocumentIcon(path:String) : String
	{
		var ext = Path.extension(path);
		if (ext == "nfl") return "custom-icon-native-document";
		var importer = ImporterPlugins.getByExtension(ext);
		return importer != null ? importer.menuItemIcon : "custom-icon-page-document";
	}
	
	function trimPaths()
	{
		if (paths.length > COUNT_LIMIT)
		{
			paths = paths.slice(0, COUNT_LIMIT);
		}
	}
	
	function getExamples() : Array<String>
	{
		var examplesDir = folders.userDocuments + "/NanoFL/Examples";
		
		if (!fileSystem.exists(examplesDir)) return [];
		
		var r = [];
		
		for (dir in fileSystem.readDirectory(examplesDir))
		{
			if (fileSystem.isDirectory(examplesDir + "/" + dir))
			{
				for (file in fileSystem.readDirectory(examplesDir + "/" + dir))
				{
					if (file.endsWith(".nfl"))
					{
						r.push(examplesDir + "/" + dir + "/" + file);
					}
				}
			}
		}
		
		return r;
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("Recents", v);
	}
}