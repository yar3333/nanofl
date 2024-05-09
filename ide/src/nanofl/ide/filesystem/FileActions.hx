package nanofl.ide.filesystem;

import haxe.io.Path;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.filesystem.FileAction;
import nanofl.ide.undo.document.Operation;

class FileActions
{
	public static function process(fileSystem:FileSystem, path:String, actions:Array<FileAction>) 
	{
		log("process");
		
		final libraryDir = Path.directory(path) + "/library";
		
		for (action in actions)
		{
			switch (action)
			{
				case FileAction.REMOVE_LIBRARY_ITEMS(namePaths):
					log("*   REMOVE_LIBRARY_ITEMS " + namePaths);
					for (namePath in namePaths)
					{
						fileSystem.deleteAnyByPattern(libraryDir + "/" + namePath + ".*");
					}
					
				case FileAction.RENAME_LIBRARY_ITEM(oldNamePath, newNamePath):
					log("*   RENAME_LIBRARY_ITEM " + oldNamePath + " => " + newNamePath);
					fileSystem.renameByPattern(libraryDir + "/" + oldNamePath + ".*", libraryDir + "/" + newNamePath + ".*");
			}
		}
	}
	
	public static function fromUndoOperations(operations:Array<Operation>) : Array<FileAction>
	{
		log("fromUndoOperations " + operations.length);
		
		final actions = [];
		
		for (op in operations)
		{
			switch (op)
			{
				case Operation.LIBRARY_REMOVE_ITEMS(oldLibraryState, newLibraryState):
					final removedItemNamePaths = oldLibraryState.map(item -> item.namePath);
					for (item in newLibraryState) removedItemNamePaths.remove(item.namePath);
					actions.push(FileAction.REMOVE_LIBRARY_ITEMS(removedItemNamePaths));
					
				case Operation.LIBRARY_RENAME_ITEMS(_, _, itemRenames):
					for (t in itemRenames)
					{
						actions.push(FileAction.RENAME_LIBRARY_ITEM(t.oldNamePath, t.newNamePath));
					}
					
				case Operation.DOCUMENT(_, _),
					 Operation.TIMELINE(_, _, _),
					 Operation.ELEMENTS(_, _, _),
					 Operation.ELEMENT(_, _, _, _),
					 Operation.FIGURE(_, _, _),
					 Operation.TRANSFORMATIONS(_, _, _),
					 Operation.LIBRARY_ADD_ITEMS(_, _),
					 Operation.LIBRARY_CHANGE_ITEMS(_, _):
					// nothing to do
			}
		}
		
		return actions;
	}
	
	static function log(v:Dynamic)
	{
		nanofl.engine.Log.console.namedLog("FileActions", v);
	}
}
