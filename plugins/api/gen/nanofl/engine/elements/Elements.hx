package nanofl.engine.elements;

extern class Elements {
	static function parse(base:htmlparser.HtmlNodeElement, version:String):Array<nanofl.engine.elements.Element>;
	static function parseJson(obj:Array<Dynamic>, version:String):Array<nanofl.engine.elements.Element>;
	static function expandGroups(elements:datatools.ArrayRO<nanofl.engine.elements.Element>):Array<nanofl.engine.elements.Element>;
	static function getUsedSymbolNamePaths<Element:({ function getUsedSymbolNamePaths():Array<String>; })>(elements:datatools.ArrayRO<Element>):Array<String>;
}