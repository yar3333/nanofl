package nanofl.ide;

extern class HtmlElementTools {
	static function hasClass(elem:js.html.Element, className:String):Bool;
	static function addClass(elem:js.html.Element, className:String):js.html.Element;
	static function removeClass(elem:js.html.Element, className:String):js.html.Element;
	static function toggleClass(elem:js.html.Element, className:String, ?b:Bool):js.html.Element;
}