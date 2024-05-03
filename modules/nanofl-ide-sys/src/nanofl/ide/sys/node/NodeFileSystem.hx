package nanofl.ide.sys.node;

import stdlib.Uuid;
import haxe.io.Bytes;
import haxe.io.Path;
import js.lib.Error;
import nanofl.ide.sys.tools.FileSystemTools;
import nanofl.ide.sys.node.core.ElectronApi;
using nanofl.ide.sys.node.core.NodeBufferTools;
using StringTools;

class NodeFileSystem implements nanofl.ide.sys.FileSystem
{
	public function new() {}
	
	public function getCwd() : String
	{
        return ElectronApi.callMethod("process", "cwd");
	}
	
	public function exists(path:String) : Bool
	{
        return ElectronApi.fs.existsSync(path);
	}
	
	public function rename(oldPath:String, newPath:String) : Void
	{
		log("rename " + oldPath + " => " + newPath);
        ElectronApi.fs.renameSync(oldPath, newPath);
	}
	
	public function isDirectory(path:String) : Bool
	{
		return ElectronApi.fs.statSync(path).mode & ElectronApi.fs.constants.S_IFDIR != 0;
	}
	
	public function createDirectory(path:String) : Void
	{
        try
        {
			ElectronApi.fs.mkdirSync(path);
		}
        catch (e: js.lib.Error)
        {
			if (e.message != null && e.message.startsWith("ENOENT:"))
            {
				createDirectory(Path.directory(path));
				ElectronApi.fs.mkdirSync(path);
			} 
            else
            {
				var stat = try ElectronApi.fs.statSync(path) catch (Dynamic) throw e;
				if (stat.mode & ElectronApi.fs.constants.S_IFDIR == 0) throw(e : Error);
			}
    	}
	}
	
	public function deleteFile(path:String) : Void
	{
        if (exists(path))
        {
            ElectronApi.fs.unlinkSync(path);
        }
	}
	
	public function deleteEmptyDirectory(path:String) : Void
	{
        if (exists(path))
        {
			ElectronApi.fs.rmdirSync(path);
		}
	}
	
	public function readDirectory(path:String) : Array<String>
	{
        return ElectronApi.fs.readdirSync(path);
	}
	
	public function getContent(filePath:String) : String
	{
        return ElectronApi.fs.readFileSync(filePath, {encoding: "utf8"});
	}
	
	public function saveContent(filePath:String, text:String, ?append:Bool) : Void
	{
		var dir = Path.directory(filePath);
		if (dir != "") createDirectory(dir);
		
		if (!append) ElectronApi.fs.writeFileSync(filePath, text);
		else         ElectronApi.fs.writeFileSync(filePath, text, { flag:AppendCreate });
	}
	
	public function getBinary(filePath:String) : haxe.io.Bytes
	{
        return ElectronApi.fs.readFileSync(filePath).toBytes();
	}
	
	public function saveBinary(filePath:String, data:haxe.io.Bytes) : Void
	{
		var dir = Path.directory(filePath);
		if (dir != "") createDirectory(dir);
		
        ElectronApi.fs.writeFileSync(filePath, data.toBuffer());
	}
	
	public function getLastModified(path:String) : Date
	{
		return ElectronApi.fs.statSync(path).mtime;
	}
	
	public function getSize(path:String) : Int
	{
		return (cast ElectronApi.fs).statSync(path).size;
	}
	
    public function copyFile(srcPath:String, dstPath:String) : Void
	{
		log("copy " + srcPath + " => " + dstPath);
		
		var destDir = Path.directory(dstPath);
		if (destDir != "") createDirectory(destDir);
		
        (cast ElectronApi.fs).copyFileSync(srcPath, dstPath);
	}

    public function getTempFilePath(?extensionPrefixedWithDot:String) : String
    {
        return ElectronApi.getEnvVar("temp") + "/nanofl/" + Uuid.newUuid() + (extensionPrefixedWithDot ?? "");
    }
	
	////////////////////////////////////////////////////////////////////////
	
	public function findFiles(dirPath:String, ?onFile:String -> Void, ?onDir:String -> Bool) : Void
	{
		FileSystemTools.findFiles(this, dirPath, onFile, onDir);
	}
	
	public function findFilesInDirectoriesFilteredByRegex(dirs:String, reFilter:String) : Array<String>
	{
		return FileSystemTools.findFilesInDirectoriesFilteredByRegex(this, dirs, reFilter);
	}
	
	public function processFilePatternPair(oldName:String, newName:String, callb:String -> String -> Void) : Void
	{
		FileSystemTools.processFilePatternPair(this, oldName, newName, callb);
	}
	
	public function processFilePattern(path:String, callb:String -> Void) : Void
	{
		FileSystemTools.processFilePattern(this, path, callb);
	}
	
	public function absolutePath(relPath:String) : String
	{
		return FileSystemTools.absolutePath(this, relPath);
	}
	
	public function deleteDirectoryRecursively(dirPath:String) : Void
	{
		FileSystemTools.deleteDirectoryRecursively(this, dirPath);
	}
	
	public function deleteAny(path:String) : Void
	{
		return FileSystemTools.deleteAny(this, path);
	}
	
	public function deleteAnyByPattern(path:String) : Void
	{
		return FileSystemTools.deleteAnyByPattern(this, path);
	}
	
	public function renameByPattern(srcPath:String, destPath:String) : Void
	{
		FileSystemTools.renameByPattern(this, srcPath, destPath);
	}
	
	public function copyAny(srcPath:String, destPath:String) : Void
	{
		FileSystemTools.copyAny(this, srcPath, destPath);
	}
	
	public function copyByPattern(srcPath:String, destPath:String) : Void
	{
		FileSystemTools.copyByPattern(this, srcPath, destPath);
	}
	
	public function syncDirectory(src:String, dest:String) : Void
	{
		FileSystemTools.syncDirectory(this, src, dest);
	}
	
	public function copyLibraryFiles(srcLibraryDir:String, relativePaths:Array<String>, destLibraryDir:String) : Void
	{
		FileSystemTools.copyLibraryFiles(this, srcLibraryDir, relativePaths, destLibraryDir);
	}
	
	public function getDocumentLastModified(path:String) : Date
	{
		return FileSystemTools.getDocumentLastModified(this, path);
	}
	
	public function nativePath(path:String) : String
	{
		return FileSystemTools.nativePath(this, path);
	}
	
	////////////////////////////////////////////////////////////////////////

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}