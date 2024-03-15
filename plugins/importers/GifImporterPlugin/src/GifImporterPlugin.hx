import nanofl.ide.library.IdeLibraryTools;
import nanofl.engine.elements.Instance;
import haxe.crypto.Base64;
import nanofl.engine.movieclip.KeyFrame;
import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.ImporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.IImporterPlugin;
import nanofl.ide.plugins.ImporterPlugins;

class GifImporterPlugin implements IImporterPlugin
{
	static function main() ImporterPlugins.register(new GifImporterPlugin());
	
	public var name = "GifImporter";
	
	public var menuItemName = "GIF (*.gif)";
	public var menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAC5ElEQVQozz2LbUxbZQBGn7ctLVDpZQKi4KJjAYTGLBIEYU2gxTlKhAhZ0MQxZupMNoPBBbP5gX/QaKIGTDSaiM5snciHwB0lHTKENWxZMAxi1LBunSKDNh2jwAps7e199kPnv5Occ0ASqqoKkiIWi2lIoqev356akhJ4cFty8JSz6wWSuO/+a/E/THgmnz7cfLx1QB62PZmf+/tIaxbPt2XTnLvD2z/oqjjy5tvvjY5NlNyfQRKeyYuFaQ8I5WhlAh/dplVMRr0S6itVNwd3q6lSvJJu0igt9kSmGcGfz43vJgkNAJwZGrXWW5O0n31ftfXlG3lifSOi9c1viL9ubInltTvaz1/PFZ+csG81ViVDPjNSAeDfsbj4qdne8XW4v5qLr9mbLj4++DiUGBGJqmjb/xherH5EnPvGa3CeXcUzxQUzAIDu3p+qzE/s9D6UbFABsOPQTvK8jVHZwqhsIT02fn0kmwCYJhnU/JwdvpOnfqgVGRmZvvaXdFkFWYkcuxwQkiTBkmeEMcEAIQQ2Nu/g4pVN3AqFUL4rnVeWIuK1724vaQXUD2eurug12ytF7aEP8OPZWQSTrHBOLGPwchSRjGpc+OMmDhz9AkPTW6Ld6WFg5W68ABC2WCzGru5eDMgu7LFasBlew6h7COHwbdTVvwytzoBL07/heftzeNXxCtxut6IF8K61vDyupKQYDfvsmByToY1LQEFhISSThLsRBaYkI/bvq8HUr1NY8gcQDAYJvT4uLIRgT3cXSbLj049oNpu5eOMfeuf+ZMtbx3jpgofvNDtIkgcaGwkgCiFEODMzkznZ2Xw41US/389nK2y8dtVLv3+J9sq9vO7zEQBH3MNsbX2fACIA4CstLWUoFFI7O7/lwsICkyWJ47+McXZmhvEGPf+en6fz9Gn6/QHVZrMRwCI0Gs1BAKt1dXUxl8sVLSsrUwAoDodDaWpqUgAoRUVFiizL0YaGhhiAdZ1O57gHue+ALxPHGYEAAAAASUVORK5CYII=)";
	public var fileFilterDescription = "GIF image files (*.svg)";
	public var fileFilterExtensions = [ "gif" ];

    public function new() {}
	
	public var properties : Array<CustomProperty> = [];
	
	public function importDocument(api:PluginApi, args:ImporterArgs) : Promise<Bool>
	{
        final scene = args.library.addSceneWithFrame();
        final layer = scene.layers[0];
        layer.keyFrames.splice(0, layer.keyFrames.length);

        var n = 0;
        return VideoImporter.run(api.videoUtils, api.processManager, api.folders, args.srcFilePath, canvas ->
        {
		    if (n == 0)
		    {
                args.documentProperties.width = canvas.width;
		        args.documentProperties.height = canvas.height;
            }
            
            api.fileSystem.saveBinary(args.library.libraryDir + "/Frame " + n + ".png", Base64.decode(canvas.toDataURL("image/png").split(",")[1]));
            layer.addKeyFrame(new KeyFrame(null, 1, null, [ new Instance("Frame " + n) ]));
            n++;
        })
        .then(success ->
        {
            return success ? args.library.loadItems().then(_ -> true) : Promise.resolve(false);
        });
	}

    public function getPublishDirectoryBasePath(originalPath:String) : String
    {
        return Path.withoutExtension(originalPath);
    }
}
