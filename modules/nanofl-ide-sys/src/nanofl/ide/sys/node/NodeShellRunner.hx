package nanofl.ide.sys.node;

import haxe.io.Path;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.ShellRunner;
import nanofl.ide.sys.Environment;
import nanofl.ide.sys.node.core.NodeWindowsRegistry;
import nanofl.ide.sys.node.core.ElectronApi;

class NodeShellRunner implements ShellRunner
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
	
	public function runWithEditor(document:String) : Bool
	{
		var winReg = new NodeWindowsRegistry(ElectronApi.child_process.execSync);
        
        var docType = winReg.getKeyValue("HKCR:\\." + Path.extension(document));
		log("docType = " + docType);
		if (docType == null) return false;
		
		var command = winReg.getKeyValue("HKCR:\\" + docType + "\\shell\\edit\\command");
		log("command(1) = " + command);
		
		if (command == null)
		{
			command = winReg.getKeyValue("HKCR:\\" + docType + "\\shell\\open\\command");
			log("command(2) = " + command);
		}
		
		if (command == null) return false;
		
		var exeAndArgs = parseCommand(command);
		for (i in 0...exeAndArgs.length)
		{
			if (exeAndArgs[i] == "%1") exeAndArgs[i] = fileSystem.absolutePath(document);
		}
		
		log("exeAndArgs = vvvvvvvvvvvv\n" + exeAndArgs.join("\n") + "\n^^^^^^^^^^^^");
		
		return processManager.run(exeAndArgs[0], exeAndArgs.slice(1), false) == 0;
	}
	
	@:noapi
	function parseCommand(command:String) : Array<String>
	{
		command = ~/%([a-zA-Z0-9]+)%/g.map(command, function(re)
		{
			return environment.get(re.matched(1));
		});
		
		var r = [];
		~/"([^"]+?)"|([^ \t]+)/g.map(command, function(re)
		{
			if (re.matched(1) != null && re.matched(1) != "") r.push(re.matched(1));
			else r.push(re.matched(2));
			return re.matched(0);
		});
		return r;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}