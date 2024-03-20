package nanofl.ide.sys;

@:rtti interface Shell {
	function openInExternalBrowser(url:String):Void;
	function showInFileExplorer(path:String):Void;
	function openInAssociatedApplication(path:String):Void;
}