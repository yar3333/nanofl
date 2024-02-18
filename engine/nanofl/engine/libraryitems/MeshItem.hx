package nanofl.engine.libraryitems;

import js.three.renderers.WebGLRenderer;
import js.three.objects.Group;
import stdlib.Std;
import js.three.addons.loaders.GLTFLoader;
import js.three.ObjectType;
import js.three.core.Object3D;
import js.three.renderers.Renderer;
import js.three.scenes.Scene;
import js.lib.Error;
import js.lib.Promise;
import datatools.NullTools;
import nanofl.engine.geom.Point;
import nanofl.engine.ITextureItem;
import stdlib.Debug;
using stdlib.Lambda;
using stdlib.StringTools;
using htmlparser.HtmlParserTools;
import js.Browser.console;
using nanofl.engine.geom.BoundsTools;

class MeshItem extends InstancableItem implements ITextureItem
{
	function get_type() return LibraryItemType.mesh;
	
	public static inline var DEFAULT_RENDER_AREA_SIZE = 256;
	
	public var ext : String;
	public var originalExt : String;
	public var textureAtlas : String;
	public var renderAreaSize = DEFAULT_RENDER_AREA_SIZE;
	public var loadLights = false;
	
	public var scene(default, null) : Scene;
	public var boundingRadius : Float;
	var _renderer : Renderer;
	public var renderer(get, never) : Renderer;
	var _rendererLoadLights : Bool;
	var textureFiles = new Array<String>();
	
	public function new(namePath:String, ext:String, originalExt:String)
	{
		super(namePath);
		this.ext = ext;
		this.originalExt = originalExt;
	}
	
	public function clone() : MeshItem
	{
		var obj = new MeshItem(namePath, ext, originalExt);
		
		obj.textureAtlas = textureAtlas;
		obj.renderAreaSize = renderAreaSize;
		obj.loadLights = loadLights;
		
		obj.scene = scene != null ? cast scene.clone(true) : null;
		obj.boundingRadius = boundingRadius;
		obj.textureFiles = textureFiles;
		
		copyBaseProperties(obj);
		
		return obj;
	}
	
	public function getIcon() return "custom-icon-cube";
	
	public function preload() : Promise<{}>
	{
		Debug.assert(library != null, "You need to add item '" + namePath + "' to the library before preload call.");
		
        var spriteSheet = TextureItemTools.getSpriteSheet(this);
        if (spriteSheet == null) return preloadInner();
        else				     return TextureItemTools.preload(this);
	}

