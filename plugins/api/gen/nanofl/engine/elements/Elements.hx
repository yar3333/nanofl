package nanofl.engine.elements;

extern class Elements {
	static function parse(base:htmlparser.HtmlNodeElement, version:String):Array<nanofl.engine.elements.Element>;
	static function parseJson(obj:Array<Dynamic>, version:String):Array<nanofl.engine.elements.Element>;
	static function getUsedSymbolNamePaths(elements:Array<nanofl.engine.elements.Element>):js.lib.Set<String>;
}