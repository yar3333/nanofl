package nanofl.ide.sys;

@:rtti interface ShellRunner {
	function runWithEditor(document:String):Bool;
}