package nanofl.ide.sys;

import js.lib.Promise;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;

@:rtti
interface ProcessManager
{
	function run(filePath:String, args:Array<String>, blocking:Bool, ?directory:String, ?env:Dynamic<String>) : Int;
	function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String) : ProcessResult;
    function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:(process:Process)->Promise<ArrayBuffer>) : Promise<ProcessResult>;
    function runPipedStdOut(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, input:String, chunkSize:Int, processChunk:(process:Process, chunk:Uint8Array)->Void) : Promise<ProcessResult>;
}
