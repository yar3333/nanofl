package components.nanofl.properties.character;

import nanofl.ide.PropertiesObject;
import nanofl.engine.Font;
import nanofl.engine.FontVariant;
import nanofl.TextRun;
using js.bootstrap.Select;
using StringTools;

class Code extends components.nanofl.properties.base.Code
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code,
		"slider": components.nanofl.common.slider.Code
	};

	var stdFonts : Array<Font>;
	var lastBindedFontOptions : String;
	
	override function init()
	{
		var stdFamilies =
		[
			[ "Georgia", "serif" ],
			[ "Palatino Linotype", "Book Antiqua", "Palatino", "serif" ],
			[ "Times New Roman", "Times", "serif" ],
			[ "Arial", "Helvetica", "sans-serif" ],
			[ "Arial Black", "Gadget", "sans-serif" ],
			[ "Comic Sans MS", "cursive", "sans-serif" ],
			[ "Impact", "Charcoal", "sans-serif" ],
			[ "Lucida Sans Unicode", "Lucida Grande", "sans-serif" ],
			[ "Tahoma", "Geneva", "sans-serif" ],
			[ "Trebuchet MS", "Helvetica", "sans-serif" ],
			[ "Verdana", "Geneva", "sans-serif" ],
			[ "Courier New", "Courier", "monospace" ],
			[ "Lucida Console", "Monaco", "monospace" ]
		];
		var stdVariants : Array<FontVariant> =
		[
			new FontVariant("normal", 400),
			new FontVariant("italic", 400),
			new FontVariant("normal", 700),
			new FontVariant("italic", 700)
		];
		stdFonts = stdFamilies.map(families -> { family:families[0], fallbacks:families.slice(1), variants:stdVariants });
		stdFonts.sort((a, b) -> Reflect.compare(a.family, b.family));
		
		template().family.selectpicker
		(
			new SelectOptionsBuilder()
			    .container("body")
			    .options
		);
		
		template().style.selectpicker(new SelectOptionsBuilder().container("body").options);
		
		super.init();
	}
	
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.TEXT(item, newObjectParams):
				show();
				
				bindFamilies(stdFonts.concat(library != null ? library.getFonts() : []));
				
				var format = item != null ? item.getSelectionFormat() : newObjectParams.textFormat;
				
				template().fillColor.value = format.fillColor;
				template().family.selectpicker().val(format.family);
				template().strokeSize.val(format.strokeSize);
				template().strokeColor.value = format.strokeColor;
				
				var style : String;
				if (format.style == null)
				{
					style = "";
				}
				else
				if (format.style.trim() == "")
				{
					style = "normal";
				}
				else
				{
					var styles = ~/\s+/.split(format.style.trim().toLowerCase());
					styles.sort(function(a, b) return a < b ? -1 : (a > b ? 1 : 0));
					style = styles.join(" ");
				}
				template().style.selectpicker().val(style);
				
				template().size.value = format.size;
				template().kerning.prop("checked", format.kerning);
				template().letterSpacing.prop("disabled", format.kerning);
				template().letterSpacing.val(format.letterSpacing);
				
			case _:
				hide();
		};
	}
	
	function family_change(_) 
	{
		var t = Type.createEmptyInstance(TextRun);
		t.family = template().family.val();
		if (t.family == "") t.family = null;
		changeProperties(t);
	}
	
	function style_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		var originalStyle = template().style.val();
		t.style = switch (originalStyle)
		{
			case "": null;
			case "normal": "";
			case _: originalStyle;
		};
		changeProperties(t);
	}
	
	function size_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.size = template().size.value;
		if (Math.isNaN(t.size)) t.size = null;
		changeProperties(t);
	}
	
	function fillColor_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.fillColor = template().fillColor.value;
		changeProperties(t);
	}
	
	function strokeSize_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.strokeSize = Std.parseFloat(template().strokeSize.val());
		changeProperties(t);
	}
	
	function strokeColor_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.strokeColor = template().strokeColor.value;
		changeProperties(t);
	}
	
	function letterSpacing_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.letterSpacing = Std.parseFloat(template().letterSpacing.val());
		changeProperties(t);
	}
	
	function kerning_change(_)
	{
		var t = Type.createEmptyInstance(TextRun);
		t.kerning = template().kerning.prop("checked");
		template().letterSpacing.prop("disabled", t.kerning);
		changeProperties(t);
	}
	
	function changeProperties(format:TextRun)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.TEXT(item, newObjectParams):
				for (name in Reflect.fields(format))
				{
					var value = Reflect.field(format, name);
					if (value != null) Reflect.setField(newObjectParams.textFormat, name, value);
				}
				
				if (item != null)
				{
					undoQueue.beginTransaction({ element:item.originalElement });
					item.setSelectionFormat(format);
					fireChangeEvent();
				}
				
			case _:
		}
	}
	
	@:profile
	function bindFamilies(fonts:Array<Font>)
	{
		var fontOptions = fonts.map(function(font) return
			"<option value='" + font.family + "' data-content='"
				+ "<span style=&quot;font-family:" + [ font.family ].concat(font.fallbacks).join(",") + ";display:inline-block;overflow-x:hidden&quot;>" + font.family + "</span>"
			+ "'>" + font.family + "</option>");
		fontOptions.unshift("<option value=''>&nbsp;</option>");
		
		var fontOptions = fontOptions.join("");
		if (fontOptions != lastBindedFontOptions)
		{
			lastBindedFontOptions = fontOptions;
			template().family.html(fontOptions);
			template().family.selectpicker().refresh();
		}
	}
}