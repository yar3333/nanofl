package nanofl.ide.sys;

import haxe.io.Bytes;
import haxe.io.Path;
import js.lib.Promise;
import js.html.FileReader;

@:rtti
class Uploader
{
	var fileSystem : FileSystem;
	
	public function new(fileSystem:FileSystem) 
	{
		this.fileSystem = fileSystem;
	}
	
	public function saveUploadedFiles(files:Array<js.html.File>, destDir:String) : Promise<{}>
	{
		var p = Promise.resolve(null);
		
		for (file in files)
		{
			p = p.then(function(_)
			{
				return new Promise<{}>(function(resolve, reject)
				{
					var reader = new FileReader();
					
					reader.onload = function(_)
					{
						var filePath = Path.join([ destDir, Path.withoutDirectory(file.name) ]);
						fileSystem.saveBinary(filePath, Bytes.ofData(reader.result));
						resolve(null);
					};
					
					reader.onerror = function(_)
					{
						log("Error loading file '" + file.name + "' (" + reader.error + ").");
						resolve(null);
					};
					
					reader.readAsArrayBuffer(file);
				});
			});
		}
		
		return p;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}