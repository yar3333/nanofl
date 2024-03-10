package nanofl.ide;

extern class Application extends js.injecting.InjectContainer {
	var activeView : nanofl.ide.ActiveView;
	var document(get, never) : nanofl.ide.Document;
	private function get_document():nanofl.ide.Document;
	var pid : String;
	function createNewEmptyDocument(?callb:nanofl.ide.Document -> Void):Void;
	function openDocument(?path:String):js.lib.Promise<nanofl.ide.Document>;
	function importDocument(?path:String, ?plugin:nanofl.ide.plugins.IImporterPlugin):js.lib.Promise<nanofl.ide.Document>;
	function quit(?force:Bool, ?exitCode:Int):Void;
}