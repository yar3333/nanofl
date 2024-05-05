package components.nanofl.library.libraryview;

import haxe.io.Path;
import js.JQuery;
import stdlib.Std;
import nanofl.engine.LibraryItemType;
import nanofl.engine.Log;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.libraryitems.FolderItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.editor.EditorLibrary;
import nanofl.ide.preferences.Preferences;
using js.jquery.Layout;
using StringTools;

@:rtti
class Code extends wquery.Component
{
	static var imports =
	{
		"library-preview": components.nanofl.library.librarypreview.Code,
		"library-items": components.nanofl.library.libraryitems.Code
	};
	
	@inject var preferences : Preferences;
	@inject var app : Application;
	
	var layout : LayoutInstance;
	
	public var readOnly(get, set) : Bool;
	function get_readOnly() return template().items.readOnly;
	function set_readOnly(v) return template().items.readOnly = v;
	
	public var filterItems(get, set) : IIdeLibraryItem->Bool;
	function get_filterItems() return template().items.filterItems;
	function set_filterItems(f:IIdeLibraryItem->Bool) return template().items.filterItems = f;
	
	var lastLibrary : EditorLibrary;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
        template().items.onActiveItemChange.on(e -> 
        {
            template().preview.item = app.document?.library.hasItem(e.namePath) ? app.document.library.getItem(e.namePath) : null;
            ensureActiveItemVisible(e.namePath);
        });
		
		layout = template().container.layout
		({
			defaults: { enableCursorHotkey:false },
			north: { onresize_end:onResizeNorth, size:preferences.application.previewHeight != null ? preferences.application.previewHeight : 150 },
			south: { closable:false, resizable:false, spacing_open:1, spacing_closed:1 }
		});
	}
	
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.width(maxWidth);
		template().container.height(maxHeight);
		layout.resizeAll();
	}
	
	public function updateLayout()
	{
		layout.resizeAll();
	}
	
	public function show() template().container.show();
	public function hide() template().container.hide();
	
	public function on(event:String, callb:JqEvent->Void)
	{
		template().container.on(event, callb);
	}
	
	public function gotoPrevItem(overwriteSelection:Bool)
	{
		template().items.gotoPrevItem(overwriteSelection);
	}
	
	public function gotoNextItem(overwriteSelection:Bool)
	{
		template().items.gotoNextItem(overwriteSelection);
	}
	
	public function showPropertiesPopup()
	{
		template().items.showPropertiesPopup();
	}
	
	public function update()
	{
		if (app.document != null)
		{
			var scrollPos = lastLibrary == app.document.library ? template().centerContainer.scrollTop() : 0;
			
			template().items.update();
			
			template().centerContainer.scrollTop(scrollPos);
			lastLibrary = app.document.library;
		}
		else
		{
			template().items.update();
		}
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary.deselectAll)
	function deselectAll()
	{
		template().items.deselectAll();
	}
	
	public function getSelectedItems() : Array<IIdeLibraryItem>
	{
		return template().items.getSelectedItems();
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary.select)
	public function select(namePaths:Array<String>)
	{
		template().items.select(namePaths);
	}
	
	function onResizeNorth(paneName:String, paneElem:JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String)
	{
        try
        {
            template().preview.resize(paneElem.innerWidth(), paneState.innerHeight - 10);
            preferences.application.previewHeight = paneState.size;
        }
        catch (e)
        {
            Log.console.error(e);
        }
	}

    function ensureActiveItemVisible(namePath:String)
    {
        if (namePath == null || namePath == "") return;

        if (openFolders(Path.directory(namePath)))
        {
            template().items.updateVisibility();
        }

        final container = template().centerContainer;
        final scrollPos = container.scrollTop();
        final height = container.innerHeight();
        final rect = template().items.getItemElementBounds(namePath);
        if (rect == null) return;
        rect.y += scrollPos;
        log("scrollPos = " + scrollPos + "; height = " + height + "; rect.y = " + rect.y + "; rect.height = " + rect.height);

        if (rect.y >= scrollPos && rect.y + rect.height <= scrollPos + height) return;

        final maxScrollPos = container[0].scrollHeight - height;
        log("maxScrollPos = " + maxScrollPos);

        if (rect.y < scrollPos)
            container.scrollTop(Std.min(maxScrollPos, Std.max(0, Math.floor(rect.y - rect.height / 2))));
        else
            container.scrollTop(Std.min(maxScrollPos, Std.max(0, Math.floor(rect.y - height + rect.height * 3 / 2))));
    }

    function openFolders(namePath:String) : Bool
    {
        if (namePath == null || namePath == "") return false;

        final item = app.document.library.getItem(namePath);
        
        var r = false;
        
        if (item.type.match(LibraryItemType.folder))
        {
            if (!(cast item:FolderItem).opened)
            {
                r = true;
                (cast item:FolderItem).opened = true;
            }
        }

        final n = namePath.lastIndexOf("/");
        if (n > 0) r = openFolders(namePath.substr(0, n)) || r;

        return r;
    }

	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("view:LibraryView", v);
	}
}