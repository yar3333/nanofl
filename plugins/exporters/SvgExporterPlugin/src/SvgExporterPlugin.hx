import js.lib.Promise;
import htmlparser.XmlBuilder;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.engine.Debug.console;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.IExporterPlugin;
import svgexporter.SvgExporter;

class SvgExporterPlugin implements IExporterPlugin
{
	static function main()
    {
        ExporterPlugins.register(new SvgExporterPlugin());
    }
	
	public var name = "SvgExporter";
	
	public var menuItemName = "Scalable Vector Graphics (*.svg)";
	public var menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAC5ElEQVQozz2LbUxbZQBGn7ctLVDpZQKi4KJjAYTGLBIEYU2gxTlKhAhZ0MQxZupMNoPBBbP5gX/QaKIGTDSaiM5snciHwB0lHTKENWxZMAxi1LBunSKDNh2jwAps7e199kPnv5Occ0ASqqoKkiIWi2lIoqev356akhJ4cFty8JSz6wWSuO/+a/E/THgmnz7cfLx1QB62PZmf+/tIaxbPt2XTnLvD2z/oqjjy5tvvjY5NlNyfQRKeyYuFaQ8I5WhlAh/dplVMRr0S6itVNwd3q6lSvJJu0igt9kSmGcGfz43vJgkNAJwZGrXWW5O0n31ftfXlG3lifSOi9c1viL9ubInltTvaz1/PFZ+csG81ViVDPjNSAeDfsbj4qdne8XW4v5qLr9mbLj4++DiUGBGJqmjb/xherH5EnPvGa3CeXcUzxQUzAIDu3p+qzE/s9D6UbFABsOPQTvK8jVHZwqhsIT02fn0kmwCYJhnU/JwdvpOnfqgVGRmZvvaXdFkFWYkcuxwQkiTBkmeEMcEAIQQ2Nu/g4pVN3AqFUL4rnVeWIuK1724vaQXUD2eurug12ytF7aEP8OPZWQSTrHBOLGPwchSRjGpc+OMmDhz9AkPTW6Ld6WFg5W68ABC2WCzGru5eDMgu7LFasBlew6h7COHwbdTVvwytzoBL07/heftzeNXxCtxut6IF8K61vDyupKQYDfvsmByToY1LQEFhISSThLsRBaYkI/bvq8HUr1NY8gcQDAYJvT4uLIRgT3cXSbLj049oNpu5eOMfeuf+ZMtbx3jpgofvNDtIkgcaGwkgCiFEODMzkznZ2Xw41US/389nK2y8dtVLv3+J9sq9vO7zEQBH3MNsbX2fACIA4CstLWUoFFI7O7/lwsICkyWJ47+McXZmhvEGPf+en6fz9Gn6/QHVZrMRwCI0Gs1BAKt1dXUxl8sVLSsrUwAoDodDaWpqUgAoRUVFiizL0YaGhhiAdZ1O57gHue+ALxPHGYEAAAAASUVORK5CYII=)";
	public var fileFilterDescription = "Scalable Vector Graphics (*.svg)";
	public var fileFilterExtensions = [ "svg" ];
	
	public var properties : Array<CustomProperty> = null;

    public function new() {}
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
		console.log("Plugin.exportDocument " + args.srcFilePath + " => " + args.destFilePath);
		
		var xml = new XmlBuilder();
		xml.begin("svg")
			.attr("xmlns", "http://www.w3.org/2000/svg")
			.attr("width", args.documentProperties.width)
			.attr("height", args.documentProperties.height)
			.attr("xmlns:xlink", "http://www.w3.org/1999/xlink");
			
			new SvgExporter(args.library).export(xml);
			
		xml.end();
		
		api.fileSystem.saveContent(args.destFilePath, xml.toString());
		
		return Promise.resolve(true);
	}
}