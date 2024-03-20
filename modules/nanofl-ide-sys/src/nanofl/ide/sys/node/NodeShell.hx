package nanofl.ide.sys.node;

import js.lib.Map;
import haxe.io.Path;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Shell;
import nanofl.ide.sys.Environment;
import nanofl.ide.sys.node.core.NodeWindowsRegistry;
import nanofl.ide.sys.node.core.ElectronApi;
using stdlib.StringTools;
using stdlib.Lambda;

class NodeShell implements Shell
{
	var fileSystem : FileSystem;
	var processManager : ProcessManager;
	var environment : Environment;
	
	public function new(fileSystem:FileSystem, processManager:ProcessManager, environment:Environment)
	{
		this.fileSystem = fileSystem;
		this.processManager = processManager;
		this.environment = environment;
	}

	public function openInExternalBrowser(url:String) : Void
    {
        log("openInExternalBrowser: url = " + url);
        js.Browser.window.open(url, "_blank");
    }
    
    public function showInFileExplorer(path:String) : Void
    {
        log("showInFileExplorer: path = " + path);
        
        // See https://ss64.com/nt/explorer.html
        final arg = "/select," + path.replace("/", "\\");
        log("explorer.exe " + arg);
        ElectronApi.child_process.spawn("explorer.exe", [ arg ], { detached:true, shell:"cmd.exe" });
    }
	
    public function openInAssociatedApplication(path:String) : Void
    {
        //return runShellVerb(path, "edit") || runShellVerb(path, "open");
        
        log("openInAssociatedApplication " + path);
        final arg = path.replace("/", "\\");
        ElectronApi.child_process.spawn("start", [ '""', '"' + arg + '"' ], { detached:true, shell:"cmd.exe" });
    }
	
	/**
        Run file with associated application (read from Windows Registry).
        `verb`: "edit" or "open".
    **/
    function runShellVerb(path:String, verb:String) : Bool
	{
		final association = getShellVerbAssociation(Path.extension(path), verb);
        if (association == null) return false;

        final args = association.args.map(x -> x == "%1" ? fileSystem.absolutePath(path) : x);
		return processManager.run(association.program, args, false) == 0;
	}
    
    function getShellVerbAssociation(ext:String, verb:String) : { program:String, args:Array<String> }
    {
        static final cache = new Map<String, { program:String, args:Array<String> }>();

        final key = ext + "|" + verb;
        if (!cache.has(key)) cache.set(key, getShellVerbAssociationInner(ext, verb));
        return cache.get(key);
    }

    function getShellVerbAssociationInner(ext:String, verb:String) : { program:String, args:Array<String> }
    {
        if (ext == null || ext == "") return null;

		final winReg = new NodeWindowsRegistry((command, ?options) -> ElectronApi.child_process.execSync(command, options));
        
        final docType = winReg.getValue("HKCR:\\." + ext);
		log("docType = " + docType);
		if (docType == null) return null;
		
		var command = winReg.getValue("HKCR:\\" + docType + "\\shell\\" + verb + "\\command");
		log("command = " + command);
        if (command == null || command == "") return null;
		
		command = ~/%([a-zA-Z0-9]+)%/g.map(command, re -> environment.get(re.matched(1)));
		
		final programAndArgs = [];
		~/"([^"]+?)"|([^ \t]+)/g.map(command, re ->
		{
			programAndArgs.push(!StringTools.isNullOrEmpty(re.matched(1)) ? re.matched(1) : re.matched(2));
			return re.matched(0);
		});

        if (programAndArgs.length < 2) return null;
		
        return { program:programAndArgs[0], args:programAndArgs.slice(1) };
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}