package nanofl.ide.ui;

import htmlparser.XmlBuilder;
using StringTools;

class IconTools
{
	public static function parse(icon:String) : { iconClass:String, iconStyle:String }
	{
		if (icon == null || icon == "")
		{
			return { iconClass:"icon-empty", iconStyle:"" };
		}
		else
		{
			return
			{
				iconClass: !icon.startsWith("url(") && icon != "" ? icon : "icon-empty",
				iconStyle: icon.startsWith("url(") ? "background:" + icon : ""
			};
		}
	}
	
	public static function toHtml(icon:String)
	{
		var data = parse(icon);
		return "<i"
				+ (data.iconClass != "" ? " class='" + data.iconClass + "'" : "") 
				+ (data.iconStyle != "" ? " style='" + data.iconStyle + "'" : "")
			+ "></i>";
	}
	
	public static function write(icon:String, out:XmlBuilder) : XmlBuilder
	{
		var data = parse(icon);
		
		out.begin("i");
			if (data.iconClass != "") out.attr("class", data.iconClass);
			if (data.iconStyle != "") out.attr("style", data.iconStyle);
			out.content("");
		out.end();
		
		return out;
	}
}