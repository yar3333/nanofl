package blenderloader;

import nanofl.ide.sys.Environment;
import nanofl.ide.sys.FileSystem;

class BlenderDetector
{
	public static function detectExePath(fileSystem:FileSystem, env:Environment, params:Params) : String
	{
		var path = params.blenderPath;
		
		if (path == null || path == "")
		{
			path = detectExePathInner(fileSystem, env);
			if (path != null) params.blenderPath = path;
		}
		
		if (!isBlenderPathCorrect(fileSystem, params.blenderPath))
		{
			return null;
		}
		
		return params.blenderPath;
	}
	
	static function isBlenderPathCorrect(fileSystem:FileSystem, compilerPath:String)
	{
		return compilerPath != null && compilerPath != "" && fileSystem.exists(compilerPath);
	}
	
	static function detectExePathInner(fileSystem:FileSystem, env:Environment) : String
	{
		//if (fileSystem.isWindows())
		//{
			for (pfEnvVarName in [ "PROGRAMW6432", "PROGRAMFILES", "PROGRAMFILES(X86)" ])
			{
				var pf = env.get(pfEnvVarName);
				if (pf != null && pf != "")
				{
					for (dir in [ "Blender Foundation\\Blender", "Blender" ])
					{
						var r = pf + "\\" + dir +"\\blender.exe";
						if (fileSystem.exists(r)) return r;
					}
				}
			}
		//}
		//else
		//{
		//	return "blender";
		//}
        
        return null;
	}
}