    function preloadInner() : Promise<{}>
    {
        #if ide
        return Loader.file(library.realUrl(namePath + "." + ext)).then(s -> 
        {
            return processPreloadedJson(haxe.Json.parse(s));
        });
        #else
        return Loader.loadJsScript(library.realUrl(namePath + ".js")).then(_ -> 
        {
            return processPreloadedJson(getLibraryFileContent(namePath + ".gltf"));
        });
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

            // scene.traverse(object->
            // {
            //     if (object.type == Object3dType.Mesh)
            //     {
            //         (cast object:Mesh).material.overdraw = 1;
            //     }
            // });
            
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
                // TODO: center
                boundingRadius = Math.max(boundingRadius, mesh.geometry.boundingSphere.radius);
			}
		});
		
		boundingRadius = Math.sqrt(boundingRadius);
		
		log("MeshItem.updateBoundingRadius boundingRadius = " + boundingRadius);
	}
	
	override public function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : easeljs.display.DisplayObject
	{
		var r = super.createDisplayObject(initFrameIndex, childFrameIndexes);
		
        if (r == null)
		{
			var spriteSheet = TextureItemTools.getSpriteSheet(this);
			r =  spriteSheet == null
				? new nanofl.Mesh(this)
				: new easeljs.display.Sprite(spriteSheet);
		}
		
		//r.setBounds(0, 0, image.width, image.height);
		
		return r;
	}
	
	public function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ element:IPathElement, frameIndex:Int }>)
	{
		Debug.assert(Std.is(dispObj, nanofl.Mesh));
		
		var mesh : nanofl.Mesh = cast dispObj;
		
		mesh.scene = new Scene();
		mesh.scene.fog = NullTools.clone(scene.fog);
		
		mesh.scene.add(mesh.group = new Group());
		
		for (object in scene.children)
		{
			switch (object.type)
			{
				case AmbientLight, DirectionalLight, SpotLight, PointLight, HemisphereLight, RectAreaLight:
					if (loadLights)
					{
						mesh.group.add(object.clone());
					}
					
				case _:
					mesh.group.add(object.clone());
			}
		}
		
		mesh.update();
	}
	
	function get_renderer() : Renderer
	{
		if (_rendererLoadLights != loadLights) _renderer = null;
		
		if (_renderer != null)
		{
			if (!Std.is(_renderer, WebGLRenderer)) _renderer = null;
		}
		
		if (_renderer == null)
		{
			#if ide
			var oldLog = Console.filter("log", function(vv)
			{
				return vv[0] != "THREE.WebGLRenderer" || !vv[1] || !~/^\d+$/.match(vv[1]);
			});
			#end
			
			var canvas : js.html.CanvasElement = cast js.Browser.document.createElement("canvas");
			canvas.width = canvas.height = renderAreaSize;
			
			_renderer = new WebGLRenderer({ canvas:canvas, alpha:true });

			#if ide
			if (oldLog != null)
			{
				(cast js.Browser.console).log = oldLog;
			}
			#end
			
			_renderer.setSize(renderAreaSize, renderAreaSize);
			
			_rendererLoadLights = loadLights;
		}
		return _renderer;
	}
	
	public function getDisplayObjectClassName() return "nanofl.Mesh";
	
	override public function equ(item:ILibraryItem) : Bool
	{
		if (!Std.is(item, MeshItem)) return false;
		if (!super.equ(item)) return false;
		if ((cast item:MeshItem).ext != ext) return false;
		if ((cast item:MeshItem).textureAtlas != textureAtlas) return false;
		if ((cast item:MeshItem).renderAreaSize != renderAreaSize) return false;
		if ((cast item:MeshItem).loadLights != loadLights) return false;
		return true;
	}
	
	override public function getNearestPoint(pos:Point) : Point
	{
		var d = renderAreaSize / 2;
		var bounds = { minX:-d, minY:-d, maxX:d, maxY:d };
		return bounds.getNearestPoint(pos);
	}

    #if ide
	function hasDataToSave() : Bool
    {
        return linkedClass != null && linkedClass != ""
            || originalExt != null && originalExt != ""
            || textureAtlas != null && textureAtlas != "";
    }

    override function saveProperties(xml:htmlparser.XmlBuilder) : Void
    {
        super.saveProperties(xml);

		xml.attr("ext", ext, null);
		xml.attr("originalExt", originalExt, null);
		xml.attr("textureAtlas", textureAtlas, null);
		xml.attr("renderAreaSize", renderAreaSize, DEFAULT_RENDER_AREA_SIZE);
		xml.attr("loadLights", loadLights, false);
    }

    override function savePropertiesJson(obj:Dynamic) : Void
    {
        super.savePropertiesJson(obj);
		
        obj.ext = ext ?? null;
		obj.originalExt = originalExt ?? null;
		obj.textureAtlas = textureAtlas ?? null;
		obj.renderAreaSize = renderAreaSize ?? DEFAULT_RENDER_AREA_SIZE;
		obj.loadLights = loadLights ?? false;
    }
    
    override function loadProperties(xml:htmlparser.HtmlNodeElement) : Void
    {
        super.loadProperties(xml);

		originalExt = xml.getAttr("originalExt", null);
		textureAtlas = xml.getAttr("textureAtlas", null);
		renderAreaSize = xml.getAttr("renderAreaSize", MeshItem.DEFAULT_RENDER_AREA_SIZE);
		loadLights = xml.getAttr("loadLights", false);
    }
    #end
    
    override function loadPropertiesJson(obj:Dynamic) : Void
    {
        if (obj.type != type) throw new Error("Type of item must be '" + type + "', but '" + obj.type + "' found.");
        
        super.loadPropertiesJson(obj);

		ext = obj.ext ?? null;
		originalExt = obj.originalExt ?? null;
		textureAtlas = obj.textureAtlas ?? null;
		renderAreaSize = obj.renderAreaSize ?? DEFAULT_RENDER_AREA_SIZE;
		loadLights = obj.loadLights ?? false;
    }      
	
	public function toString() return "MeshItem(" + namePath + ")";
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}