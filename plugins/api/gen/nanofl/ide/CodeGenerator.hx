package nanofl.ide;

extern class CodeGenerator extends nanofl.ide.InjectContainer {
	static function generate(projectName:String, library:nanofl.ide.library.IdeLibrary, destDir:String):Void;
}