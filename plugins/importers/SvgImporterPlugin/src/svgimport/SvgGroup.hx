package svgimport;

import htmlparser.HtmlNodeElement;
import svgimport.gradients.Gradient;
using htmlparser.HtmlParserTools;
using StringTools;
using svgimport.XmlTools;

class SvgGroup extends SvgDisplayObject
{
	public var name : String;
	public var children = new Array<SvgElement>();
	
	public function new(svg:Svg, node:HtmlNodeElement, baseStyles:Map<String, String>, ?id:String) : Void
	{
		super(svg, node, baseStyles, id);
		
		if (this.id != "") svg.elements.set(this.id, SvgElement.DisplayGroup(this));
		
		name = node.getAttr("inkscape:label", this.id);
		
		loadChildren(node, XmlTools.getStyles(node, baseStyles));
	}
	
	function loadChildren(xml:HtmlNodeElement, styles:Map<String, String>)
	{
		for (child in xml.children)
		{
			switch (XmlTools.normalizeTag(child.name))
			{
				case "defs":
					loadDefs(child);
					
				case "g":
					children.push(SvgElement.DisplayGroup(new SvgGroup(svg, child, styles)));
					
				case"use":
					var use = new SvgUse(svg, child, styles);
					if (use.groupID != null) children.push(SvgElement.DisplayUse(use));
					
				case "path", "line", "polyline", "rect", "polygon", "ellipse", "circle":
					children.push(SvgElement.DisplayPath(new SvgPath(svg, child, styles)));
					
				case "text":
					children.push(SvgElement.DisplayText(new SvgText(child, styles, svg.gradients)));
					
				case "linearGradient":
					loadGradient(child);
					
				case "radialGradient":
					loadGradient(child);
					
				case "a":
					loadChildren(child, styles);
					
				case _:
					trace("Unknown tag '" + child.name + "'.");
			}
		}
	}
	
	function loadDefs(defsNode:HtmlNodeElement)
	{
		for (child in defsNode.children)
		{
			switch (XmlTools.normalizeTag(child.name))
			{
				case "linearGradient":	loadGradient(child);
				case "radialGradient":	loadGradient(child);
				case "g":				new SvgGroup(svg, child, null);
				case "path", "line", "polyline", "rect", "polygon", "ellipse", "circle": new SvgPath(svg, child, null);
				case "clipPath":		new SvgGroup(svg, child, [ "stroke"=>"none", "fill"=>"red" ]);
				case "filter":			new SvgFilter(svg, child);
				case _:					trace("Unknown tag '" + child.name + "'.");
			}
		}
		
		for (child in defsNode.children)
		{
			switch (XmlTools.normalizeTag(child.name))
			{
				case "linearGradient":	loadGradient(child);
				case "radialGradient":	loadGradient(child);
				case _:
			}
		}
	}
	
	function loadGradient(node:HtmlNodeElement) : Void
	{
		var baseID = XmlTools.getIdFromXlink(node);
		if (baseID == null || svg.gradients.exists(baseID))
		{
			var id = node.getAttribute("id");
			if (!svg.gradients.exists(id))
			{
				svg.gradients.set(id, Gradient.load(svg, node, baseID != null ? svg.gradients.get(baseID) : null));
			}
		}
	}
}
