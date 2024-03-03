package components.nanofl.popups.textureatlasespopup;

import nanofl.ide.Application;
import nanofl.engine.ITextureItem;
import nanofl.ide.libraryitems.FolderItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.textureatlas.TextureAtlasParams;
import nanofl.ide.ui.Popups;
import stdlib.Std;
using stdlib.Lambda;
using stdlib.StringTools;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	static var imports =
	{
		"library-view": components.nanofl.library.libraryview.Code
	};
	
	static inline var HEADER_HEIGHT = 350;
	
	@inject var app : Application;
	@inject var popups : Popups;
	
	var textureAtlases : Map<String, TextureAtlasParams>;
	
	override function init()
	{
		super.init();
		
		template().library.readOnly = true;
		template().library.filterItems = function(item)
		{
			return isItemNotUsed(item) 
			    || Std.isOfType(item, FolderItem) && isFolderContains((cast item:FolderItem), isItemNotUsed);
		};
		
		template().atlas.readOnly = true;
		template().atlas.filterItems = function(item)
		{
			return isItemUsed(template().atlases.val(), item)
			    || Std.isOfType(item, FolderItem) && isFolderContains((cast item:FolderItem), isItemUsed.bind(template().atlases.val()));
		};
	}
	
	public function show(textureAtlases:Map<String, TextureAtlasParams>)
	{
        this.textureAtlases = textureAtlases;

		showPopup();
		
		var w = Std.max(100, Std.min(400, Math.round(q(js.Browser.window).width() / 2) - 100));
		var h = Std.max(200, q(js.Browser.window).innerHeight() - HEADER_HEIGHT);
		template().library.resize(w, h);
		template().atlas.resize(w, h);
		
		center();
		
		for (item in app.document.library.getItems().filterByType(ITextureItem))
		{
            if (!StringTools.isNullOrEmpty(item.textureAtlas) && !textureAtlases.exists(item.textureAtlas))
            {
                textureAtlases.set(item.textureAtlas, new TextureAtlasParams());
            }
		}
		
		updateAtlasSelector();
		
		template().library.update();
		template().atlas.update();
	}
	
	override function onOK()
	{
		for (name in textureAtlases.keys())
		{
			if (isEmptyAtlas(name)) textureAtlases.remove(name);
		}
	}
	
	function newAtlas_click(_)
	{
		var names = template().atlases.find(">option").map(x -> x.attr("value"));
		
		var i = names.length; while (names.indexOf("atlas_" + i) >= 0) i++;
		
		popups.textureAtlasProperties.show("atlas_" + i, new TextureAtlasParams(), e ->
		{
            if (e.name == "") return;
            
            if (textureAtlases.exists(e.name))
            {
                js.Browser.window.alert("Texture Atlas '" + e.name + "' already exists.");
                return;
            }

            textureAtlases.set(e.name, e.params);
            updateAtlasSelector();
            template().atlases.val(e.name);
            template().atlas.update();
		});
	}
	
	function deleteAtlas_click(_)
	{
		var name = template().atlases.val();
		if (name != null)
		{
			for (item in app.document.library.getItems())
			{
				if (Std.isOfType(item, ITextureItem))
				{
					if ((cast item:ITextureItem).textureAtlas == name)
					{
						(cast item:ITextureItem).textureAtlas = null;
					}
				}
			}
			textureAtlases.remove(name);
			updateAtlasSelector();
			template().library.update();
			template().atlas.update();
		}
	}
	
	function atlasProperties_click(_)
	{
		var name = template().atlases.val();
		popups.textureAtlasProperties.show(name, textureAtlases.get(name), function(e)
		{
			renameAtlasInLibrary(name, e.name);
			textureAtlases.set(e.name, e.params);
			if (e.name != name) textureAtlases.remove(name);
			updateAtlasSelector();
		});
	}
	
	function renameAtlasInLibrary(oldName:String, newName:String)
	{
		if (newName != oldName)
		{
			for (item in app.document.library.getItems())
			{
				if (Std.isOfType(item, ITextureItem))
				{
					if ((cast item:ITextureItem).textureAtlas == oldName)
					{
						(cast item:ITextureItem).textureAtlas = newName;
					}
				}
			}
		}
	}
	
	function isEmptyAtlas(name:String) : Bool
	{
		for (item in app.document.library.getItems().filterByType(ITextureItem))
		{
            if (item.textureAtlas == name) return false;
		}
		return true;
	}
	
	function updateAtlasSelector()
	{
		if (!textureAtlases.iterator().hasNext())
		{
			textureAtlases.set("atlas_0", new TextureAtlasParams());
		}
		
		template().atlases.html(textureAtlases.keys().sorted().map(s -> '<option>$s</option>').join(""));
	}
	
	function atlases_change(_)
	{
		template().atlas.update();
	}
	
	function toAtlas_click(_)
	{
		var atlas = template().atlases.val();
		if (atlas != null && atlas != "")
		{
			processTextureItems(template().library.getSelectedItems(), item -> item.textureAtlas = atlas);
		}
		template().library.update();
		template().atlas.update();
	}
	
	function fromAtlas_click(_)
	{
		var atlas = template().atlases.val();
		if (atlas != null && atlas != "")
		{
			processTextureItems(template().atlas.getSelectedItems(), item -> item.textureAtlas = null);
		}
		template().library.update();
		template().atlas.update();
	}
	
	function isItemNotUsed(item:IIdeLibraryItem) : Bool
	{
		return Std.isOfType(item, ITextureItem) && (cast item:ITextureItem).textureAtlas == null;
	}
	
	function isItemUsed(atlas:String, item:IIdeLibraryItem) : Bool
	{
		return Std.isOfType(item, ITextureItem) && (cast item:ITextureItem).textureAtlas == atlas;
	}
	
	function isFolderContains(folder:FolderItem, filter:IIdeLibraryItem->Bool) : Bool
	{
		for (item in app.document.library.getItems())
		{
			if (item.namePath.startsWith(folder.namePath + "/") && filter(item)) return true;
		}
		return false;
	}
	
	function processTextureItems(items:Array<IIdeLibraryItem>, callb:ITextureItem->Void)
	{
		for (item in items)
		{
			if (Std.isOfType(item, FolderItem))
			{
				var folder : FolderItem = cast item;
				for (item in app.document.library.getItems())
				{
					if (item.namePath.startsWith(folder.namePath + "/") && Std.isOfType(item, ITextureItem))
					{
						callb((cast item:ITextureItem));
					}
				}
			}
			else
			if (Std.isOfType(item, ITextureItem))
			{
				callb((cast item:ITextureItem));
			}
		}
	}
}