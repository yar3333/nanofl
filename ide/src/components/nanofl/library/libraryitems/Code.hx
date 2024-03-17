package components.nanofl.library.libraryitems;

import js.Browser;
import haxe.io.Path;
import htmlparser.XmlBuilder;
import nanofl.ide.Globals;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.draganddrop.IDragAndDrop;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.Shell;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
import wquery.ComponentList;
import js.JQuery;
import js.html.File;
import nanofl.engine.libraryitems.FolderItem;
import nanofl.engine.libraryitems.FontItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.libraryitems.SoundItem;
import nanofl.ide.Application;
import nanofl.ide.ISymbol;
import nanofl.ide.library.LibraryItems;
import nanofl.ide.library.droppers.LibraryItemToLibraryItemDropper;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.ui.menu.ContextMenu;
import stdlib.Std;
using stdlib.Lambda;
using StringTools;
using js.jquery.Editable;

@:rtti
class Code extends wquery.Component
{
	static var imports =
	{
		"context-menu": components.nanofl.common.contextmenu.Code
	};
	
	@inject var view : View;
	@inject var preferences : Preferences;
	@inject var popups : Popups;
	@inject var app : Application;
	@inject var shell : Shell;
	@inject var dragAndDrop : DragAndDrop;
	
	var items : ComponentList<components.nanofl.library.libraryitem.Code>;
	
	@:allow(components.nanofl.library.libraryview.Code)
	var activeNamePath = "";
	
	public var preview : components.nanofl.library.librarypreview.Code;
	
	public var active(get, set) : IIdeLibraryItem;
	function get_active()
	{
		return app.document != null && app.document.library.hasItem(activeNamePath)
			 ? app.document.library.getItem(activeNamePath)
			 : null;
	}
	function set_active(v:IIdeLibraryItem)
	{
		activeNamePath = v != null ? v.namePath : "";
		select(activeNamePath != "" ? [ activeNamePath ] : []);
		preview.item = v;
		return v;
	}
	
	public var readOnly = false;
	
	public dynamic function filterItems(item:IIdeLibraryItem) : Bool return true;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		items = new ComponentList<components.nanofl.library.libraryitem.Code>(components.nanofl.library.libraryitem.Code, this, template().content);
		
		dragAndDrop.ready.then(function(api:IDragAndDrop)
		{
			api.draggable(template().content, ">li", "libraryItem", function(out:XmlBuilder, e:JqEvent)
			{
				if (readOnly) return null;
				
				var element = new JQuery(e.currentTarget);
				var item = app.document.library.getItem(element.attr("data-name-path"));
				
				if (!element.hasClass("selected"))
				{
					select([ item.namePath ]);
				}
				
				return LibraryItems.drag(app.document, item, app.document.library.getSelectedItemsWithDependencies(), out);
			});
			
			api.droppable
			(
				template().content, ">li",
				[
					"libraryItem" => new LibraryItemToLibraryItemDropper()
				],
				(files:Array<File>, e:JqEvent) ->
				{
					if (readOnly) return;
					
					app.document.library.addUploadedFiles(files, LibraryItemToLibraryItemDropper.getTargetFolderForDrop(app, e));
				}
			);
		});
		
		template().content.on("click", ">li", function(e:JqEvent)
		{
			//trace("click on " + e.currentTarget.id);
			var element = new JQuery(e.currentTarget);
			var index = element.index();
			var namePath = element.attr("data-name-path");
			var elements = getElements();
			
			if (e.ctrlKey)
			{
				element.toggleClass("selected");
			}
			else
			if (e.shiftKey)
			{
				elements.removeClass("selected");
				var activeIndex = getElement(activeNamePath).index();
				for (i in Std.min(index, activeIndex)...(Std.max(index, activeIndex) + 1))
				{
					var elem = q(elements[i]);
					if (elem.is(":visible"))
					{
						elem.addClass("selected");
					}
				}
			}
			else
			{
				elements.removeClass("selected");
				element.addClass("selected");
			}
			
			activeNamePath = namePath;
			
			if (preview != null) preview.item = active;
		});
		
