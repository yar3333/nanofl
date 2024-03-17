package components.nanofl.library.libraryview;

import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.editor.EditorLibrary;
import nanofl.ide.preferences.Preferences;
import js.JQuery;
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
	
	public var activeItem(get, set) : IIdeLibraryItem;
	function get_activeItem() return template().items.active;
	function set_activeItem(v:IIdeLibraryItem) return template().items.active = v;

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
		
		template().items.preview = template().preview;
		
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
		template().preview.resize(paneElem.innerWidth(), paneState.innerHeight - 10);
		preferences.application.previewHeight = paneState.size;
	}
}