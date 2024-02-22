package nanofl.ide.sys;

@:rtti
interface ProcessManager
{
	function run(filePath:String, args:Array<String>, blocking:Bool, ?directory:String, ?env:Dynamic<String>) : Int;
	function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String) : { exitCode:Int, output:String, error:String };
    function runPipedStdIn(filePath:String, args:Array<String>, directory:String, env:Dynamic<String>, getDataForStdIn:()->js.lib.ArrayBuffer) : js.lib.Promise<ProcessResult>;
}
