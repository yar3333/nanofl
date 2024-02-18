package nanofl.engine.libraryitems;

import js.lib.Error;
import datatools.MapTools;
import datatools.ArrayTools;
import haxe.io.Path;
import js.lib.Promise;
import nanofl.engine.FontVariant;
import nanofl.engine.ILibraryItem;
import stdlib.Debug;
import stdlib.Std;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
using stdlib.StringTools;
using stdlib.Lambda;

class FontItem extends LibraryItem
{
	function get_type() return LibraryItemType.font;
	
    public var variants : Array<FontVariant>;
	
	public function new(namePath:String, ?variants:Array<FontVariant>)
	{
		super(namePath);
		this.variants = variants ?? [];
	}
	
	public function clone() : FontItem
	{
		var obj = new FontItem(namePath, variants.copy());
		copyBaseProperties(obj);
		return obj;
	}
	
	public function getIcon() return "icon-font";
	
	public function toFont() : Font
	{
		return { family:Path.withoutDirectory(namePath), fallbacks:[], variants:variants };
	}
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
		var family = Path.withoutDirectory(namePath);
		
		var r = Promise.resolve();
		for (variant in variants)
		{
			r = r.then(_ -> getExistsSupportedFormat(variant).then((format:String) ->
			{
				if (format != null)
				{
					var font = new js.html.FontFace
					(
						family,
						"url(" + variant.urls.get(format) + ") format(\"" + format + "\")",
						{ style:variant.style, weight:Std.string(variant.weight) }
					);
					return new Promise((resolve, reject) ->
					{
						font.load().then
						(
							function(font:js.html.FontFace)
							{
								js.Browser.document.fonts.add(font);
								resolve(null);
							},
							function(e)
							{
								trace("Font '" + family + "' loading error ('" + variant.urls.get(format) + "'):");
								trace(e);
								resolve(null);
							}
						);
					});
				}
				else
				{
					trace("Can't found suitable font file format ('" + family + " " + variant.style + " " + variant.weight + "').");
					return null;
				}
			}));
		}
		
		return r;
	}
	
	function getExistsSupportedFormat(variant:FontVariant) : Promise<String>
	{
		return new Promise<String>(function(resolve, reject)
		{
			//js.npm.DrFontSupport.getSupportedFormats(function(supports)
			//{
				if (/*supports.woff2 && */variant.urls.exists("woff2"))
				{
					resolve("woff2");
				}
				else
				if (/*supports.woff && */variant.urls.exists("woff"))
				{
					resolve("woff");
				}
				else
				if (/*supports.ttf && */variant.urls.exists("truetype"))
				{
					resolve("truetype");
				}
				else
				if (/*supports.svg && */variant.urls.exists("svg"))
				{
					resolve("svg");
				}
				else
				if (variant.urls.exists("eot"))
				{
					resolve("eot");
				}
				else
				{
					resolve(null);
				}
			//});
		});
	}
	
	public function addVariant(v:FontVariant)
	{
		var origV = variants.find(x -> v.style == x.style && v.weight == x.weight);
		if (origV != null)
		{
			for (format in v.urls.keys())
			{
				origV.urls.set(format, v.urls.get(format));
			}
		}
		else
		{
			variants.push(v);
		}
	}
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.isOfType(item, FontItem)) return false;
		if (!super.equ(item)) return false;
		if (!ArrayTools.equ((cast item:FontItem).variants, variants)) return false;
		return true;
	}
	

    #if ide
	function hasDataToSave() return true;
    
    function saveProperties(out:XmlBuilder) : Void
    {
		for (variant in variants)
        {
            out.begin("variant")
                .attr("style", variant.style)
                .attr("weight", variant.weight)
                .attr("locals", variant.locals.join(", "));
                
                for (format in variant.urls.keys())
                {
                    out.begin("file")
                        .attr("format", format)
                        .attr("url", variant.urls.get(format));
                    out.end();
                }
                
            out.end();
        }
    }

    function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.variants = variants.map(x -> 
        ({
            style: x.style,
            weight: x.weight,
            locals: x.locals,
            files: MapTools.toObject(x.urls),
        }));
    }
    
    function loadProperties(itemNode:HtmlNodeElement) : Void
    {
		var version = itemNode.getAttribute("version");
		if (version == null || version == "") version = "1.0.0";
		
		for (node in itemNode.children.filter(x -> x.name == "variant"))
		{
            var variant = new FontVariant
            (
                node.getAttr("style", "normal"),
                node.getAttr("weight", 400),
                node.getAttrString("locals", "").split(",").map(x -> x.trim()).filter(x -> x != "")
            );
            
            Version.handle(version,
            [
                "1.0.0" => function()
                {
                    variant.urls.set(node.getAttr("format", ""), node.getAttrString("url", ""));
                },
                "2.0.0" => function()
                {
                    for (urlNode in node.children)
                    {
                        variant.urls.set(urlNode.getAttr("format", ""), urlNode.getAttrString("url", ""));
                    }
                }
            ]);
            
            variants.push(variant);
        }
    }
    #end
    
    function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        variants = (cast obj.variants : Array<Dynamic>).map(x -> new FontVariant(x.style, x.weight, x.locals, MapTools.fromObject(x.files)));
    }

	public function toString() return "FontItem(" + namePath + ")";
}