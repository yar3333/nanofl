package htmlparser;

extern class HtmlNode {
	var parent : htmlparser.HtmlNodeElement;
	function remove():Void;
	function getPrevSiblingNode():htmlparser.HtmlNode;
	function getNextSiblingNode():htmlparser.HtmlNode;
	function toString():String;
	function toText():String;
}