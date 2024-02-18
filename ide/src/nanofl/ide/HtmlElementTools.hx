package nanofl.ide;

import js.html.Element;
import stdlib.Debug;
using StringTools;

class HtmlElementTools
{
	public static function hasClass(elem:Element, className:String) : Bool
	{
		Debug.assert(className.split(" ").length == 1);
		
		var s = elem.getAttribute("class");
		if (s == null) return false;
		
		var n = 0; while (n < s.length)
		{
			n = s.indexOf(className, n);
			if (n < 0) return false;
			if ((n == 0 || s.charAt(n - 1) == " ") && (n + className.length == s.length || s.charAt(n + className.length) == " ")) return true;
			n += className.length;
		}
		
		return false;
	}
	
	public static function addClass(elem:Element, className:String) : Element
	{
		Debug.assert(className.split(" ").length == 1);
		
		if (hasClass(elem, className)) return elem;
		elem.setAttribute("class", elem.getAttribute("class") + " " + className);
		return elem;
	}
	
	public static function removeClass(elem:Element, className:String) : Element
	{
		Debug.assert(className.split(" ").length == 1);
		
		var s = elem.getAttribute("class");
		if (s == null) return elem;
		
		var n = 0; while (n < s.length)
		{
			n = s.indexOf(className, n);
			if (n < 0) return elem;
			if ((n == 0 || s.charAt(n - 1) == " ") && (n + className.length == s.length || s.charAt(n + className.length) == " "))
			{
				elem.setAttribute("class", s.substring(0, n).rtrim() + " " + s.substring(n + className.length).ltrim());
				return elem;
			}
			n += className.length;
		}
		
		return elem;
	}
	
	public static function toggleClass(elem:Element, className:String, ?b:Bool) : Element
	{
		Debug.assert(className.split(" ").length == 1);
		
		if (b == null) b = !hasClass(elem, className);
		
		if (b) return addClass(elem, className);
		return removeClass(elem, className);
	}
}