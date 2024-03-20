package nanofl.ide.libraryitems;

import nanofl.ide.sys.FileSystem;
import nanofl.ide.plugins.LoaderPlugins;
using stdlib.Lambda; 

class LibraryItemTools
{
    public static function getFilePathToRunInExternalEditor(fileSystem:FileSystem, libraryDir:String, namePath:String) : String
    {
        for (plugin in LoaderPlugins.plugins.sorted((a, b) -> b.priority - a.priority).filter(x -> x.extensions != null))
        {
            for (ext in plugin.extensions)
            {
                final r = libraryDir + "/" + namePath + "." + ext;
                if (fileSystem.exists(r) && !fileSystem.isDirectory(r)) return r;
            }
        }
        return null;
    }
}