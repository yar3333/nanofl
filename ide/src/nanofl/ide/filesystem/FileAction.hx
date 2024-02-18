package nanofl.ide.filesystem;

enum FileAction
{
	REMOVE_LIBRARY_ITEMS(namePaths:Array<String>);
	RENAME_LIBRARY_ITEM(oldNamePath:String, newNamePath:String);
}