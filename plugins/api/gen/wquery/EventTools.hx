package wquery;

extern class EventTools {
	static function attachHtmlEventHandlers(component:wquery.Component, node:wquery.GenericHtmlElement, ignoreTags:Array<String>):Void;
	static function attachComponentEventHandlers(component:wquery.Component):Void;
}