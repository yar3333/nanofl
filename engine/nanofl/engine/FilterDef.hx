package nanofl.engine;

import nanofl.engine.plugins.FilterPlugins;
import stdlib.Debug;
using Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class FilterDef
{
	public var name(default, null) : String;
	
	var _params : Dynamic;
	public var params(get, never) : Dynamic;
	
	var isParamsFixed : Bool;
	function get_params() : Dynamic
	{
		if (isParamsFixed || !FilterPlugins.plugins.exists(name)) return _params;
		isParamsFixed = true;
		return CustomPropertiesTools.fix(_params, getProperties());
	}

	public function new(name:String, params:Dynamic) : Void
	{
		Debug.assert(params != null);
		
		this.name = name;
		this._params = params;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement, version:String) : FilterDef
	{
		if (node == null) return null;
		
		var params = {};
		for (attr in node.attributes)
		{
			Reflect.setField(params, attr.name, attr.value);
		}
		
		var name = Version.handle(version,
		[
			"1.0.0" => function()
			{
				if (node.name != "BlurFilter") return node.name;
				
				fixParam(params, "blurX", s -> Std.string(Std.parseInt(s) * 2));
				fixParam(params, "blurY", s -> Std.string(Std.parseInt(s) * 2));
				return "BoxBlurFilter";
			},
			
			"2.0.0" => function()
			{
				return node.name;
			}
		]);
		
		return new FilterDef(name, params);
	}
    #end
	
	public static function loadJson(obj:Dynamic, version:String) : FilterDef
	{
		return new FilterDef(obj.name, obj.params);
	}
	
    #if ide
	public function save(out:XmlBuilder) : Void
    {
        out.begin(name);
        
        var names = Reflect.fields(_params);
        names.sort(Reflect.compare);
        
        for (name in names)
        {
            out.attr(name, Reflect.field(_params, name));
        }
        out.end();
    }

    public function saveJson() : Dynamic
    {
        return
        { 
            name : name,
            params : _params,
        };
    }
    #end

	public function equ(filter:FilterDef) : Bool
	{
		return filter.name == name && CustomPropertiesTools.equ(filter.params, params);
	}
	
	public function clone() : FilterDef
	{
		var r = new FilterDef(name, Reflect.copy(_params));
		r.isParamsFixed = isParamsFixed;
		return r;
	}
	
	static function fixParam(params:Dynamic<String>, name:String, fixFunc:String->String) : Void
	{
		if (Reflect.hasField(params, name))
		{
			Reflect.setField(params, name, fixFunc(Reflect.field(params, name)));
		}
	}
	
	public function tween(t:Float, finish:FilterDef) : FilterDef
	{
		Debug.assert(finish == null || name == finish.name, name + " != " + finish.name);
		
		if (t == 0.0 || !FilterPlugins.plugins.exists(name)) return this;
		var plugin = FilterPlugins.plugins.get(name);
		CustomPropertiesTools.tween(params, t, finish != null ? finish.params : null, plugin != null ?  plugin.properties : null);
		return this;
	}
	
	public function getFilter() : easeljs.filters.Filter
	{
		return FilterPlugins.plugins.exists(name) ? FilterPlugins.plugins.get(name).getFilter(params) : null;
	}
	
	public function getLabel() : String
	{
		return FilterPlugins.plugins.exists(name) ? FilterPlugins.plugins.get(name).label : name;
	}
	
	public function getProperties() : Array<CustomProperty>
	{
		return FilterPlugins.plugins.exists(name) ? FilterPlugins.plugins.get(name).properties : [];
	}
	
	public function resetToNeutral() : FilterDef
	{
		var plugin = FilterPlugins.plugins.get(name);
		if (plugin != null)
		{
			CustomPropertiesTools.resetToNeutral(params, plugin.properties);
		}
		return this;
	}
}
