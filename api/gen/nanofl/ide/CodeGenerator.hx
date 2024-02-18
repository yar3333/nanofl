package nanofl.ide;

extern class CodeGenerator extends nanofl.ide.InjectContainer {
	static function generate(library:nanofl.ide.library.IdeLibrary, destTsFilePath:String):Void;
}