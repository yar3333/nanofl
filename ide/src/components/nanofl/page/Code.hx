package components.nanofl.page;

import js.Browser;
import js.JQuery;
import nanofl.engine.Log.console;
import nanofl.ide.ILayout;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import nanofl.ide.ui.Popups;
using js.jquery.Layout;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using stdlib.StringTools;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Code extends wquery.Component 
    implements ILayout
    implements View
{
	static var imports =
	{
		"library": components.nanofl.library.library.Code,
		"properties": components.nanofl.others.properties.Code,
		"opened-files": components.nanofl.others.openedfiles.Code,
		"start-page": components.nanofl.others.startpage.Code,
		"movie": components.nanofl.movie.movie.Code,
		"popups": components.nanofl.others.allpopups.Code,
		"waiter": components.nanofl.common.waiter.Code,
		"shadow": components.nanofl.common.shadow.Code,
		"main-menu": components.nanofl.others.mainmenu.Code,
		"alerter": components.nanofl.others.alerter.Code,
		"fps-meter": components.nanofl.others.fpsmeter.Code,
		"drag-and-drop": components.nanofl.others.draganddrop.Code,
		"context-menu": components.nanofl.common.contextmenu.Code
	};
	
	@inject var preferences : Preferences;
	
	var injector : js.injecting.Injector = null;
	
	var layoutInstance : LayoutInstance;
	
	public function getTemplate() return template();
	
	function preInit()
	{
        injector.allowNoRttiForClass(wquery.Component);
		injector.injectInto(this);
		
		injector.addSingleton(Popups, new Popups(this));
		injector.addSingleton(DragAndDrop);
		injector.addSingleton(View, this);
		injector.addSingleton(ILayout, this);
	}

    // View vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	public var mainMenu(get, never)     : nanofl.ide.ui.views.IMainMenuView;    function get_mainMenu()     return template().mainMenu;
	public var movie(get, never)        : nanofl.ide.ui.views.MovieView;        function get_movie()        return template().movie;
	public var library(get, never)      : nanofl.ide.ui.views.LibraryView;      function get_library()      return template().library;
	public var properties(get, never)   : nanofl.ide.ui.views.PropertiesView;	function get_properties()   return template().properties;
	public var waiter(get, never)       : nanofl.ide.ui.views.Waiter;	        function get_waiter()       return template().waiter;
	public var shadow(get, never)       : nanofl.ide.ui.views.Shadow;	        function get_shadow()       return template().shadow;
	public var alerter(get, never)      : nanofl.ide.ui.views.Alerter;          function get_alerter()      return template().alerter;
	public var fpsMeter(get, never)     : nanofl.ide.ui.views.FpsMeter;	        function get_fpsMeter()     return template().fpsMeter;
	public var startPage(get, never)    : nanofl.ide.ui.views.StartPage;        function get_startPage()    return template().startPageComponent;
	public var openedFiles(get, never)  : nanofl.ide.ui.views.OpenedFilesView;  function get_openedFiles()  return template().openedFiles;

    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	function init()
	{
		injector.getService(DragAndDrop).init(template().dragAndDrop);
		
		template().content.find(">*").hide();
		template().moviePage.show();
		
		layoutInstance = template().container.layout
		({
			defaults: { enableCursorHotkey:false },
			east: { size:315, onresize_end:onResizeEast },
			north: { size:30, closable:false, resizable:false, spacing_open:1, spacing_closed:1, paneClass:"pane-back-color" },
			center: { onresize_end:onResizeCenter, maskContents:true }
		});
		
		template().mainMenu.offset(template().mainMenuContainer.offset());
		
		var window = q(Browser.window);
		window.resize(_ -> resize(window.width(), window.height()));
		
		window.blur(_ -> q(".dropdown-toggle").parent().removeClass('open')); // fix to close menu on click on iframe
		
		q(Browser.document).find(".nav>li").mousedown(e -> e.preventDefault());
		
		template().moviePage.hide();
		template().startPage.show();
		
		q(Browser.document.body).on("contextmenu", e -> e.preventDefault());
		template().inputContextMenu.build(q(Browser.document.body), "input[type=text],textarea", preferences.storage.getMenu("inputContextMenu"), function(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, item:JQuery) : Bool
		{
			var input = new JQuery(e.currentTarget);
			if (input.prop("disabled")) return false;
			return true;
		});
	}
	
	function libraryTab_click(e) showLibraryPanel();
	
	function propertiesTab_click(e) showPropertiesPanel();
	
	public function showLibraryPanel()
	{
		switchPanel(template().libraryTab);
		library.updateLayout();
	}
	
	public function showPropertiesPanel()
	{
		switchPanel(template().propertiesTab);
	}
	
	function switchPanel(tab:JQuery)
	{
		var elements : Array<{ tab:JQuery, pane:{ function show():Void; function hide():Void; } }> =
		[
			{ tab:template().libraryTab,	pane:library },
			{ tab:template().propertiesTab,	pane:properties },
		];
		
		var n = elements.findIndex(x -> x.tab.attr("id") == tab.attr("id"));
		
		for (e in elements) if (e.tab.attr("id") != tab.attr("id")) e.tab.removeClass("active");
		tab.addClass("active");
		
		for (i in 0...elements.length) if (i != n) elements[i].pane.hide();
		elements[n].pane.show();
	}
	
	function onResizeEast(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
        try
        {
            template().library.resize(paneState.innerWidth, paneState.innerHeight - template().rightNav.outerHeight());
            template().properties.resize(paneState.innerWidth, paneState.innerHeight - template().rightNav.outerHeight());
        }
        catch (e)
        {
            console.error(e);
        }
	}
	
	function onResizeCenter(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
        try
        {
            final documentsHeight = template().openedFiles.outerHeight();
		
            template().content.find(">*").not(template().startPage)
                .width(paneState.innerWidth)
                .height(paneState.innerHeight - documentsHeight);
            
            template().startPage
                .css("margin-top", -documentsHeight + "px")
                .width(paneState.innerWidth)
                .height(paneState.innerHeight);
            
            template().movie.resize();
            template().openedFiles.resize();
        }
        catch (e)
        {
            console.error(e);
        }
	}
	
	function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.height(maxHeight);
		layoutInstance.resizeAll();
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("view:Page", v);
	}
}