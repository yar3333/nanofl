package nanofl.engine.fills;

extern class BaseFill {
	function setLibrary(library:nanofl.engine.Library):Void;
	static function load(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.fills.IFill;
}