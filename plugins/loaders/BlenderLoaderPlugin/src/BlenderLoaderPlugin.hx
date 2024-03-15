import haxe.io.Path;
import js.lib.Promise;
import js.Browser.console;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
import nanofl.ide.plugins.LoaderPlugins;
import blenderloader.BlenderDetector;
import blenderloader.Params;
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
		{ type:"info", label:"This plugin automatically run Blender to convert *.blend in your library into *.gltf."
						   + " Ensure you have <a href='http://blender.org/'>Blender</a> installed." },
		{ type:"file", name:"blenderPath", label:"Path to the blender.exe", description:"Select path to the blender.exe", defaultValue:"", fileFilters:[ { description:"Executable files (*.exe)", extensions:[ "exe" ] } ] }
	];

    public var extensions = [ "blend" ];
	
	var blenderExePath : String = null;

    var api : PluginApi;
	
    public function new() {}
	
	/**
	 * Not really load items, just convert `*.blend` files into `*.gltf`
	 * and let StdLoadersPlugin to load `*.gltf` later.
	 */
	public function load(api:PluginApi, _params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        this.api = api;

		var params = (cast _params : Params);
		var blendFiles = files.filter(file -> file != null && Path.extension(file.relativePath).toLowerCase() == "blend");

        if (blendFiles.length == 0 || !detectBlenderPath(params)) return Promise.resolve([]);

        return Promise.all(blendFiles.map(x -> loadFile(baseDir, x, files))).then(_ -> []);
	}
	
	function loadFile(baseDir:String, file:CachedFile, files:Map<String, CachedFile>) : Promise<{}>
	{
        var namePath = Path.withoutExtension(file.relativePath);
        var relDestFilePath = namePath + ".gltf";
        
        var blendFilePath = baseDir + "/" + file.relativePath;
        var destFilePath = baseDir + "/" + relDestFilePath;
        
        if (!api.fileSystem.exists(destFilePath) || api.fileSystem.getLastModified(destFilePath).getTime() < api.fileSystem.getLastModified(blendFilePath).getTime())
        {
            //Blender -b input.blend --python-expr "import bpy; bpy.ops.export_scene.gltf(filepath='output.glb')"
            //Blender -b input.blend --python-expr "import bpy; bpy.ops.export_scene.gltf(filepath='output.gltf', export_format='GLTF_EMBEDDED')"
            var script = "import bpy; bpy.ops.export_scene.gltf(filepath='" + destFilePath + "', export_format='GLTF_EMBEDDED')";
            var result = api.processManager.runCaptured(blenderExePath, [ "-b", blendFilePath, "--python-expr", script ]);
            
            if (result.code == 0 && api.fileSystem.exists(destFilePath))
            {
                files.set(relDestFilePath, new CachedFile(baseDir, relDestFilePath));
            }
            else
            {
                console.error("Error [" + result.code + "] while conversion '" + file.relativePath + "' to '" + relDestFilePath + "':\n" + result.out.replace("\r\n", "\n") + result.err.replace("\r\n", "\n"));
            }
        }

        files.remove(file.relativePath);

        return Promise.resolve(null);
	}
	
	function detectBlenderPath(params:Params) : Bool
	{
		if (blenderExePath == null)
		{
			blenderExePath = BlenderDetector.detectExePath(api.fileSystem, api.environment, params);
			if (blenderExePath == null)
			{
				console.warn("Blender is not found. Ensure Blender installed and check the path to the blender.exe in Preferences.");
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