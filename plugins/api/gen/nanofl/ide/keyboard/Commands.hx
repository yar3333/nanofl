package nanofl.ide.keyboard;

typedef Commands = {
	function run(command:String, ?params:Array<Dynamic>):Bool;
	function validateCommand(command:String):Void;
};