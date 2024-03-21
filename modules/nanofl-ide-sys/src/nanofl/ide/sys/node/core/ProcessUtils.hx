package nanofl.ide.sys.node.core;

import js.lib.Promise;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;

interface ProcessUtils
{
    function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:(process:Process)->Promise<ArrayBuffer>) : Promise<ProcessResult>;
    function runPipedStdOut(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, input:String, chunkSize:Int, processChunk:(process:Process, chunk:Uint8Array)->Void) : Promise<ProcessResult>;
}