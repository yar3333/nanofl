package nanofl.engine.elements;

import datatools.ArrayRO;
import datatools.ArrayTools;

class Elements
{
    #if ide
	public static function parse(base:htmlparser.HtmlNodeElement, version:String) : Array<Element>
	{
		var elements = new Array<Element>();
		
		for (node in base.children)
		{
			var element = Element.parse(node, version);
			if (element != null)
			{
				elements.push(element);
			}
		}
		
		return elements;
	}
    #end

	public static function parseJson(obj:Array<Dynamic>, version:String) : Array<Element>
	{
		var elements = new Array<Element>();
		
		for (itemObj in obj)
		{
			var element = Element.parseJson(itemObj, version);
			if (element != null)
			{
				elements.push(element);
			}
		}
		
		return elements;
	}
	
	public static function expandGroups(elements:ArrayRO<Element>) : Array<Element>
	{
		var r = new Array<Element>();
		for (element in elements)
		{
			if (Std.isOfType(element, GroupElement))
			{
				r = r.concat(expandGroups((cast element:GroupElement).getChildren()));
			}
			else
			{
				r.push(element);
			}
		}
		return r;
	}
	
	#if ide
	public static function getUsedSymbolNamePaths<Element:{ function getUsedSymbolNamePaths() : Array<String>; }>(elements:ArrayRO<Element>) : Array<String>
	{
		var r = [];
		
		for (element in elements)
		{
			ArrayTools.appendUniqueFast(r, element.getUsedSymbolNamePaths());
		}
		
		return r;
	}
	#end
}