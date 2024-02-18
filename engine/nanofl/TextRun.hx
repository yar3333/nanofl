package nanofl;

@:expose
class TextRun
{
	public var characters : String;
	public var fillColor : String;
	public var family = "Times";
	public var style = "";
	public var size : Float;
	public var align = "left";
	public var strokeSize = 0.0;
	public var strokeColor = "#000000";
	public var kerning = true;
	public var letterSpacing = 0.0;
	public var lineSpacing = 2.0;
	
	@:noapi public var backgroundColor : String;
	
	public function new(characters="", fillColor="#000000", size=12.0)
	{
		this.characters = characters;
		this.fillColor = fillColor;
		this.size = size;
	}
	
	public static function create
	(
		characters : String,
		fillColor : String,
		family : String,
		style : String,
		size : Float,
		align : String,
		strokeSize : Float,
		strokeColor : String,
		kerning : Bool,
		letterSpacing : Float,
		lineSpacing : Float
	) : TextRun
	{
		var r = new TextRun();
		r.characters = characters;
		r.fillColor = fillColor;
		r.family = family;
		r.style = style;
		r.size = size;
		r.align = align;
		r.strokeSize = strokeSize;
		r.strokeColor = strokeColor;
		r.kerning = kerning;
		r.letterSpacing = letterSpacing;
		r.lineSpacing = lineSpacing;
		return r;
	}
	
	public function getFontString() : String
	{
		return StringTools.trim
		(
			(style != null ? style : "") + " " +
			(size != null ? size + "px" : "") + " " +
			(family != null && family != "" ? family : "serif")
		);
	}
	
	public function clone() : TextRun
	{
		return duplicate();
	}
	
	public function duplicate(?characters:String) : TextRun
	{
		var r = TextRun.create
		(
			characters != null ? characters : this.characters,
			fillColor,
			family,
			style,
			size,
			align,
			strokeSize,
			strokeColor,
			kerning,
			letterSpacing,
			lineSpacing
		);
		r.backgroundColor = backgroundColor;
		return r;
	}
	
	public function equ(textRun:TextRun) : Bool
	{
		return characters == textRun.characters && equFormat(textRun);
	}
	
	public static function optimize(textRuns:Array<TextRun>) : Array<TextRun>
	{
		var i = 0; while (i < textRuns.length - 1)
		{
			if (textRuns[i].equFormat(textRuns[i + 1]))
			{
				textRuns[i].characters += textRuns[i + 1].characters;
				textRuns.splice(i + 1, 1);
			}
			else
			{
				i++;
			}
		}
		return textRuns;
	}
	
	public function createText(?color:String, ?outline:Float) : easeljs.display.Text
	{
		var r = new easeljs.display.Text(characters, getFontString(), color != null ? color : fillColor);
		if (outline != null) r.outline = outline;
		r.textBaseline = "alphabetic";
		r.textAlign = "left";
		return r;
	}
	
	public function isFilled() : Bool
	{
		return !isEmptyColor(fillColor);
	}
	
	public function isStroked() : Bool
	{
		return strokeSize != null && strokeSize != 0 && !isEmptyColor(strokeColor);
	}
	
	function isEmptyColor(s:String)
	{
		return s == null || s == "" 
			|| s == "transparent" || s == "none" 
			|| ~/^\s*rgba\s*\(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*,\s*0(?:\.0)?\s*\)$/i.match(s);
	}
	
	function equFormat(format:TextRun) : Bool
	{
		return fillColor == format.fillColor
			&& family == format.family
			&& style == format.style
			&& size == format.size
			&& align == format.align
			&& strokeSize == format.strokeSize
			&& strokeColor == format.strokeColor
			&& kerning == format.kerning
			&& letterSpacing == format.letterSpacing
			&& lineSpacing == format.lineSpacing;
	}
	
	#if ide
	public function applyFormat(format:TextRun) : TextRun
	{
		if (format.family != null) family = format.family;
		if (format.size != null) size = format.size;
		if (format.style != null) style = format.style;
		if (format.align != null) align = format.align;
		if (format.fillColor != null) fillColor = format.fillColor;
		if (format.strokeSize != null) strokeSize = format.strokeSize;
		if (format.strokeColor != null) strokeColor = format.strokeColor;
		if (format.letterSpacing != null) letterSpacing = format.letterSpacing;
		if (format.kerning != null) kerning = format.kerning;
		if (format.backgroundColor != null) backgroundColor = format.backgroundColor;
		if (format.lineSpacing != null) lineSpacing = format.lineSpacing;
		
		return this;
	}
	#end
}