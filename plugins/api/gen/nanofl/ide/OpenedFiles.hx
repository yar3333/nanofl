package nanofl.ide;

extern class OpenedFiles extends nanofl.ide.InjectContainer {
	function new():Void;
	var active(get, never) : nanofl.ide.Document;
	private function get_active():nanofl.ide.Document;
	var length(get, never) : Int;
	private function get_length():Int;
	function iterator():Iterator<nanofl.ide.Document>;
	function closeAll(?force:Bool):js.lib.Promise<{ }>;
	function add(doc:nanofl.ide.Document):Void;
	function close(doc:nanofl.ide.Document):Void;
	function activate(id:String):Void;
	function titleChanged(doc:nanofl.ide.Document):Void;
}