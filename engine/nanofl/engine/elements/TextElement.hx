package nanofl.engine.elements;

import datatools.ArrayTools;
import nanofl.TextRun;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.BoundsTools;
using stdlib.StringTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class TextElement extends Element
{
	function get_type() return ElementType.text;
	
    public var name : String;
	
	public var width : Float;
	public var height : Float;
	public var selectable : Bool;
	public var border : Bool;
	
	public var textRuns : Array<TextRun>;
	
	public var newTextFormat : TextRun;
	
	public function new(name:String, width:Float, height:Float, selectable:Bool, border:Bool, textRuns:Array<TextRun>, ?newTextFormat:TextRun)
	{
		super();
		
		this.name = name;
		this.width = width;
		this.height = height;
		this.selectable = selectable;
		this.border = border;
		this.textRuns = textRuns;
		this.newTextFormat = newTextFormat != null ? newTextFormat : new TextRun();
	}
	
	#if ide
    override function loadProperties(base:HtmlNodeElement, version:String) : Bool
	{
		if (!super.loadProperties(base, version)) return false;
		
		name = base.getAttr("name", "");
		
		width = base.getAttr("width", 0.0);
		height = base.getAttr("height", 0.0);
		selectable = base.getAttr("selectable", false);
		border = base.getAttr("border", false);
		
		textRuns = [];
		for (node in base.children)
		{
			switch (node.name)
			{
				case "text-run":
					var textRun = loadTextRun(node);
					if (!textRun.characters.isNullOrEmpty()) textRuns.push(textRun);
					
				case "new-text-format":
					newTextFormat = loadTextRun(node);
					
				case _: // unknow node => ignore
			}
		}
		
		return true;
	}
    #end

    override function loadPropertiesJson(obj:Dynamic, version:String) : Bool
    {
        if (!super.loadPropertiesJson(obj, version)) return false;

        name = obj.name ?? "";
		
		width = obj.width ?? 0.0;
		height = obj.height ?? 0.0;
		selectable = obj.selectable ?? false;
		border = obj.border ?? false;
		
		textRuns = (cast obj.textRuns : Array<Dynamic>)
                        .map(x -> loadTextRunJson(x))
                        .filter(x -> !x.characters.isNullOrEmpty());

        newTextFormat = loadTextRunJson(obj.newTextFormat);
		
		return true;
    }
    
	#if ide
	override function saveProperties(out:XmlBuilder)
	{
		out.attr("name", name, "");
		super.saveProperties(out);
		out.attr("width", width);
		out.attr("height", height);
		out.attr("selectable", selectable, false);
		out.attr("border", border, false);
		
		saveTextRun(newTextFormat, "new-text-format", out);
		
		for (textRun in textRuns)
		{
			saveTextRun(textRun, "text-run", out);
		}
	}
	
	override function savePropertiesJson(obj:Dynamic) : Void
	{
		obj.name = name ?? "";
		super.savePropertiesJson(obj);
		obj.width = width;
		obj.height = height;
		obj.selectable = selectable ?? false;
		obj.border = border ?? false;
		obj.newTextFormat = saveTextRunJson(newTextFormat);
        obj.textRuns = textRuns.map(saveTextRunJson);
	}
	
	function saveTextRun(textRun:TextRun, tag:String, out:XmlBuilder)
	{
		out.begin(tag);
		out.attr("characters", textRun.characters);
		out.attr("fillColor", textRun.fillColor);
		out.attr("align", textRun.align, "left");
		out.attr("size", textRun.size);
		out.attr("style", textRun.style, "");
		out.attr("family", textRun.family, "Times");
		out.attr("strokeSize", textRun.strokeSize, 0.0);
		out.attr("strokeColor", textRun.strokeColor, "#000000");
		out.attr("kerning", textRun.kerning, true);
		out.attr("letterSpacing", textRun.letterSpacing, 0.0);
		out.attr("lineSpacing", textRun.lineSpacing, 2.0);
		out.end();
	}
	
	function saveTextRunJson(textRun:TextRun) : Dynamic
	{
        return
        {
            characters: textRun.characters,
            fillColor: textRun.fillColor,
            align: textRun.align ?? "left",
            size: textRun.size,
            style: textRun.style ?? "",
            family: textRun.family ?? "Times",
            strokeSize: textRun.strokeSize ?? 0.0,
            strokeColor: textRun.strokeColor ?? "#000000",
            kerning: textRun.kerning ?? true,
            letterSpacing: textRun.letterSpacing ?? 0.0,
            lineSpacing: textRun.lineSpacing ?? 2.0,
        };
	}
    
    function loadTextRun(node:HtmlNodeElement) : TextRun
	{
		return TextRun.create
		(
			node.getAttr("characters"),
			node.getAttr("fillColor", "#000000"),
			node.getAttr("family", "Times"),
			node.getAttr("style", ""),
			node.getAttr("size", 12.0),
			node.getAttr("align", "left"),
			node.getAttr("strokeSize", 0.0),
			node.getAttr("strokeColor", "#000000"),
			node.getAttr("kerning", true),
			node.getAttr("letterSpacing", 0.0),
			node.getAttr("lineSpacing", 2.0)
		);
	}
    #end
	
	function loadTextRunJson(obj:Dynamic) : TextRun
	{
		return TextRun.create
		(
			obj.characters,
			obj.fillColor ?? "#000000",
			obj.family ?? "Times",
			obj.style ?? "",
			obj.size ?? 12.0,
			obj.align ?? "left",
			obj.strokeSize ?? 0.0,
			obj.strokeColor ?? "#000000",
			obj.kerning ?? true,
			obj.letterSpacing ?? 0.0,
			obj.lineSpacing ?? 2.0,
		);
	}
	
	public function getText() : String
	{
		return textRuns.map(tr -> tr.characters).join("");
	}
	
	public function createDisplayObject(frameIndexes:Array<{ element:IPathElement, frameIndex:Int }>) : nanofl.TextField
	{
        final tf = new nanofl.TextField();
		
		updateDisplayObjectBaseProperties(tf);
		
        tf.name = name;
		
		tf.width = width;
		tf.height = height;
		tf.selectable = selectable;
		tf.border = border;
		#if !ide
		tf.textRuns = ArrayTools.clone(textRuns);
		#else
		tf.textRuns = textRuns;
		#end
		tf.newTextFormat = newTextFormat;
		
		tf.setBounds(0.5, 0.5, width, height);
		
		return tf;
	}
	
	public function getMinSize(dispObj:easeljs.display.DisplayObject) : { width:Float, height:Float }
	{
		stdlib.Debug.assert(Std.isOfType(dispObj, nanofl.TextField));
		
		return { width:(cast dispObj:nanofl.TextField).minWidth, height:(cast dispObj:nanofl.TextField).minHeight };
	}
	
	override function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		var bounds = { minX:0.0, minY:0.0, maxX:width, maxY:height };
		return [ bounds.getNearestPoint(pos) ];
	}
	
	#if ide
	override public function getState() : nanofl.ide.undo.states.ElementState 
	{
		return new nanofl.ide.undo.states.TextState(width, height, selectable, border, ArrayTools.clone(textRuns), newTextFormat);
	}
	
	override public function setState(_state:nanofl.ide.undo.states.ElementState)
	{
		var state = cast(_state, nanofl.ide.undo.states.TextState);
		width = state.width;
		height = state.height;
		selectable = state.selectable;
		border = state.border;
		textRuns = ArrayTools.clone(state.textRuns);
		newTextFormat = state.newTextFormat;
	}
	#end
	
	override public function equ(element:Element) : Bool 
	{
		if (!super.equ(element)) return false;
		if ((cast element:TextElement).name != name) return false;
		if ((cast element:TextElement).width != width) return false;
		if ((cast element:TextElement).height != height) return false;
		if ((cast element:TextElement).selectable != selectable) return false;
		if ((cast element:TextElement).border != border) return false;
		if (!ArrayTools.equ((cast element:TextElement).textRuns, textRuns)) return false;
		if (!(cast element:TextElement).newTextFormat.equ(newTextFormat)) return false;
		return true;
	}
	
	public function clone() : TextElement
	{
		var obj = new TextElement
		(
			name,
			width,
			height,
			selectable,
			border,
			ArrayTools.clone(textRuns),
			newTextFormat.clone()
		);
		copyBaseProperties(obj);
		return obj;
	}
	
	#if ide
	public function breakApart() : Array<TextElement>
	{
		var tf = createDisplayObject(null);
		tf.update();
		
		var r = [];
		
		var y = tf.y;
		for (line in tf.textLines)
		{
			var x = tf.x + (line.chunks.length > 0 ? line.chunks[0].bounds.x : 0);
			for (chunk in line.chunks)
			{
				for (c in chunk.text.text.split(""))
				{
					var run = chunk.format.duplicate(c);
					
					var newTextElement = new TextElement("", 0, 0, selectable, border, [ run ], newTextFormat.duplicate());
					newTextElement.matrix.tx = x;
					newTextElement.matrix.ty = y + (chunk.bounds.y - line.minY);
					
					r.push(newTextElement);
					
					x += run.createText().getMeasuredWidth();
				}
			}
			y += (line.maxY - line.minY) + line.spacing;
		}
		
		return r;
	}
	#end
	
	#if ide
	override public function fixErrors() : Bool 
	{
		var tf = createDisplayObject(null);
		tf.update();
		if (width < tf.width || height < tf.height)
		{
			width = tf.width;
			height = tf.height;
			return true;
		}
		return false;
	}
	#end
}