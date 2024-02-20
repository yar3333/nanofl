package nanofl.ide;

extern class OpenedFiles {
	var active(get, never) : nanofl.ide.OpenedFile;
	private function get_active():nanofl.ide.OpenedFile;
	var length(get, never) : Int;
	private function get_length():Int;
	function iterator():Iterator<nanofl.ide.OpenedFile>;
	function closeAll(?force:Bool):js.lib.Promise<{ }>;
}