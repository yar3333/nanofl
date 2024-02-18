package nanofl.ide.keyboard;

typedef Commands =
{
	function validateCommand(command:String) : Void;
	function run(command:String, ?params:Array<Dynamic>) : Bool;
}