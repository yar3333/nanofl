package nanofl.engine.elements;

import js.lib.Error;
import datatools.ArrayTools;
import datatools.NullTools;
import easeljs.display.DisplayObject;
import nanofl.engine.Library;
import nanofl.engine.coloreffects.ColorEffect;
import nanofl.engine.elements.Element;
import nanofl.engine.geom.Point;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.MeshParams.MeshParamsTools;
import stdlib.Debug;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.ide.undo.states.ElementState;
import nanofl.ide.undo.states.InstanceState;
using htmlparser.HtmlParserTools;
#end

class Instance extends Element
{
	function get_type() return ElementType.instance;
	
	var library : Library;
	
	public var namePath : String;
	public var name : String;
	public var colorEffect : ColorEffect;
	public var filters : Array<FilterDef>;
	public var blendMode : BlendModes;
    public var meshParams : MeshParams;
	
	public var symbol(get, never) : InstancableItem;
	@:noCompletion function get_symbol() return (cast library.getItem(namePath) : InstancableItem);
	
	public function new(namePath:String, ?name:String, ?colorEffect:ColorEffect, ?filters:Array<FilterDef>, ?blendMode:BlendModes, ?meshParams:MeshParams)
	{
		super();
		
		this.namePath = namePath;
		this.name = name;
		this.colorEffect = colorEffect;
		this.filters = filters ?? [];
		this.blendMode = blendMode ?? BlendModes.normal;
		this.meshParams = meshParams ?? MeshParamsTools.createDefault();
	}
	
	#if ide
	override function loadProperties(node:HtmlNodeElement, version:String)
	{
		if (!super.loadProperties(node, version)) return false;
		
		namePath = node.getAttr("libraryItem");
		Debug.assert(namePath != null);
		Debug.assert(namePath != "");
		name = node.getAttr("name", "");
		colorEffect = ColorEffect.load(node.findOne(">color"));
		filters = node.find(">filters>*").map(node -> FilterDef.load(node, version));
		blendMode = node.getAttr("blendMode", BlendModes.normal);
		meshParams = MeshParamsTools.load(node);
		
		return true;
	}
    #end

    override function loadPropertiesJson(obj:Dynamic, version:String) : Bool
    {
		if (!super.loadPropertiesJson(obj, version)) return false;
        
		namePath = obj.libraryItem;
		Debug.assert(namePath != null);
		Debug.assert(namePath != "");
		name = obj.name ?? "";
		colorEffect = ColorEffect.loadJson(obj.colorEffect);
		filters = (obj.filters ?? []).map(x -> FilterDef.loadJson(x, version));
		blendMode = obj.blendMode ?? BlendModes.normal;
		meshParams = obj.meshParams != null ? MeshParamsTools.loadJson(obj.meshParams) : null;
		
		return true;
    }
	
	#if ide
	override public function saveProperties(out:XmlBuilder) 
	{
		out.attr("libraryItem", namePath);
		out.attr("name", name, "");
		out.attr("blendMode", blendMode, BlendModes.normal);
        if (meshParams != null && library.hasItem(namePath) && symbol.type == LibraryItemType.mesh) MeshParamsTools.save(meshParams, out);
        if (colorEffect != null) colorEffect.save(out);
		
        if (filters.length > 0)
		{
			out.begin("filters");
			for (filter in filters) filter.save(out);
			out.end();
		}
		
		super.saveProperties(out);
	}

	override function savePropertiesJson(obj:Dynamic) : Void
    {
        obj.libraryItem = namePath;
		obj.name = name ?? "";
		
        super.savePropertiesJson(obj);
		
		if (blendMode != BlendModes.normal) obj.blendMode = blendMode ?? BlendModes.normal;
        if (meshParams != null && library.hasItem(namePath) && symbol.type == LibraryItemType.mesh) obj.meshParams = MeshParamsTools.saveJson(meshParams);
        if (colorEffect != null) obj.colorEffect = colorEffect.saveJson();
		
        if (filters.length > 0)
		{
			obj.filters = filters.map(x -> x.saveJson());
		}
    }
    #end
        
