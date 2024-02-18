import js.lib.Promise;
import blenderloader.BlenderDetector;
import blenderloader.Params;
import haxe.io.Path;
import nanofl.engine.CustomProperty;
import nanofl.engine.Debug.console;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.MeshItem;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
import nanofl.ide.plugins.LoaderPlugins;
using StringTools;
using Lambda;

class BlenderLoaderPlugin implements ILoaderPlugin
{
	static function main()
	{
		LoaderPlugins.register(new BlenderLoaderPlugin());
	}
	
	public var name = "BlenderLoader";
	public var priority = 700;
	public var menuItemName = "Blender";
	public var menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAADXTAAA10wEMIUN3AAAC20lEQVQoz23JTWxUVRgG4Pd859x756+97dBOW+jUpEwqUAEppAiTNKRqJ2BMGg1hgSwIEHeGjRsNkjTRBXFhJDEpGoNuFDYNYMRosDTWmIJRws+Ean/uUAhT2qnTdjq3M/fM+Vy589k+gojwf5gFmGsCAEtJEgzDAP/3Kp1OAwBIQAohBAlIX1Nlu1scPLE//vXlqbqjo9nCtagNRUTGGDYAILu7u2HbDjQ5bIQyRkhDUmFV2zPtoVLnqQPt55pbN8lsvnqDiBCNONKybFbGMMAa+xLVYy3xWAoyrEnZFDCVn2i+M5Vfm3lze+OZDrd9z6c3nh6bL5YLUZukeDVzEGH48aFdj/7uaNsQ9znEVsQVbnIbIG0ETpxr66UaLXvqWdGf+3hs9Y1sPvhdZDIZMACX/GQ10OvJcGnv232Jzzd1bm2N9RwJKhteUOsaIi4Kujp+Xi3msksf3BT9siu1mSCIFipOcWdTZeCdV9outsXrmyM7BnmuqV9+dv2BuDQxh+mySy/t7tFq/KNoTBeeowpbpqa1OtmZu/BhenmkMci7FX+V7dat4vtf7+G7W1P44c8choav4nGtSYn6jXienvSphPxny8lU7quXU9Q7PIHhlnAheXAPHSovPDLtLV3014yHNT/A4f4X0UBl6JU8QhFLInu6bnHlTJTfPRAbAhROp0Nn+XyK8+d2VOfvj/LPdzz+5uYD9rxZLlw8ovV74OvH638RnxzvOXvXW7r75ag3AqDBdbBt7FR4ZGdzJbEcRGuys09YERdV7zeuW5uVRdmgM1+UBmWlbe/YH7PFh8tLi1FJ1OJrjvw0ZR7v6oj1diUQtlbuQy7dE44MKFdurL717er7415wTbz+2iH1bGGBJ27dFgBcIbCRGQ0WYUvfZqe/tyOUtBSZ7Hww++PD8pWVdXObBMpiYGAASilMT09jcnJSAnBIIAbAMgwJwAKgAZSEQCAYNSsU8v8FJek74SxGiM4AAAAASUVORK5CYII=)";
	
	public var properties : Array<CustomProperty> =
	[
		{ type:"info", label:"This plugin automatically convert *.blend in your library into *.json (supported by NanoFL)."
						   + " Ensure you have <a href='http://blender.org/'>Blender</a> installed." },
		{ type:"file", name:"blenderPath", label:"Path to the blender.exe", description:"Select path to the blender.exe", defaultValue:"", fileFilters:[ { description:"Executable files (*.exe)", extensions:[ "exe" ] } ] }
	];
	
	var blenderExePath : String = null;

    var api : PluginApi;
	
    public function new() {}
	
	/**
	 * Not really load items, just convert Blender's `*.blend` files into ThreeJS's `*.json`
	 * and let StdLoaders plugin to load *.json.
	 */
	public function load(api:PluginApi, _params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        this.api = api;

		var params = (cast _params : Params);
		var blendFiles = files.filter(file -> !file.excluded && Path.extension(file.path) == "blend");
		
		if (blendFiles.length > 0 && detectBlenderPath(params))
		{
			var items = new Array<IIdeLibraryItem>();
			
			var p = js.lib.Promise.resolve(items);
			for (file in blendFiles)
			{
				p = p.then(_ -> loadFile(baseDir, file, files, items));
			}
			return p; 
		}
		else
		{
			return js.lib.Promise.resolve([]);
		}
	}
	
	function loadFile(baseDir:String, file:CachedFile, files:Map<String, CachedFile>, items:Array<IIdeLibraryItem>) : Promise<Array<IIdeLibraryItem>>
	{
        var namePath = Path.withoutExtension(file.path);
        var relDestFilePath = namePath + ".gltf";
        
        var blendFilePath = baseDir + "/" + file.path;
        var destFilePath = baseDir + "/" + relDestFilePath;
        
        if (!api.fileSystem.exists(destFilePath) || api.fileSystem.getLastModified(destFilePath).getTime() < api.fileSystem.getLastModified(blendFilePath).getTime())
        {
            //Blender -b input.blend --python-expr "import bpy; bpy.ops.export_scene.gltf(filepath='output.glb')"
            //Blender -b input.blend --python-expr "import bpy; bpy.ops.export_scene.gltf(filepath='output.gltf', export_format='GLTF_EMBEDDED')"
            var script = "import bpy; bpy.ops.export_scene.gltf(filepath='" + destFilePath + "', export_format='GLTF_EMBEDDED')";
            var result = api.processManager.runCaptured(blenderExePath, [ "-b", blendFilePath, "--python-expr", script ]);
            
            if (result.exitCode == 0 && api.fileSystem.exists(destFilePath))
            {
                if (!files.exists(relDestFilePath))
                {
                    files.set(relDestFilePath, new CachedFile(baseDir, relDestFilePath));
                }
            }
            else
            {
                console.error("Error [" + result.exitCode + "] while conversion '" + file.path + "' to '" + relDestFilePath + "':\n" + result.output.replace("\r\n", "\n") + (result.output != "" ? "\n" : "") + result.error.replace("\r\n", "\n"));
            }
            
            var item = files.exists(relDestFilePath) ? MeshItem.load(namePath, "blend", files) : throw new js.lib.Error("File '" + relDestFilePath + "' is not found.");
            file.exclude();
            items.push(item);
            return Promise.resolve(items);
        }
        else
        {
            var item = files.exists(relDestFilePath) ? MeshItem.load(namePath, "blend", files) : throw new js.lib.Error("File '" + relDestFilePath + "' is not found.");
            file.exclude();
            items.push(item);
            return Promise.resolve(items);
        }
	}
	
	function detectBlenderPath(params:Params) : Bool
	{
		if (blenderExePath == null)
		{
			blenderExePath = BlenderDetector.detectExePath(api.fileSystem, api.environment, params);
			if (blenderExePath == null)
			{
				console.error("Blender is not found. Ensure Blender installed and check the path to the blender.exe in Preferences.");
				return false;
			}
		}
		return true;
	}

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}