package htmlparser;

extern class HtmlParser {
	function parse(str:String, ?tolerant:Bool):Array<htmlparser.HtmlNode>;
	static var SELF_CLOSING_TAGS_HTML(default, null) : Dynamic;
	static function run(str:String, ?tolerant:Bool):Array<htmlparser.HtmlNode>;
}