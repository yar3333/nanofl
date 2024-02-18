package nanofl.ide.sys.node;

import stdlib.Uuid;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.sys.FileSystem;

class NodeZip implements nanofl.ide.sys.Zip
{
	var fileSystem : FileSystem;
	var processManager : ProcessManager;
	var folders : Folders;
	
	public function new(fileSystem:FileSystem, processManager:ProcessManager, folders:Folders)
	{
		this.fileSystem = fileSystem;
		this.processManager = processManager;
		this.folders = folders;
	}
	
	public function compress(srcDir:String, destZip:String, ?relFilePaths:Array<String>) : Bool
	{
		if (relFilePaths == null)
		{
			return processManager.run(folders.tools + "/zip.exe", [ "-r", fileSystem.absolutePath(destZip), "." ], true, srcDir) == 0;
		}
		else
		{
			var tempDir = folders.temp + "/" + Uuid.newUuid();
			
			fileSystem.findFiles
			(
				srcDir,
				function(file:String) : Void
				{
					if (relFilePaths == null || relFilePaths.indexOf(file.substring(srcDir.length + 1)) >= 0)
					{
						fileSystem.copyFile(file, tempDir + "/" + file.substring(srcDir.length + 1));
					}
				},
				function(dir:String) : Bool
				{
					fileSystem.createDirectory(tempDir + "/" + dir.substring(srcDir.length + 1));
					return true;
				}
			);
			
			var r = compress(tempDir, destZip);
			if (r) fileSystem.deleteAny(tempDir);
			return r;
		}
	}
	
	public function decompress(srcZip:String, destDir:String, ?elevated:Bool) : Bool
	{
		srcZip = fileSystem.nativePath(srcZip);
		destDir = fileSystem.nativePath(destDir);
		
		fileSystem.createDirectory(destDir);
		
		return processManager.run(folders.tools + "/unzip.exe", [ srcZip, "-d", destDir ], true) == 0;
	}
}