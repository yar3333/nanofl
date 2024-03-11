package nanofl.engine.elements;

import datatools.ArrayRO;
import datatools.ArrayTools;
using stdlib.Lambda;

class Elements
{
    #if ide
	public static function parse(base:htmlparser.HtmlNodeElement, version:String) : Array<Element>
	{
		return base.children.map(x -> Element.parse(x, version)).filter(x -> x != null);
	}
    #end

	public static function parseJson(obj:Array<Dynamic>, version:String) : Array<Element>
	{
		return obj.map(x -> Element.parseJson(x, version)).filter(x -> x != null);
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