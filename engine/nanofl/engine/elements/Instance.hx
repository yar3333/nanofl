package nanofl.engine.elements;

import datatools.ArrayRO;
import datatools.ArrayTools;
import datatools.NullTools;
import nanofl.engine.Library;
import nanofl.engine.coloreffects.ColorEffect;
import nanofl.engine.elements.Element;
import nanofl.engine.geom.Point;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.movieclip.Layer;
import stdlib.Debug;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
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
	@:noCompletion function get_symbol() return cast(library.getItem(namePath), InstancableItem);
	
	public function new(namePath:String, ?name:String, ?colorEffect:ColorEffect, ?filters:Array<FilterDef>, ?blendMode:BlendModes, ?meshParams:MeshParams)
	{
		super();
		
		this.namePath = namePath;
		this.name = name;
		this.colorEffect = colorEffect;
		this.filters = filters ?? [];
		this.blendMode = blendMode ?? BlendModes.normal;
		this.meshParams = meshParams ?? new MeshParams();
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
		meshParams = MeshParams.load(node);
		
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
		meshParams = obj.meshParams != null ? MeshParams.loadJson(obj.meshParams) : null;
		
		return true;
    }
	
	#if ide
	override public function saveProperties(out:XmlBuilder) 
	{
		out.attr("libraryItem", namePath);
		out.attr("name", name, "");
		out.attr("blendMode", blendMode, BlendModes.normal);
			
        if (meshParams != null) meshParams.save(out);
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
		
		obj.blendMode = blendMode ?? BlendModes.normal;
			
        if (meshParams != null) obj.meshParams = meshParams.saveJson();
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
            NullTools.clone(meshParams)
		);
		obj.library = library;
		copyBaseProperties(obj);
		return obj;
	}
	
	public function isScene() return namePath == Library.SCENE_NAME_PATH;
	
	#if ide
	override public function getState() : nanofl.ide.undo.states.ElementState
	{
		return new nanofl.ide.undo.states.InstanceState
		(
			name,
			NullTools.clone(colorEffect),
			ArrayTools.clone(filters),
			blendMode,
            NullTools.clone(meshParams)
		);
	}
	
	override public function setState(state:nanofl.ide.undo.states.ElementState) : Void
	{
		name = (cast state:nanofl.ide.undo.states.InstanceState).name;
		colorEffect = NullTools.clone((cast state:nanofl.ide.undo.states.InstanceState).colorEffect);
		filters = ArrayTools.clone((cast state:nanofl.ide.undo.states.InstanceState).filters);
		blendMode = (cast state:nanofl.ide.undo.states.InstanceState).blendMode;
        meshParams = NullTools.clone((cast state:nanofl.ide.undo.states.InstanceState).meshParams);
	}
	#end
	
	override public function toString() return (parent != null ? parent.toString() + " / " : "") + "Instance(" + namePath + ")";
	
	///////////////////////////////////////////////////////////////////
	
	public var layers(get, never) : ArrayRO<Layer>;
	@:noCompletion public function get_layers()
	{
		return Std.isOfType(symbol, MovieClipItem) ? (cast symbol:MovieClipItem).layers : null;
	}
	
	public function createDisplayObject() : easeljs.display.DisplayObject
	{
		var dispObj = symbol.createDisplayObject();
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
            meshParams.applyToMesh((cast dispObj:nanofl.Mesh));
        }
    }

    public function updateDisplayObjectTweenedProperties(dispObj:easeljs.display.DisplayObject) : Void
    {
		elementUpdateDisplayObjectBaseProperties(dispObj);
		elementUpdateDisplayObjectInstanceProperties(dispObj);
    }
	
	public function getNavigatorName() return namePath;
	
	public function getNavigatorIcon() return symbol.getIcon();
	
	public function getChildren() : Array<Element>
	{
		var r = [];
		for (layer in layers)
		{
			if (layer.keyFrames.length > 0)
			{
				r = layer.keyFrames[0].elements.concat(r);
			}
		}
		return r;
	}
	
	public function getTimeline() : MovieClipItem
	{
		return Std.isOfType(symbol, MovieClipItem) ? cast symbol : null;
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
        if (!NullTools.equ((cast element:Instance).meshParams, meshParams)) return false;
		return true;
	}
	
	public function getFilters() : ArrayRO<FilterDef> return filters;
	public function setFilters(filters:Array<FilterDef>) : Void this.filters = filters;
}