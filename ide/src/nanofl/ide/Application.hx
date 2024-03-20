package nanofl.ide;

import haxe.io.Path;
import js.lib.Promise;
import js.Browser;
import js.JQuery;
import js.injecting.Injector;
import stdlib.Uuid;
import nanofl.ide.sys.FileSystem;
import nanofl.engine.Version;
import nanofl.engine.Log;
import nanofl.engine.Log.console;
import nanofl.ide.commands.Commands;
import nanofl.ide.editor.NewObjectParams;
import nanofl.ide.filesystem.ExternalChangesDetector;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.keyboard.WhenVars;
import nanofl.ide.plugins.IImporterPlugin;
import nanofl.ide.plugins.Importer;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.plugins.Plugins;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.preferences.PreferencesStorage;
import nanofl.ide.sys.Folders;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
using stdlib.Lambda;
using stdlib.StringTools;
using nanofl.ide.plugins.CustomizablePluginTools;

class Application extends js.injecting.InjectContainer
{
	@inject var fileSystem : FileSystem;
	@inject var folders : Folders;
	
	final view : View;
	final popups : Popups;
	final openedFiles : OpenedFiles;
    
    final preferences : Preferences;
	final recents : Recents;
    final documentTools : DocumentTools;
	
	@:noCompletion var _activeView = ActiveView.EDITOR;
    public var activeView(get, set) : ActiveView;
    @:noCompletion function get_activeView() return _activeView;
    @:noCompletion function set_activeView(v)
    {
        log("activeView: " + _activeView + " -> " + v);
        return _activeView = v;
    }
	
	public var document(get, never) : Document;
	function get_document() return openedFiles?.active;
	
	public var pid : String;
	
	@:noapi
	public function new(injector:Injector)
	{
		super(injector);
		
		injector.addSingleton(Commands);
		injector.addSingleton(Application, this);
		injector.addSingleton(Keyboard, createKeyboard(injector.getService(Commands)));
		injector.addSingleton(PreferencesStorage);
		injector.addSingleton(Preferences);
		injector.addSingleton(NewObjectParams);
		injector.addSingleton(Clipboard);
		injector.addSingleton(Recents);
		injector.addSingleton(OpenedFiles);
        injector.addSingleton(DocumentTools);
        injector.addSingleton(ExternalChangesDetector);
		injector.addSingleton(Plugins);
		
		wquery.Template.baseURL = "../../";
		wquery.Application.run("page", components.nanofl.page.Code, { injector:injector });
		
        this.view = injector.getService(View);
		this.popups = injector.getService(Popups);
		this.openedFiles = injector.getService(OpenedFiles);
	
		Log.init(fileSystem, view.alerter);
		
		new JQuery(Browser.window).resize();
		new JQuery(Browser.document.body).focus();
		
		new JQuery(Browser.window).on("close", e -> { e.preventDefault(); quit(); });
		
        final clipboard = injector.getService(Clipboard);
		view.movie.editor  .on("mousedown", e -> { activeView = ActiveView.EDITOR;   clipboard.restoreFocus(e.originalEvent); });
		view.movie.timeline.on("mousedown", e -> { activeView = ActiveView.TIMELINE; clipboard.restoreFocus(e.originalEvent); });
		view.movie.timeline.on("mousedown", e -> { activeView = ActiveView.TIMELINE; clipboard.restoreFocus(e.originalEvent); });
		view.library       .on("mousedown", e -> { activeView = ActiveView.LIBRARY;  clipboard.restoreFocus(e.originalEvent); });
		view.output        .on("mousedown", e -> { activeView = ActiveView.OUTPUT; });
		
		this.preferences = injector.getService(Preferences);
        preferences.storage.applyToIDE(true);

        this.recents = injector.getService(Recents);
        
        this.documentTools = injector.getService(DocumentTools);
		
		Log.onMessage.bind((_, e) ->
		{
			if      (e.type == "warn")  view.output.writeWarning(e.message);
			else if (e.type == "error") view.output.writeError(e.message);
			else                        view.output.writeInfo(e.message);
		});
		
        injector.getService(Plugins).reload(false)
            .then(_ -> CommandLine.process())
            //.then(_ -> checkForUpdates())
            .then(_ -> injector.getService(ExternalChangesDetector).start());
	}
	
	public function createNewEmptyDocument(?width:Int, ?height:Int, ?framerate:Float) : Document
	{
		var properties = new DocumentProperties("", width, height, "#FFFFFF", framerate);
		
		var document = documentTools.createTemporary(properties);
		document.library.getRawLibrary().addSceneWithFrame();
		document.activate(true);
		return document;
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
			
			return popups.showOpenFile("Select NanoFL document to open", filters).then(filePath ->
            {
                return filePath != null ? openDocument(filePath) : null;
            });
		}
		else
		{
			path = Path.normalize(path);
			recents.add(path, view);
            return documentTools.load(path).then(document ->
            {
                if (document != null) document.activate();
                return document;
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
            .then(filePath ->
            {
                return filePath != null ? importDocument(filePath, plugin) : null;
            });
		}
		else
		{
			final importer = plugin != null ? new Importer(plugin.name, plugin.getParams(preferences.storage)) : null;
			return documentTools.import_(path, importer);
		}
	}
	
	public function quit(force=false, exitCode=0) : Void
	{
		if (!force)
		{
			openedFiles.closeAll().then(_ -> exit(exitCode));
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
	
	function createKeyboard(commands:Commands) : Keyboard
	{
		var keyboard = new Keyboard(commands);
		
		keyboard.onCtrlButtonChange.bind((_, e) ->
		{
			if (document != null)
			{
				document.editor.magnet = e.pressed;
			}
		});
		
		keyboard.onShiftButtonChange.bind((_, e) ->
		{
			if (document != null)
			{
				document.editor.shift = e.pressed;
			}
		});
		
		keyboard.onKeymapChange.bind((_, _) ->
		{
			view.mainMenu.update();
		});
		
		keyboard.onKeyDown.bind((_, e) ->
		{
			if (activeView == null) return;

            final whenVars : WhenVars =
            {
                editor:
                {
                    hasSelected: document?.editor.hasSelected() 
                },
                
                library:
                {
                    selectedCount: document.library.getSelectedItems().length
                },
            };
			
            switch (activeView)
            {
                case ActiveView.LIBRARY:
                    e.processShortcut("library", whenVars) || e.processShortcut("", whenVars);
                    
                case ActiveView.TIMELINE:
                    e.processShortcut("timeline", whenVars) || e.processShortcut("", whenVars);
                    
                case ActiveView.OUTPUT:
                    e.processShortcut("output", whenVars) || e.processShortcut("", whenVars);
                    
                case ActiveView.EDITOR:
                    e.processShortcut("", whenVars);
            }
		});
		
		return keyboard;
	}
	
	static function log(v:Dynamic)
	{
		//trace(Reflect.isFunction(v) ? v() : v);
	}
}