	public function clone() : Instance
	{
		var obj = new Instance
		(
			namePath,
			name,
			NullTools.clone(colorEffect),
			ArrayTools.clone(filters),
			blendMode,
            MeshParamsTools.clone(meshParams),
		);
		obj.library = library;
		copyBaseProperties(obj);
		return obj;
	}
	
	#if ide
	override public function getState() : ElementState
	{
		return new nanofl.ide.undo.states.InstanceState
		(
			name,
			NullTools.clone(colorEffect),
			ArrayTools.clone(filters),
			blendMode,
            MeshParamsTools.clone(meshParams),
		);
	}
	
	override public function setState(state:ElementState) : Void
	{
		name = (cast state:InstanceState).name;
		colorEffect = NullTools.clone((cast state:InstanceState).colorEffect);
		filters = ArrayTools.clone((cast state:InstanceState).filters);
		blendMode = (cast state:InstanceState).blendMode;
        meshParams = MeshParamsTools.clone((cast state:InstanceState).meshParams);
	}
	#end
	
	override public function toString() return (parent != null ? parent.toString() + " / " : "") + "Instance(" + namePath + ")";
	
	///////////////////////////////////////////////////////////////////
	
	public function createDisplayObject() : easeljs.display.DisplayObject
	{
		var dispObj = switch (symbol.type)
		{
            case LibraryItemType.movieclip: symbol.createDisplayObject(null);
            case LibraryItemType.bitmap: symbol.createDisplayObject(null);
            case LibraryItemType.mesh: symbol.createDisplayObject(meshParams);
            case LibraryItemType.video: symbol.createDisplayObject(null); // TODO: currentFrame
            case LibraryItemType.sound: throw new Error("Unexpected `sound` as DisplayObject creating.");
            case LibraryItemType.font: throw new Error("Unexpected `font` as DisplayObject creating.");
            case LibraryItemType.folder: throw new Error("Unexpected `folder` as DisplayObject creating.");
        }
        
		elementUpdateDisplayObjectBaseProperties(dispObj);
		elementUpdateDisplayObjectInstanceProperties(dispObj);
		return dispObj;
	}
	
	function elementUpdateDisplayObjectInstanceProperties(dispObj:easeljs.display.DisplayObject) : Void
	{
		if (dispObj.filters == null) dispObj.filters = [];
		
		if (colorEffect != null) colorEffect.apply(dispObj);
		
		for (filter in filters)
		{
			var f = filter.getFilter();
			if (f != null) dispObj.filters.push(f);
		}
		
		if (name != "") dispObj.name = name;
		
		dispObj.compositeOperation = blendMode;

		if (meshParams != null && Std.is(dispObj, nanofl.Mesh))
        {
            MeshParamsTools.applyToMesh(meshParams, (cast dispObj:nanofl.Mesh));
        }
    }

    public function updateDisplayObjectTweenedProperties(dispObj:DisplayObject) : Void
    {
		elementUpdateDisplayObjectBaseProperties(dispObj);
		elementUpdateDisplayObjectInstanceProperties(dispObj);
    }
	
	override function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		return [ symbol.getNearestPoint(pos) ];
	}
	
	override function setLibrary(library:Library) 
	{
		this.library = library;
	}
	
	override public function equ(element:Element) : Bool 
	{
		if (!super.equ(element)) return false;
		if ((cast element:Instance).namePath != namePath) return false;
		if ((cast element:Instance).name != name) return false;
		if (!NullTools.equ((cast element:Instance).colorEffect, colorEffect)) return false;
		if (!ArrayTools.equ((cast element:Instance).filters, filters)) return false;
		if ((cast element:Instance).blendMode != blendMode) return false;
        if (!MeshParamsTools.equ((cast element:Instance).meshParams, meshParams)) return false;
		return true;
	}
	
}