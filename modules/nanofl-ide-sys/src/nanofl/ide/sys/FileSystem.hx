package nanofl.ide.sys;

@:rtti
interface FileSystem
{
	function getCwd() : String;
	
	function exists(path:String) : Bool;
	function rename(oldPath:String, newPath:String) : Void;
	function isDirectory(path:String) : Bool;
	function createDirectory(dirPath:String) : Void;
	function deleteFile(path:String) : Void;
	function deleteEmptyDirectory(dirPath:String) : Void;
	function deleteDirectoryRecursively(dirPath:String) : Void;
	function readDirectory(dirPath:String) : Array<String>;
	
	function getContent(filePath:String) : String;
	function saveContent(filePath:String, text:String, ?append:Bool) : Void;
	
	function getBinary(filePath:String) : haxe.io.Bytes;
	function saveBinary(filePath:String, data:haxe.io.Bytes) : Void;
	
	function getLastModified(path:String) : Date;
	function getSize(path:String) : Int;
	
	function copyFile(srcPath:String, destPath:String) : Void;

    function getTempFilePath(?extensionPrefixedWithDot:String) : String;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	function findFiles(dirPath:String, ?onFile:String->Void, ?onDir:String->Bool) : Void;
	function findFilesInDirectoriesFilteredByRegex(dirs:String, reFilter:String) : Array<String>;
	/**
	 * Process each file, matched by oldName pattern (args example: oldName="folderA/myFileNameA.*", newName="folderB/myFileNameB.*").
	 */
	function processFilePatternPair(oldName:String, newName:String, callb:String->String->Void) : Void;
	/**
	 * Process each file, matched by path pattern (path example: "folder/myFileName.*").
	 */
	function processFilePattern(path:String, callb:String->Void) : Void;
	function absolutePath(relPath:String) : String;
	function deleteAny(path:String) : Void;
	function deleteAnyByPattern(path:String) : Void;
	function renameByPattern(srcPath:String, destPath:String) : Void;
	function copyAny(srcPath:String, destPath:String) : Void;
	function copyByPattern(srcPath:String, destPath:String) : Void;
	function syncDirectory(src:String, dest:String) : Void;
	function copyLibraryFiles(srcLibraryDir:String, relativePaths:Array<String>, destLibraryDir:String) : Void;
	function getDocumentLastModified(path:String) : Date;
	function nativePath(path:String) : String;
}
