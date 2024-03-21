package nanofl.ide.sys;

interface ProcessManager {
	function run(filePath:String, args:Array<String>, blocking:Bool, ?directory:String, ?env:Dynamic<String>):Int;
	function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String):nanofl.ide.sys.ProcessResult;
	function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:(process:nanofl.ide.sys.Process) -> js.lib.Promise<js.lib.ArrayBuffer>):js.lib.Promise<nanofl.ide.sys.ProcessResult>;
	function runPipedStdOut(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, input:String, chunkSize:Int, processChunk:(process:nanofl.ide.sys.Process, chunk:js.lib.Uint8Array) -> Void):js.lib.Promise<nanofl.ide.sys.ProcessResult>;
}