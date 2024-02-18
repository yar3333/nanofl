package nanofl.ide.ui.views;

import js.JQuery.JqEvent;

interface IOutputView 
{
	function writeInfo(message:String) : Void;
	function writeError(message:String) : Void;
	function writeWarning(message:String) : Void;
	
	function writeCompileError(file:String, line:Int, startCh:Int, endCh:Int, message:String) : Void;
	
	function clear() : Void;
	
	function activate() : Void;
	
	function show() : Void;
	function hide() : Void;
	
	function resize(maxWidth:Int, maxHeight:Int) : Void;
	function on(event:String, callb:JqEvent->Void) : Void;
	function hasSelected() : Bool;
	function getSelectedText() : String;
}