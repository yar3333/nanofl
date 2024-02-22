package nanofl.ide.sys.node;

import js.lib.ArrayBuffer;
import js.lib.Promise;
import js.node.ChildProcess;
import nanofl.ide.sys.node.core.NodeBuffer;
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
	
	public function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String) : { exitCode:Int, output:String, error:String }
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
			exitCode: result.status, 
			output: (cast result.stdout : NodeBuffer).toString(),
			error: (cast result.stderr : NodeBuffer).toString()
		};
	}

    public function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:()->ArrayBuffer) : Promise<ProcessResult>
    {
        var options : ChildProcessSpawnOptions = { stdio: ChildProcessSpawnOptionsStdioSimple.Pipe };
        if (directory != null) options.cwd = directory;
        if (env != null) options.env = env;
        
        var process = ElectronApi.child_process.spawn(filePath, args, options);

        return new Promise<ProcessResult>((resolve, reject) ->
        {
            var outStr = "";
            var errStr = "";
    
            process.stdout.on('data', data ->
            {
                outStr += Std.string(data);
            });
                
            process.stderr.on('data', data ->
            {
                errStr += Std.string(data);
            });
                
            process.on('close', code ->
            {
                resolve({ code:code, out:outStr, err:errStr });
            });         
            
            process.on('error', code ->
            {
                reject({ code:code, out:outStr, err:errStr });
            });

            function sendNextChunk()
            {
                while (true)
                {
                    final data = getDataForStdIn();
                    if (data == null)
                    {
                        process.stdin.end();
                        break;
                    }
                    if (!process.stdin.write(ElectronApi.createBuffer(data, null, null)))
                    {
                        process.stdin.once("drain", () -> sendNextChunk());
                        break;
                    }
                }
            }

            sendNextChunk();
        });
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}
