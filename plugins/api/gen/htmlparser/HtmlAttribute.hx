package htmlparser;

extern class HtmlAttribute {
	function new(name:String, value:String, quote:String):Void;
	var name : String;
	var value : String;
	var quote : String;
	function toString():String;
}