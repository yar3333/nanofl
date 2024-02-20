package htmlparser;

extern class CssSelector {
	var type(default, null) : String;
	var tagNameLC(default, null) : String;
	var id(default, null) : String;
	var classes(default, null) : Array<String>;
	var index(default, null) : Int;
	static function parse(selector:String):Array<Array<htmlparser.CssSelector>>;
}