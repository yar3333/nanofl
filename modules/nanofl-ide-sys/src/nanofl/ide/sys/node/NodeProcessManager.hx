package nanofl.ide.sys.node;

import stdlib.Debug;
import js.lib.Uint8Array;
import js.node.Buffer;
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
			out: (cast result.stdout : NodeBuffer).toString(),
			err: (cast result.stderr : NodeBuffer).toString()
		};
	}

    public function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:()->Promise<ArrayBuffer>) : Promise<ProcessResult>
    {
        return ElectronApi.process_utils.runPipedStdIn(filePath, args, directory, env, getDataForStdIn);
    }

    public function runPipedStdOut(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, input:String, chunkSize:Int, processChunk:Uint8Array->Void) : Promise<ProcessResult>
    {
		var options : ChildProcessSpawnOptions = {};
		if (directory != null) options.cwd = directory;
		if (env != null) options.env = env;
		
		log("ChildProcess.spawn " + filePath + (directory != null ? " in dir '" + directory + "'" : "")  + args.map(s -> "\n\t" + s).join(""));
		final process = ElectronApi.child_process.spawn(filePath, args, options);

        final buffer = chunkSize >= 0 ? new Uint8Array(chunkSize) : null;
        var bufferFilled = 0;
		
        return new Promise<ProcessResult>((resolve, reject) ->
        {
            var outStr = "";
            var errStr = "";

            if (process.stdout == null) { reject("process.stdout is null"); return; }
            if (process.stderr == null) { reject("process.stderr is null"); return; }
    
            process.stdout.on('data', (data:Buffer) ->
            {
                if (buffer == null) { processChunk(data); return; }

                if (data.byteLength >= chunkSize - bufferFilled)
                {
                    Debug.assert(data.byteOffset == 0);

                    final bytesToCopy = chunkSize - bufferFilled;
                    data.copy(buffer, bufferFilled, 0, bytesToCopy);
                    processChunk(buffer);
                    data.copy(buffer, 0, bytesToCopy, data.byteLength); // TODO: (data.byteLength - bytesToCopy) can be greater than buffer.size
                    bufferFilled = data.byteLength - bytesToCopy;
                }
                else
                {
                }

                outStr += data.toString();
            });
                
            process.stderr.on('data', (data:Buffer) ->
            {
                errStr += data.toString();
            });
                
            process.on('close', code ->
            {
                resolve({ code:code, out:outStr, err:errStr });
            });         
            
            process.on('error', code ->
            {
                reject({ code:code, out:outStr, err:errStr });
            });

            if (process.stdin == null) { reject("process.stdin is null"); return; }

       		if (input != null) process.stdin.write(input);
        });
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}
