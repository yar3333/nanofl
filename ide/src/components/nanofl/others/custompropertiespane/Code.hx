package components.nanofl.others.custompropertiespane;

import js.html.Element;
import js.Browser;
import js.html.TemplateElement;
import wquery.Event;
import haxe.Serializer;
import nanofl.engine.CustomPropertiesTools;
import nanofl.engine.CustomProperty;
import wquery.ComponentList;

class Code extends wquery.Component
{
	var event_preChange = new Event<{}>();
	var event_change = new Event<{}>();
	
	var ints       : ComponentList<components.nanofl.others.custompropertiespane.item_int.Code>;
	var floats     : ComponentList<components.nanofl.others.custompropertiespane.item_float.Code>;
	var sliders    : ComponentList<components.nanofl.others.custompropertiespane.item_slider.Code>;
	var colors     : ComponentList<components.nanofl.others.custompropertiespane.item_color.Code>;
	var strings    : ComponentList<components.nanofl.others.custompropertiespane.item_string.Code>;
	var bools      : ComponentList<components.nanofl.others.custompropertiespane.item_bool.Code>;
	var lists      : ComponentList<components.nanofl.others.custompropertiespane.item_list.Code>;
	var delimiters : ComponentList<components.nanofl.others.custompropertiespane.item_delimiter.Code>;
	var infos      : ComponentList<components.nanofl.others.custompropertiespane.item_info.Code>;
	var files      : ComponentList<components.nanofl.others.custompropertiespane.item_file.Code>;
	
	public var properties : Array<CustomProperty>;
	public var params : Dynamic;
	
	function init()
	{
		var container = template().container;
		
		ints       = new ComponentList(components.nanofl.others.custompropertiespane.item_int.Code,       this, container);
		floats     = new ComponentList(components.nanofl.others.custompropertiespane.item_float.Code,     this, container);
		sliders    = new ComponentList(components.nanofl.others.custompropertiespane.item_slider.Code,    this, container);
		colors     = new ComponentList(components.nanofl.others.custompropertiespane.item_color.Code,     this, container);
		strings    = new ComponentList(components.nanofl.others.custompropertiespane.item_string.Code,    this, container);
		bools      = new ComponentList(components.nanofl.others.custompropertiespane.item_bool.Code,      this, container);
		lists      = new ComponentList(components.nanofl.others.custompropertiespane.item_list.Code,      this, container);
		delimiters = new ComponentList(components.nanofl.others.custompropertiespane.item_delimiter.Code, this, container);
		infos      = new ComponentList(components.nanofl.others.custompropertiespane.item_info.Code,      this, container);
		files      = new ComponentList(components.nanofl.others.custompropertiespane.item_file.Code,      this, container);
	}
	
	public function bind(properties:Array<CustomProperty>, params:Dynamic)
	{
		this.properties = properties;
		this.params = params;
		
		CustomPropertiesTools.fix(params, properties);
		
		clear();
		
		for (p in properties)
		{
			var data: Dynamic =
			{
				name: p.name,
				label: p.label != null ? processLabel(p.label) : p.name,
				title: p.description != null ? p.description : "",
				value: Reflect.field(params, p.name),
				units: p.units != null ? p.units : "",
				minValue: p.minValue != null ? p.minValue : null,
				maxValue: p.maxValue != null ? p.maxValue : null,
				options: p.values != null ? p.values.map(s -> "<option>" + s + "</option>") : null,
				onChange: updateParams.bind(p.name, _)
			};
			
			switch (p.type)
			{
				case "int":
	    			data.label = data.label + ":";
					ints.create(data);
					
				case "float":
					data.label = data.label + ":";
					floats.create(data);
                
                case "slider":
    				sliders.create(data);
					
				case "color":
					data.label = data.label + ":";
					colors.create(data);
					
				case "string":
					data.label = data.label + ":";
					strings.create(data);
					
				case "bool":
					bools.create(data);
					
				case "list":
					data.label = data.label + ":";
					lists.create(data);
					
				case "delimiter":
					delimiters.create(null);
					
				case "info":
                    data.onChange = null;
					infos.create(data);
					
				case "file":
					data.label = data.label + ":";
                    data.fileFilters = Serializer.run(p.fileFilters);
					files.create(data);
			}
			
			for (elem in template().container.find("[title=]"))
			{
				elem.removeAttr("title");
			}
		}
	}
	
	public function clear()
	{
		ints.clear();
		floats.clear();
		sliders.clear();
		colors.clear();
		strings.clear();
		bools.clear();
		lists.clear();
		files.clear();
		delimiters.clear();
		infos.clear();
	}
	
	function updateParams(name:String, value:Dynamic)
	{
		event_preChange.emit({});
		
		Reflect.setField(params, name, value);
		CustomPropertiesTools.fix(params, properties);
		
		event_change.emit({});
	}

    static function processLabel(html:String) : String
    {
        final r : TemplateElement = cast Browser.document.createElement("template");
		try r.innerHTML = html
		catch (e:Dynamic) return "[html parse error]";

        function processLabelInner(node:Element)
        {
            if (node.tagName == "A")
            {
                node.setAttribute("target", "_blank");
            }
            for (child in node.children) processLabelInner(child);
        }

        processLabelInner(cast r.content);

        return r.innerHTML;
    }
}