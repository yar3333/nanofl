package nanofl.ide.filesystem;

extern class CachedFile extends nanofl.ide.InjectContainer {
	function new(libraryDir:String, path:String):Void;
	var text(get, never) : String;
	private function get_text():String;
	var xml(get, never) : htmlparser.HtmlNodeElement;
	private function get_xml():htmlparser.HtmlNodeElement;
	var json(get, never) : Dynamic;
	private function get_json():Dynamic;
	/**
		
			 * Relative file path.
			 
	**/
	var path(default, null) : String;
	/**
		
			 * If true - skip this file.
			 
	**/
	var excluded(default, null) : Bool;
	function exclude():Void;
}