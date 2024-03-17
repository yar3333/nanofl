package nanofl.ide.sys.node;

import haxe.io.Bytes;
import js.lib.Uint8Array;
import js.lib.ArrayBuffer;
import js.lib.Promise;
import js.node.ChildProcess;
import nanofl.ide.sys.node.core.ElectronApi;

class NodeProcessManager implements nanofl.ide.sys.ProcessManager
{
	public function new() {}
	
	public function run(filePath:String, args:Array<String>, blocking:Bool, ?directory:String, ?env:Dynamic<String>) : Int
	{
		if (blocking)
		{
			var options : ChildProcessSpawnSyncOptions = {};
			if (directory != null) options.cwd = directory;
			if (env != null) options.env = env;
			return ElectronApi.child_process.spawnSync(filePath, args, options).status;
		}
		else
		{
			var options : ChildProcessSpawnOptions = {};
			if (directory != null) options.cwd = directory;
			if (env != null) options.env = env;
			options.detached = true;
			
			try ElectronApi.child_process.spawn(filePath, args, options)
			catch (_:Dynamic) return 1;
			
			return 0;
		}
	}
	
	public function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String) : ProcessResult
	{
		var options : ChildProcessSpawnSyncOptions = {};
		if (directory != null) options.cwd = directory;
		if (env != null) options.env = env;
		if (input != null) options.input = input;
		
		log("ChildProcess.spawnSync " + filePath + (directory != null ? " in dir '" + directory + "'" : "")  + args.map(s -> "\n\t" + s).join(""));
		var result = ElectronApi.child_process.spawnSync(filePath, args, options);
		
		log(result);
		
		return
		{
			code: result.status, 
			out: Bytes.ofData((cast result.stdout : Uint8Array).buffer).toString(),
			err: Bytes.ofData((cast result.stderr : Uint8Array).buffer).toString(),
		};
	}

    public function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:()->Promise<ArrayBuffer>) : Promise<ProcessResult>
    {
        return ElectronApi.process_utils.runPipedStdIn(filePath, args, directory, env, getDataForStdIn);
    }

    public function runPipedStdOut(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, input:String, chunkSize:Int, processChunk:Uint8Array->Void) : Promise<ProcessResult>
    {
        return ElectronApi.process_utils.runPipedStdOut(filePath, args, directory, env, input, chunkSize, processChunk);
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}
