package components.nanofl.popups.fontpropertiespopup;

import haxe.io.Path;
import nanofl.engine.FontVariant;
import nanofl.engine.libraryitems.FontItem;
import nanofl.ide.Application;
import wquery.ComponentList;
using js.jquery.FormValidating;
using StringTools;
using stdlib.Lambda;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var app : Application;
	
    var font : FontItem;
    
    var variants : ComponentList<components.nanofl.popups.fontpropertiespopup.item.Code>;
	
	override function init()
	{
		super.init();
		
		variants = new ComponentList<components.nanofl.popups.fontpropertiespopup.item.Code>(components.nanofl.popups.fontpropertiespopup.item.Code, this, template().variantsPlaceholder);
	}
	
	public function show(?font:FontItem)
	{
		this.font = font;
		
		variants.clear();
		
		if (font == null)
		{
			template().title.html("Add Font");
			template().family.val("");
			template().family.removeAttr("readonly");
			addVariant_click(null);
		}
		else
		{
			template().title.html("Font Properties");
			template().family.val(Path.withoutDirectory(font.namePath));
			template().family.attr("readonly", "readonly");
			if (font.variants.length > 0)
			{
				for (variant in font.variants)
				{
					var v = variants.create
					({
						locals: variant.locals.join("\n"),
						formatAndUrls: variant.urls.keys().sorted().map(function(format) return format + ": " + variant.urls.get(format)).join("\n"),
						addVariant: "none",
						removeVariant: ""
					});
					v.q("#style").val(variant.style);
					v.q("#weight").val(variant.weight);
				}
			}
			else
			{
				addVariant_click(null);
			}
		}
		
		showPopup();
	}
	
	function addVariant_click(e)
	{
		if (e != null) e.preventDefault();
		var variant = variants.create({ locals: "", formatAndUrls: "" });
		
		variant.event_removeVariant.on(function(e)
		{
			variants.remove(variant);
			if (getValidVariantItems().length == 0) addVariant_click(null);
		});
	}
	
	override function ok_click(_)
	{
		if (!template().popup.find("input[id$=-url]").checkValidaty()) return;
		
		if (font == null)
		{
			var family = template().family.val().trim();
			if (app.document.library.hasItem(family))
			{
				js.Browser.alert("Symbol '" + family + "' already exists. Change family name, please.");
				template().family.focus();
				return;
			}
			
			app.document.undoQueue.beginTransaction({ libraryAddItems:true });
			
			app.document.library.addFont(family, getFontVariantsFromInputs());
			
			app.document.undoQueue.commitTransaction();
		}
		else
		{
			app.document.undoQueue.beginTransaction({ libraryChangeItems:[ font.namePath ] });
			
			font.variants = getFontVariantsFromInputs();
			
			app.document.undoQueue.commitTransaction();
		}
		
		template().ok.addClass('disabled');
		
		app.document.library.preload().then(function(_)
		{
			template().ok.removeClass('disabled');
			app.document.library.update();
			hide();
			app.document.library.update();
		});
	}
	
	function getFontVariantsFromInputs() : Array<FontVariant>
	{
		var variants = [];
		for (item in getValidVariantItems())
		{
			variants.push(new FontVariant
			(
				item.q("#style").val(),
				Std.parseInt(item.q("#weight").val()),
				item.q("#locals").val().split("\n").map(StringTools.trim).filter(function(s) return s != ""),
				parseFormatAndUrls(item.q("#formatAndUrls").val())
			));
		}
		return variants;
	}
	
	function getValidVariantItems() : Array<components.nanofl.popups.fontpropertiespopup.item.Code>
	{
		var r = [];
		for (i in 0...variants.length)
		{
			var item = variants.getByIndex(i);
			if (item.q("#style").length > 0)
			{
				r.push(item);
			}
		}
		return r;
	}
	
	function parseFormatAndUrls(s:String) : Map<String, String>
	{
		var r = new Map();
		
		var lines = ~/[\r\n]|[<]br[>]/gi.split(s);
		for (line in lines)
		{
			var n = line.indexOf(":");
			if (n > 0)
			{
				var format = line.substring(0, n).trim();
				var url = line.substring(n + 1).trim();
				if (format != "" && url != "")
				{
					r.set(format, url);
				}
			}
		}
		
		return r;
	}
}