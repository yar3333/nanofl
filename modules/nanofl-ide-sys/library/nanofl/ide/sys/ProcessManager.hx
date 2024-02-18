package nanofl.ide.sys;

@:rtti interface ProcessManager {
	function run(filePath:String, args:Array<String>, blocking:Bool, ?directory:String, ?env:Dynamic<String>):Int;
	function runCaptured(filePath:String, args:Array<String>, ?directory:String, ?env:Dynamic<String>, ?input:String):{ var error : String; var exitCode : Int; var output : String; };
}