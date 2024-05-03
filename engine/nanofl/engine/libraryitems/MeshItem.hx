package nanofl.engine.libraryitems;

import js.lib.Error;
import js.lib.Promise;
import stdlib.Debug;
import stdlib.Std;
import js.three.ObjectType;
import js.three.core.Object3D;
import js.three.addons.loaders.GLTFLoader;
import js.three.scenes.Scene;
import nanofl.engine.geom.Point;
import nanofl.engine.ITextureItem;
using stdlib.Lambda;
using stdlib.StringTools;
using nanofl.engine.geom.BoundsTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class MeshItem extends InstancableItem 
    implements ITextureItem
    implements ISpritableItem
{
	function get_type() return LibraryItemType.mesh;
	
	public static final DISPLAY_OBJECT_SIZE = 256;
	
	public var textureAtlas : String;
	public var loadLights = false;
	
	public var scene(default, null) : Scene;
	public var boundingRadius : Float;
	var _rendererLoadLights : Bool;
	
    public var spriteSheet(get, never) : easeljs.display.SpriteSheet;
	
    public function new(namePath:String)
	{
		super(namePath);
	}
	
	public function clone() : MeshItem
	{
		var obj = new MeshItem(namePath);
		
		obj.textureAtlas = textureAtlas;
		obj.loadLights = loadLights;
		
		obj.scene = scene != null ? cast scene.clone(true) : null;
		obj.boundingRadius = boundingRadius;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public function getIcon() return "custom-icon-cube";
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
        var spriteSheet = TextureAtlasTools.getSpriteSheet(this);
        if (spriteSheet == null) return preloadInner();
        else				     return Promise.resolve(null);
	}

    function preloadInner() : Promise<{}>
    {
        #if ide
        return Loader.file(library.realUrl(namePath + ".gltf")).then(s -> 
        {
            return processPreloadedJson(haxe.Json.parse(s));
        });
        #else
        if (textureAtlas != null && textureAtlas != "") return Promise.resolve(null);
        return SerializationAsJsTools.load(library, namePath, true).then(json -> processPreloadedJson(json));
        #end
    }

	function processPreloadedJson(json:Dynamic) : Promise<{}>
    {
        log("processPreloadedJson");
        log(json);

        var loader = new GLTFLoader();

        return loader.parseAsync(json, library.realUrl("")).then(gltf ->
        {
            if (gltf.scene.type == ObjectType.Scene)
            {
                this.scene = cast gltf.scene;
            }
            else
            {
                scene = new Scene();
                scene.add(gltf.scene);
            }

            updateBoundingRadius();

            return null;
        });
    }

	function updateBoundingRadius()
	{
		boundingRadius = 0.0;
		
		scene.traverse((object:Object3D) ->
		{
			log("MeshItem.updateBoundingRadius object " + object.type + " / " + object.name);
			
			if (object.type == ObjectType.Mesh)
			{
				var mesh : js.three.objects.Mesh = cast object;
				mesh.updateMatrixWorld(true);
                mesh.geometry.computeBoundingSphere();
                boundingRadius = Math.max(boundingRadius, mesh.geometry.boundingSphere.radius);
			}
		});
		
		boundingRadius = Math.sqrt(boundingRadius);
		
		log("MeshItem.updateBoundingRadius boundingRadius = " + boundingRadius);
	}
	
	override public function createDisplayObject(params:Dynamic) : easeljs.display.DisplayObject
	{
		var r = super.createDisplayObject(params);
        if (r != null) return r;

        return spriteSheet == null
            ? new nanofl.Mesh(this, params)
            : new nanofl.Sprite(this, null);
	}

    function get_spriteSheet() : easeljs.display.SpriteSheet
	{
        #if ide 
        return null;
        #else
        return TextureAtlasTools.getSpriteSheet(this);
        #end
    }
	
	public function getDisplayObjectClassName() return "nanofl.Mesh";
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.is(item, MeshItem)) return false;
		if (!super.equ(item)) return false;
		if ((cast item:MeshItem).textureAtlas != textureAtlas) return false;
		if ((cast item:MeshItem).loadLights != loadLights) return false;
		return true;
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		var d = DISPLAY_OBJECT_SIZE / 2;
		var bounds = { minX:-d, minY:-d, maxX:d, maxY:d };
		return bounds.getNearestPoint(pos);
	}

    #if ide
	function hasDataToSave() : Bool
    {
        return linkedClass != null && linkedClass != ""
            || textureAtlas != null && textureAtlas != "";
    }

    override function saveProperties(xml:XmlBuilder) : Void
    {
        super.saveProperties(xml);

		xml.attr("textureAtlas", textureAtlas, null);
		xml.attr("loadLights", loadLights, false);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);
		
		obj.textureAtlas = textureAtlas ?? null;
		obj.loadLights = loadLights ?? false;
    }
    
    override function loadProperties(xml:HtmlNodeElement) : Void
    {
        super.loadProperties(xml);

		textureAtlas = xml.getAttr("textureAtlas", null);
		loadLights = xml.getAttr("loadLights", false);
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        
        super.loadPropertiesJson(obj);

		textureAtlas = obj.textureAtlas ?? null;
		loadLights = obj.loadLights ?? false;
    }      
	
	public function toString() return "MeshItem(" + namePath + ")";
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.trace("", Reflect.isFunction(v) ? v() : v);
	}
}