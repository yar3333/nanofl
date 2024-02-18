package htmlparser;

extern class XmlBuilder {
	function new(?indent:String, ?newLine:String):Void;
	var xml : htmlparser.XmlDocument;
	function begin(tag:String, ?attrs:Array<{ public var value(default, default) : Dynamic; public var name(default, default) : String; }>):htmlparser.XmlBuilder;
	function end():htmlparser.XmlBuilder;
	function attr(name:String, value:Dynamic, ?defValue:Dynamic):htmlparser.XmlBuilder;
	function content(s:String):htmlparser.XmlBuilder;
	function toString():String;
}