		template().content.on("dblclick", ">li", function(e:JqEvent)
		{
			var element = new JQuery(e.currentTarget);
			var item = app.document.library.getItem(element.attr("data-name-path"));
			
			if (Std.isOfType(item, FolderItem))
			{
				var folder : FolderItem = cast item;
				folder.opened = !folder.opened;
				updateVisibility();
			}
			else
			if (Std.isOfType(item, MovieClipItem))
			{
				app.document.navigator.navigateTo([ new PathItem((cast item:MovieClipItem).newInstance()) ]);
			}
			else
			if (Std.isOfType(item, FontItem))
			{
				popups.fontProperties.show((cast item:FontItem));
			}
			else
			{
				var filePath = item.getFilePathToRunWithEditor();
				if (filePath != null)
				{
					filePath = Path.join([ app.document.library.libraryDir, filePath ]);
					var success = shell.runWithEditor(filePath);
					if (!success) view.alerter.error("Not found system association with '" + Path.extension(filePath) + "' files.");
				}
			}
		});
	}
	
	function getElements() : JQuery
	{
		return template().content.find(">*");
	}
	
	function getElement(namePath:String) : JQuery
	{
		return template().content.find(">[data-name-path='" + namePath + "']");
	}
	
	public function update()
	{
		items.clear();
		
		fixActive();
		
		if (app.document != null)
		{
			for (item in app.document.library.getItems().filter(filterItems))
			{
				var namePaths = item.namePath.split("/");
				
				var cssClass = item.namePath == activeNamePath  ? "selected" : "";
				if (activeNamePath.startsWith(item.namePath + "/") && Std.isOfType(item, FolderItem))
				{
					(cast item:FolderItem).opened = true;
					cssClass += " opened";
				}
				
				var component = items.create
				({
					namePath: StringTools.htmlEscape(item.namePath),
					name: StringTools.htmlEscape(namePaths[namePaths.length - 1]),
					link: getItemLink(item),
					icon: item.getIcon(),
					indent: Std.string((namePaths.length - 1) * 14 + 10),
					display: isVisible(item.namePath) ? "block" : "none",
					cssClass: cssClass
				});
				
				component.q("#item").editable(getEditableParams(item.namePath));
			}
			
			var elements = getElements(); 
			
			template().contextMenu.build(elements, preferences.storage.getMenu("libraryItemsContextMenu"), (menu:ContextMenu, e:JqEvent, _:JQuery) ->
			{
				if (readOnly) return false;
				
				var element = q(e.currentTarget);
				
				if (!element.hasClass("selected"))
				{
					deselectAll();
					element.addClass("selected");
				}
				
				activeNamePath = element.attr("data-name-path");
				
				menu.toggleItem("library.properties", getPropertiesPopup() != null);
				
				return true;
			});
		}
		
		if (preview != null)
		{
			if (active != null && !filterItems(active)) active = null;
			preview.item = active;
		}
	}
	
	public function showPropertiesPopup()
	{
		var popup = getPropertiesPopup();
		if (popup != null) popup.show(cast active);
	}
	
	function getPropertiesPopup() : { function show(item:Dynamic) : Void; }
	{
		if (Std.isOfType(active, ISymbol))
		{
			return popups.symbolProperties;
		}
		else
		if (Std.isOfType(active, SoundItem))
		{
			return popups.soundProperties;
		}
		else
		if (Std.isOfType(active, FontItem))
		{
			return popups.fontProperties;
		}
		return null;
	}
	
	function updateVisibility()
	{
		for (element in getElements())
		{
			var namePath = element.attr("data-name-path");
			
			if (isVisible(namePath))
			{
				element.show();
				element.toggleClass("selected", namePath == activeNamePath);
				
				var item = app.document.library.getItem(namePath);
				if (Std.isOfType(item, FolderItem))
				{
					element.find(">i").attr("class", item.getIcon());
				}
			}
			else
			{
				element.hide();
				element.removeClass("selected");
			}
		}
	}
	
	public function removeSelected()
	{
		app.document.library.removeItems(getSelectedItems().map(item -> item.namePath));
	}
	
	public function renameByUser(namePath:String) : Void
	{
		getElement(namePath).beginEdit(getEditableParams(namePath));
	}
	
	public function getSelectedItems() : Array<IIdeLibraryItem>
	{
		var r = [];
		for (element in getElements())
		{
			if (element.hasClass("selected"))
			{
				r.push(app.document.library.getItem(element.attr("data-name-path")));
			}
		}
		return r;
	}
	
	public function deselectAll()
	{
		getElements().removeClass("selected");
	}
	
	public function select(namePaths:Array<String>)
	{
		deselectAll();
		
		for (namePath in namePaths)
		{
			getElement(namePath).addClass("selected");
		}
	}
	
	public function gotoPrevItem(overwriteSelection:Bool)
	{
		if (active == null) return;
		
		var elements = getElements();
		var n = getElement(activeNamePath).index() - 1;
		while (n >= 0 && !q(elements[n]).is(":visible")) n--;
		if (n < 0) return;
		activeNamePath = elements[n].getAttribute("data-name-path");
		if (overwriteSelection) deselectAll();
		q(elements[n]).addClass("selected");
		if (preview != null) preview.item = active;
	}
	
	public function gotoNextItem(overwriteSelection:Bool)
	{
		if (active == null) return;
		
		var elements = getElements();
		var n = getElement(activeNamePath).index() + 1;
		while (n < elements.length && !q(elements[n]).is(":visible")) n++;
		if (n >= elements.length) return;
		activeNamePath = elements[n].getAttribute("data-name-path");
		if (overwriteSelection) deselectAll();
		q(elements[n]).addClass("selected");
		if (preview != null) preview.item = active;
	}
	
	function getItemLink(item:IIdeLibraryItem) : String
	{
		if (Std.isOfType(item, InstancableItem)) return (cast item:InstancableItem).linkedClass;
		if (Std.isOfType(item, SoundItem)) return (cast item:SoundItem).linkage;
		return "";
	}
	
	function isVisible(namePath:String) : Bool
	{
		var parts = namePath.split("/");
		for (i in 1...parts.length)
		{
			var folder : FolderItem = cast app.document.library.getItem(parts.slice(0, i).join("/"));
			if (!folder.opened) return false;
		}
		return true;
	}
	
	function getEditableParams(namePath:String) : js.jquery.Editable.Params
	{
		return
		{
			enabled: (jq:JQuery) ->
			{
				return !readOnly && jq.hasClass("selected");
			},
			beginEdit: (jq:JQuery, input:JQuery) ->
			{
				jq.attr("draggable", "false");
				jq.children("span").hide();
				input.width(jq.width() - jq.children(":visible").outerWidth());
				jq.append(input);
			},
			endEdit: (jq:JQuery) ->
			{
				jq.attr("draggable", "true");
				jq.children("span").css("display", "");
			},
			getData: (jq:JQuery) ->
			{
				return Path.withoutDirectory(namePath);
			},
			setData: (jq:JQuery, value:String) ->
			{
				if (value != "" && Path.withoutDirectory(namePath) != value)
				{
					var newNamePath = Path.join([ Path.directory(namePath), value ]); 
                    if (!app.document.library.hasItem(newNamePath))
                    {
                        app.document.library.renameItems([{ oldNamePath:namePath, newNamePath:newNamePath }]);
                        view.library.activeItem = null;
                        app.document.library.update();
                        view.library.activeItem = app.document.library.getItem(newNamePath);
                    }
                    else
                    {
                        Browser.alert("Symbol '" + newNamePath + "' already exists.");
                    }
				}
			},
			cssClass: "inPlaceEdit"
		};
	}
	
	function fixActive()
	{
		if (app.document != null)
		{
			if (app.document.library.hasItem(activeNamePath)) return;
			
			var namePaths = app.document.library.getItems().map(x -> x.namePath).sorted();
			
			var index = namePaths.findIndex(x -> x > activeNamePath);
			if (index >= 0)
			{
				for (i in index...namePaths.length)
				{
					if (isVisible(namePaths[i]))
					{
						activeNamePath = namePaths[i];
						return;
					}
				}
			}
			
			var i = namePaths.length - 1; while (i >= 0)
			{
				if (isVisible(namePaths[i]))
				{
					activeNamePath = namePaths[i];
					return;
				}
				i--;
			}
		}
		else
		{
			activeNamePath = "";
		}
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}