package nanofl.ide.sys.tools;

import haxe.io.Path;
import stdlib.Debug;
import nanofl.ide.sys.FileSystem;
using StringTools;

class FileSystemTools
{
	public static function findFiles(fileSystem:FileSystem, dirPath:String, ?onFile:String->Void, ?onDir:String->Bool) : Void
    {
		if (fileSystem.exists(dirPath))
		{
			if (fileSystem.isDirectory(dirPath))
			{
				for (file in fileSystem.readDirectory(dirPath))
				{
					if (fileSystem.isDirectory(dirPath + "/" + file))
					{
						if (file != ".svn" && file != ".hg" && file != ".git")
						{
							if (onDir == null || onDir(dirPath + "/" + file))
							{
								findFiles(fileSystem, dirPath + "/" + file, onFile, onDir);
							}
						}
					}
					else
					{
						if (onFile != null) onFile(dirPath + "/" + file);
					}
				}
			}
			else
			{
				if (onFile != null) onFile(dirPath);
			}
		}
    }
	
	public static function findFilesInDirectoriesFilteredByRegex(fileSystem:FileSystem, dirs:String, reFilter:String) : Array<String>
	{
		var re = reFilter != null && reFilter != "" ? new EReg(reFilter, "") : null;
		
		var r = [];
		for (dir in dirs.split(";"))
		{
			findFiles(fileSystem, dir, function(file) if (re == null || re.match(file)) r.push(file));
		}
		return r;
	}
	
	/**
	 * Process each file, matched by oldName pattern (args example: oldName="folderA/myFileNameA.*", newName="folderB/myFileNameB.*").
	 */
	public static function processFilePatternPair(fileSystem:FileSystem, oldName:String, newName:String, callb:String->String->Void)
	{
		Debug.assert(oldName != null);
		Debug.assert(oldName != "");
		Debug.assert(oldName != ".");
		Debug.assert(newName != null);
		Debug.assert(newName != "");
		Debug.assert(newName != ".");
		Debug.assert((!oldName.endsWith(".*") && !newName.endsWith(".*")) || (oldName.endsWith(".*") && newName.endsWith(".*")));
		
		if (oldName.endsWith(".*"))
		{
			callb(Path.withoutExtension(oldName), Path.withoutExtension(newName));
			
			var oldBase = Path.withoutDirectory(Path.withoutExtension(oldName));
			var newBase = Path.withoutDirectory(Path.withoutExtension(newName));
			var oldDir = Path.directory(oldName);
			var newDir = Path.directory(newName);
			if (fileSystem.exists(oldDir))
			{
				for (file in fileSystem.readDirectory(oldDir))
				{
					if (file.startsWith(oldBase + "."))
					{
						callb(oldDir + "/" + file, newDir + "/" + newBase + "." + Path.extension(file));
					}
				}
			}
		}
		else
		{
			callb(oldName, newName);
		}
	}
	
	/**
	 * Process each file, matched by path pattern (path example: "folder/myFileName.*").
	 */
	public static function processFilePattern(fileSystem:FileSystem, path:String, callb:String->Void) : Void
	{
		Debug.assert(path != null);
		Debug.assert(path != "");
		Debug.assert(path != ".");
		
		if (path.endsWith(".*"))
		{
			callb(Path.withoutExtension(path));
			
			var base = Path.withoutDirectory(Path.withoutExtension(path));
			var dir = Path.directory(path);
			if (fileSystem.exists(dir))
			{
				for (file in fileSystem.readDirectory(dir))
				{
					if (file.startsWith(base + "."))
					{
						callb(dir + "/" + file);
					}
				}
			}
		}
		else
		if (path.endsWith("/*") || path.endsWith("\\*") || path.endsWith("/*.*") || path.endsWith("\\*.*"))
		{
			var dir = Path.directory(path);
			if (fileSystem.exists(dir))
			{
				for (file in fileSystem.readDirectory(dir))
				{
					callb(dir + "/" + file);
				}
			}
		}
		else
		{
			callb(path);
		}
	}
	
