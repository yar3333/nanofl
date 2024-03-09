package nanofl.engine.elements;

import datatools.ArrayRO;
import datatools.ArrayTools;
using stdlib.Lambda;

class Elements
{
    #if ide
	public static function parse(base:htmlparser.HtmlNodeElement, version:String) : Array<Element>
	{
		var elements = new Array<Element>();
		
		for (node in base.children)
		{
    		elements.addRange(Element.parse(node, version) ?? []);
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