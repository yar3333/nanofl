package nanofl.ide.sys.node.core;

import js.lib.Promise;
import js.lib.ArrayBuffer;

interface ProcessUtils
{
    function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:()->ArrayBuffer) : Promise<ProcessResult>;
}