	public static function absolutePath(fileSystem:FileSystem, relPath:String) : String
	{
		if (Path.isAbsolute(relPath)) return relPath;
		return Path.join([ fileSystem.getCwd(), relPath ]);
	}
	
	public static function deleteDirectoryRecursively(fileSystem:FileSystem, dirPath:String) : Void
	{
        if (fileSystem.exists(dirPath))
        {
            for (file in fileSystem.readDirectory(dirPath))
            {
                fileSystem.deleteAny(dirPath + "/" + file);
            }
        }
	}
	
	public static function deleteAny(fileSystem:FileSystem, path:String) : Void
	{
		if (fileSystem.exists(path))
		{
			if (fileSystem.isDirectory(path))
			{
				deleteDirectoryRecursively(fileSystem, path);
			}
			else
			{
				fileSystem.deleteFile(path);
			}
		}
	}
	
	public static function deleteAnyByPattern(fileSystem:FileSystem, path:String) : Void
	{
		processFilePattern(fileSystem, path, function(path)
		{
			deleteAny(fileSystem, path);
		});
	}
	
	public static function renameByPattern(fileSystem:FileSystem, srcPath:String, destPath:String) : Void
	{
		processFilePatternPair(fileSystem, srcPath, destPath, function(srcPath, destPath)
		{
			if (fileSystem.exists(srcPath))
			{
				log("rename " + srcPath + " => " + destPath);
				fileSystem.rename(srcPath, destPath);
			}
		});
	}
	
	public static function copyAny(fileSystem:FileSystem, srcPath:String, destPath:String) : Void
	{
		log("copyAny " + srcPath + " => " + destPath);
		
		if (fileSystem.isDirectory(srcPath))
		{
			var files = fileSystem.readDirectory(srcPath);
			for (file in files)
			{
				copyAny(fileSystem, srcPath + "/" + file, destPath + "/" + file);
			}
		}
		else
		{
			fileSystem.copyFile(srcPath, destPath);
		}
	}
	
	public static function copyByPattern(fileSystem:FileSystem, srcPath:String, destPath:String) : Void
	{
		processFilePatternPair(fileSystem, srcPath, destPath, function(srcPath, destPath)
		{
			copyAny(fileSystem, srcPath, destPath);
		});
	}
	
	public static function syncDirectory(fileSystem:FileSystem, src:String, dest:String) : Void
	{
		log("syncDirectory " + src + " => " + dest);
		deleteAny(fileSystem, dest);
		copyAny(fileSystem, src, dest);
	}
	
	public static function copyLibraryFiles(fileSystem:FileSystem, srcLibraryDir:String, relativePaths:Array<String>, destLibraryDir:String) : Void
	{
		for (relativePath in relativePaths)
		{
			copyAny(fileSystem, srcLibraryDir + "/" + relativePath, destLibraryDir + "/" + relativePath);
		}
	}
	
	public static function getDocumentLastModified(fileSystem:FileSystem, path:String) : Date
	{
		var r = fileSystem.getLastModified(path);
		
		var libraryDir = Path.join([ Path.directory(path), "library" ]);
		if (fileSystem.exists(libraryDir) && fileSystem.isDirectory(libraryDir))
		{
			r = maxDate(r, fileSystem.getLastModified(libraryDir));
			
			findFiles
			(
				fileSystem,
				libraryDir,
				file -> r = maxDate(r, fileSystem.getLastModified(file)),
				dir -> { r = maxDate(r, fileSystem.getLastModified(dir)); return true; }
			);
		}
		
		return r;
	}
	
	public static function nativePath(fileSystem:FileSystem, path:String) : String
	{
		return path.replace("/", "\\");
	}
	
	static function maxDate(a:Date, b:Date) return a != null ? (a.getTime() > b.getTime() ? a : b) : b;
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}
