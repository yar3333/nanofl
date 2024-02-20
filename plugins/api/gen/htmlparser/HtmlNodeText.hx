package htmlparser;

extern class HtmlNodeText extends htmlparser.HtmlNode {
	function new(text:String):Void;
	var text : String;
	override function toString():String;
	override function toText():String;
}