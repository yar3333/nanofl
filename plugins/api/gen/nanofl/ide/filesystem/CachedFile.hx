package nanofl.ide.filesystem;

extern class CachedFile extends nanofl.ide.InjectContainer {
	function new(libraryDir:String, relativePath:String):Void;
	var text(get, never) : String;
	private function get_text():String;
	var xml(get, never) : htmlparser.HtmlNodeElement;
	private function get_xml():htmlparser.HtmlNodeElement;
	var json(get, never) : Dynamic;
	private function get_json():Dynamic;
	var relativePath(default, null) : String;
}