package nanofl.ide;

import js.lib.Promise;
import js.injecting.Injector;
import nanofl.ide.libraryitems.IIdeInstancableItem;
import haxe.Timer;
import haxe.io.Path;
import js.Browser;
import js.JQuery;
import nanofl.ide.sys.FileSystem;
import nanofl.engine.Version;
import nanofl.engine.elements.Instance;
import nanofl.ide.commands.Commands;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.filesystem.ExternalChangesDetector;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.plugins.IImporterPlugin;
import nanofl.ide.plugins.Importer;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.plugins.Plugins;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.preferences.PreferencesStorage;
import nanofl.ide.sys.Folders;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
import stdlib.Uuid;
using stdlib.Lambda;
using stdlib.StringTools;
using nanofl.ide.plugins.CustomizablePluginTools;

@:rtti
class Application extends js.injecting.InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;
	
	var layout : ILayout;
	var view : View;
	var popups : Popups;
	var clipboard : Clipboard;
	var commands : Commands;
	var plugins : Plugins;
	var keyboard : Keyboard;
	var preferences : Preferences;
	var openedFiles : OpenedFiles;
	var recents : Recents;
	
	public var activeView = ActiveView.EDITOR;
	
	public var document(get, never) : Document;
	function get_document() return openedFiles != null && openedFiles.active != null ? openedFiles.active.relatedDocument : null;
	
	public var pid : String;
	
	@:noapi
	public function new(injector:Injector)
	{
		injector.allowNoRttiForClass(undoqueue.UndoQueue);
		
		super(injector);
		
		injector.map(Commands, commands = new Commands());
		injector.map(Application, this);
		injector.map(Keyboard, keyboard = createKeyboard());
		injector.map(Preferences, preferences = new Preferences(new PreferencesStorage()));
		injector.map(NewObjectParams, new NewObjectParams());
		
		var clipboard = new Clipboard();
		injector.map(Clipboard, clipboard);
		
		injector.map(Recents, recents = new Recents());
		
		wquery.Template.baseURL = "../../";
		var page = wquery.Application.run("page", components.nanofl.page.Code, { injector:injector });
		
		this.layout = page;
		this.view = page.view;
		this.popups = page.popups;
		this.openedFiles = page.openedFiles;
		
		clipboard.setView(page.view);
		
		injector.map(Plugins, plugins = new Plugins());
		
		nanofl.ide.Log.init(fileSystem, view.alerter);
		
		new JQuery(Browser.window).resize();
		new JQuery(Browser.document.body).focus();
		
		new JQuery(Browser.window).on("close", function(e) { e.preventDefault(); quit(); });
		
		view.movie.editor  .on("mousedown", function(e) { activeView = ActiveView.EDITOR;   clipboard.restoreFocus(e.originalEvent); });
		view.movie.timeline.on("mousedown", function(e) { activeView = ActiveView.TIMELINE; clipboard.restoreFocus(e.originalEvent); });
		view.movie.timeline.on("mousedown", function(e) { activeView = ActiveView.TIMELINE; clipboard.restoreFocus(e.originalEvent); });
		view.library       .on("mousedown", function(e) { activeView = ActiveView.LIBRARY;  clipboard.restoreFocus(e.originalEvent); });
		view.output        .on("mousedown", function(e) { activeView = ActiveView.OUTPUT; });
		
		preferences.storage.applyToIDE(true);
		
		Log.onMessage.bind((_, e) ->
		{
			if      (e.type == "warn")  view.output.writeWarning(e.message);
			else if (e.type == "error") view.output.writeError(e.message);
			else                        view.output.writeInfo(e.message);
		});
		
        plugins.reload(false)
            .then(_ -> CommandLine.process())
            //.then(_ -> checkForUpdates())
            .then(_ -> ExternalChangesDetector.start());
	}
	
	public function createNewEmptyDocument(?callb:Document->Void) : Void
	{
		var properties = new DocumentProperties();
		
		var document = Document.createTemporary(openedFiles, folders, properties);
		document.library.getRawLibrary().addSceneWithFrame();
		document.activate(true);
		if (callb != null) callb(document);
	}
	
	public function openDocument(?path:String) : Promise<Document>
	{
		if (path == null)
		{
			var importers = ImporterPlugins.plugins.array();
			importers.sort((a, b) -> Reflect.compare(a.name, b.name));
			
			var filters = [];
			var allExtensions = ["nfl"]; for (importer in importers) allExtensions = allExtensions.concat(importer.fileFilterExtensions);
			filters.push({ name:"All supported formats", extensions:allExtensions });
			filters.push({ name:"NanoFL documents (*.nfl)", extensions:["nfl"] });
			for (importer in importers) 
			{
				filters.push({ name:importer.fileFilterDescription, extensions:importer.fileFilterExtensions });
			}
			
			return popups.showOpenFile("Select NanoFL document to open", filters).then(r ->
            {
                return r.filePaths != null && r.filePaths.length > 0 ? openDocument(r.filePaths[0]) : null;
            });
		}
		else
		{
			path = Path.normalize(path);
			recents.add(path, view);
			view.waiter.show();
			
			return new Promise<Document>(function(resolve, reject)
			{
				Timer.delay(function() // time to browser to show waiter
				{
					Document.load(fileSystem, openedFiles, preferences, folders, view, path).then(function(document:Document)
					{
						view.waiter.hide();
						if (document != null)
						{
							document.activate(true);
						}
						else
						{
							view.alerter.error("Can't open document '" + path + "'.");
						}
						resolve(document);
					});
				}, 50);
			});
		}
	}
	
	public function importDocument(?path:String, ?plugin:IImporterPlugin) : Promise<Document>
	{
		if (path == null)
		{
			return popups.showOpenFile
			(
				"Select file to import",
				[{ name:plugin.fileFilterDescription, extensions:plugin.fileFilterExtensions }]
			)
            .then(r ->
            {
                // TODO: check return null
                return r.filePaths.length > 0 ? importDocument(r.filePaths[0], plugin) : null;
            });
		}
		else
		{
			view.waiter.show();
			var importer = plugin != null ? new Importer(plugin.name, plugin.getParams(preferences.storage)) : null;
			return Document.import_(preferences, openedFiles, folders, view, path, importer).then(function(document:Document)
			{
				view.waiter.hide();
				if (document == null) view.alerter.error("Error during importing.");
				return document;
			});
		}
	}
	
	public function quit(force=false, exitCode=0) : Void
	{
		if (!force)
		{
			openedFiles.closeAll().then(function(_) exit(exitCode));
		}
		else
		{
			exit(exitCode);
		}
	}
	
	function exit(exitCode=0)
	{
		openedFiles.closeAll();
		if (pid != null)
		{
			fileSystem.saveContent(folders.temp + "/instances/" + pid + ".exitCode", Std.string(exitCode));
			var pidFilePath = folders.temp + "/instances/" + pid;
			if (fileSystem.exists(pidFilePath)) fileSystem.deleteFile(pidFilePath);
		}
		Browser.window.close();
	}
	
	function checkForUpdates() : Promise<{}>
	{
		var period = preferences.application.checkNewVersionPeriod;
		if (period == "no") return null;
		
		var lastDate = preferences.application.checkNewVersionLastDate != null ? preferences.application.checkNewVersionLastDate : 0.0;
		var dt = Date.now().getTime() - lastDate;
		
		switch (period)
		{
			case "day":		if (dt < DateTools.days(1)) return null;
			case "week":	if (dt < DateTools.days(7)) return null;
			case "month":	if (dt < DateTools.days(30)) return null;
		}

        return new Promise<{}>((resolve, reject) ->
        {
            JQuery.getJSON("http://nanofl.com/last_version_info.json?" + Uuid.newUuid(), (remoteVersionInfo, status, _) ->
            {
                if (status == "success")
                {
                    preferences.application.checkNewVersionLastDate = Date.now().getTime();
                    
                    //log("checkForUpdates remote version = " + remoteVersionInfo.version);
                    if (Version.compare(remoteVersionInfo.version, Version.ide) > 0)
                    {
                        view.alerter.warning
                        (
                            "New version " + remoteVersionInfo.version + " is available."
                          + " Your version is " + Version.ide + "."
                          + " Visit <a href=\"http://nanofl.com/\">nanofl.com</a> for updates.",
                          10000
                        );
                    }
                }
                else
                {
                    Browser.window.console.log("checkForUpdates status = " + status);
                }
                resolve(null);
            });
        });
	}
	
	function createKeyboard() : Keyboard
	{
		var keyboard = new Keyboard(commands);
		
		keyboard.onCtrlButtonChange.bind(function(_, e)
		{
			if (document != null)
			{
				document.editor.magnet = e.pressed;
			}
		});
		
		keyboard.onShiftButtonChange.bind(function(_, e)
		{
			if (document != null)
			{
				document.editor.shift = e.pressed;
			}
		});
		
		keyboard.onKeymapChange.bind(function(_, _)
		{
			view.mainMenu.update();
		});
		
		keyboard.onKeyDown.bind(function(_, e)
		{
			if (activeView != null)
			{
				var processed = false;
				
				switch (activeView)
				{
					case ActiveView.LIBRARY:
						//log("key down(3a)");
						processed = processed || e.processShortcut("library");
						processed = processed || e.processShortcut("");
						//log("key down(3a) " + processed);
						
					case ActiveView.TIMELINE:
						//log("key down(3b)");
						processed = processed || e.processShortcut("timeline");
						processed = processed || e.processShortcut("");
						//log("key down(3b) " + processed);
						
					case ActiveView.OUTPUT:
						//log("key down(3c)");
						processed = processed || e.processShortcut("output");
						processed = processed || e.processShortcut("");
						//log("key down(3c) " + processed);
						
					case ActiveView.EDITOR:
						//log("key down(3e)");
						processed = processed || e.processShortcut("");
						//log("key down(3e) " + processed);
				}
			}
		});
		
		return keyboard;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
