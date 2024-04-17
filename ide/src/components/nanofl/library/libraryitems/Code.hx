package components.nanofl.library.libraryitems;

import wquery.Event;
import js.Browser;
import js.JQuery;
import js.html.DragEvent;
import stdlib.Std;
import htmlparser.XmlDocument;
import haxe.io.Path;
import wquery.ComponentList;
import easeljs.geom.Rectangle;
import nanofl.engine.libraryitems.FolderItem;
import nanofl.engine.libraryitems.FontItem;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.engine.libraryitems.SoundItem;
import nanofl.ide.Globals;
import nanofl.ide.draganddrop.DragDataType;
import nanofl.ide.draganddrop.AllowedDropEffect;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.library.LibraryDragAndDropTools;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.Shell;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.Application;
import nanofl.ide.ISymbol;
import nanofl.ide.ui.menu.ContextMenu;
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
	@inject var fileSystem : FileSystem;
	
	var items : ComponentList<components.nanofl.library.libraryitem.Code>;
	
	@:noCompletion var _activeNamePath = "";
    var activeNamePath(get, set) : String;
    @:noCompletion function get_activeNamePath() return _activeNamePath;
    @:noCompletion function set_activeNamePath(namePath:String)
    {
        _activeNamePath = namePath;
        onActiveItemChange.emit({ namePath:namePath });
        return namePath;
    }
	
	function getActiveItem()
	{
		return app.document != null && app.document.library.hasItem(activeNamePath)
			 ? app.document.library.getItem(activeNamePath)
			 : null;
	}

    public final onActiveItemChange = new Event<{ namePath:String }>();
	
	public var readOnly = false;
	
	public dynamic function filterItems(item:IIdeLibraryItem) : Bool return true;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		items = new ComponentList<components.nanofl.library.libraryitem.Code>(components.nanofl.library.libraryitem.Code, this, template().content);
		
		dragAndDrop.ready.then(api ->
		{
			api.draggable(template().content, ">li", (e:JqEvent) ->
			{
				if (readOnly) return null;
				
				final element = new JQuery(e.currentTarget);
				final item = app.document.library.getItem(element.attr("data-name-path"));
				
				if (!element.hasClass("selected"))
				{
					select([ item.namePath ]);
				}

				return
				{
                    effect: AllowedDropEffect.copyMove,
                    type: DragDataType.LIBRARYITEMS,
                    params: LibraryDragAndDropTools.getDragParams(app.document, item, app.document.library.getSelectedItemsWithDependencies()),
                    data: LibraryDragAndDropTools.getDragData(app.document, item, app.document.library.getSelectedItemsWithDependencies()),
                };
			});
			
			api.droppable
			(
				template().content, 
                ">li",
                (type, params) -> LibraryDragAndDropTools.getDragImageTypeIconText(view, type, params),

                (type, params, data, e) ->
                {
                    if (type != DragDataType.LIBRARYITEMS || view.library.readOnly) return false;
                    
                    final dropEffect = (cast e.originalEvent:DragEvent).dataTransfer.dropEffect;                    
                    final namePath = e.currentTarget.getAttribute("data-name-path");

                    LibraryDragAndDropTools.dropToLibraryItemsFolder
                    (
                        app.document, 
                        dropEffect,
                        params,
                        new XmlDocument(data), 
                        LibraryDragAndDropTools.getTargetFolderForDrop(app.document, namePath)
                    );
                    return true;
                },
                
				(files, e) ->
				{
					if (readOnly) return;

                    final namePath = e.currentTarget.getAttribute("data-name-path");
					
					app.document.library.addUploadedFiles(files, LibraryDragAndDropTools.getTargetFolderForDrop(app.document, namePath));
				}
			);
		});
		
		template().content.on("click", ">li", (e:JqEvent) ->
		{
			//trace("click on " + e.currentTarget.id);
			final element = new JQuery(e.currentTarget);
			final index = element.index();
			final namePath = element.attr("data-name-path");
			final elements = getElements();
			
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
		});
		
		template().content.on("dblclick", ">li", (e:JqEvent) ->
		{
			final element = new JQuery(e.currentTarget);
            app.document.library.openItem(element.attr("data-name-path"));
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
		
		if (app.document != null)
		{
			for (item in app.document.library.getItems().filter(filterItems))
			{
				final namePaths = item.namePath.split("/");
				
				var cssClass = item.namePath == activeNamePath  ? "selected" : "";
				if (activeNamePath.startsWith(item.namePath + "/") && Std.isOfType(item, FolderItem))
				{
					(cast item:FolderItem).opened = true;
					cssClass += " opened";
				}
				
				final component = items.create
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
			
			final elements = getElements(); 
			
			template().contextMenu.build(elements, preferences.storage.getMenu("libraryItemsContextMenu"), (menu:ContextMenu, e:JqEvent, _:JQuery) ->
			{
				if (readOnly) return false;
				
				final element = q(e.currentTarget);
				
				if (!element.hasClass("selected"))
				{
					deselectAll();
					element.addClass("selected");
				}
				
				activeNamePath = element.attr("data-name-path");
				
				menu.toggleItem("library.properties", getPropertiesPopup(getActiveItem()) != null);
				
				return true;
			});
		}

        fixActiveNamePath();
		
        final activeItem = getActiveItem();
		if (activeItem != null && !filterItems(activeItem)) activeNamePath = "";
	}
	
	public function showPropertiesPopup()
	{
        final activeItem = getActiveItem();
		final popup = getPropertiesPopup(activeItem);
		if (popup != null) popup.show(activeItem);
	}
	
	function getPropertiesPopup(active:IIdeLibraryItem) : { function show(item:Dynamic) : Void; }
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

    public function getItemElementBounds(namePath:String) : Rectangle
    {
        final element = getElement(namePath);
        final pos = element.position();
        if (pos == null) return null;
        return new Rectangle(pos.left, pos.top, element.outerWidth(), element.outerHeight());
    }
	
	public function updateVisibility()
	{
		for (element in getElements())
		{
			final namePath = element.attr("data-name-path");
			
			if (isVisible(namePath))
			{
				element.show();
				element.toggleClass("selected", namePath == activeNamePath);
				
				final item = app.document.library.getItem(namePath);
				if (Std.isOfType(item, FolderItem))
				{
					element.find(">i").attr("class", item.getIcon());
                    element.toggleClass("opened", (cast item:FolderItem).opened);
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
	
	public function renameSelectedByUser() : Void
	{
        if (activeNamePath == null || activeNamePath == "") return;
        final element = getElement(activeNamePath);
		element.beginEdit(getEditableParams(activeNamePath));
	}
	
	public function getSelectedItems() : Array<IIdeLibraryItem>
	{
		final r = [];
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
		select([]);
	}
	
	public function select(namePaths:Array<String>)
	{
		getElements().removeClass("selected");
		
		for (namePath in namePaths)
		{
			getElement(namePath).addClass("selected");
		}

        activeNamePath = namePaths.length > 0 ? namePaths[namePaths.length - 1] : "";
	}
	
	public function gotoPrevItem(overwriteSelection:Bool)
	{
		if (activeNamePath == "") return;
		
		final elements = getElements();
		var n = getElement(activeNamePath).index() - 1;
		while (n >= 0 && !q(elements[n]).is(":visible")) n--;
		
        if (n < 0) return;
		
        if (overwriteSelection) deselectAll();
		q(elements[n]).addClass("selected");

        activeNamePath = elements[n].getAttribute("data-name-path");
	}
	
	public function gotoNextItem(overwriteSelection:Bool)
	{
		if (activeNamePath == "") return;
		
		final elements = getElements();
		var n = getElement(activeNamePath).index() + 1;
		while (n < elements.length && !q(elements[n]).is(":visible")) n++;
		
        if (n >= elements.length) return;
		
        
		if (overwriteSelection) deselectAll();
		q(elements[n]).addClass("selected");

		activeNamePath = elements[n].getAttribute("data-name-path");
	}
	
	function getItemLink(item:IIdeLibraryItem) : String
	{
		if (Std.isOfType(item, InstancableItem)) return (cast item:InstancableItem).linkedClass;
		if (Std.isOfType(item, SoundItem)) return (cast item:SoundItem).linkage;
		return "";
	}
	
	function isVisible(namePath:String) : Bool
	{
		final parts = namePath.split("/");
		for (i in 1...parts.length)
		{
			final folder : FolderItem = cast app.document.library.getItem(parts.slice(0, i).join("/"));
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
					final newNamePath = Path.join([ Path.directory(namePath), value ]); 
                    if (!app.document.library.hasItem(newNamePath))
                    {
                        app.document.library.renameItems([{ oldNamePath:namePath, newNamePath:newNamePath }]);
                        app.document.library.select([ newNamePath ]);
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
	
	function fixActiveNamePath()
	{
		if (app.document == null) { activeNamePath = ""; return; }
		
        if (app.document.library.hasItem(activeNamePath)) return;
        
        final namePaths = app.document.library.getItems().map(x -> x.namePath).sorted();
        
        final index = namePaths.findIndex(x -> x > activeNamePath);
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
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}