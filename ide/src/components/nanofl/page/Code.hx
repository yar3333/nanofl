package components.nanofl.page;

import nanofl.ide.OpenedFiles;
import nanofl.ide.draganddrop.DragAndDrop;
import js.Browser;
import js.JQuery;
import nanofl.ide.ILayout;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import nanofl.ide.ui.Popups;
using js.jquery.Layout;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using stdlib.StringTools;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Code extends wquery.Component implements ILayout
{
	static var imports =
	{
		"library": components.nanofl.library.library.Code,
		"properties": components.nanofl.others.properties.Code,
		"output-pane": components.nanofl.others.output.Code,
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
	
	public var view(default, null) : View;
	public var popups(default, null) : Popups;
	public var openedFiles(default, null) : OpenedFiles;
	public var dragAndDrop(default, null) : DragAndDrop;
	
	public function getTemplate() return template();
	
	function preInit()
	{
		injector.allowNoRttiForClass(wquery.Component);
		
		injector.injectInto(this);
		
		injector.map(Popups, popups = new Popups(this));
		injector.map(DragAndDrop, dragAndDrop = new DragAndDrop());
		injector.map(View, view = new View(this));
		injector.map(ILayout, this);
		injector.map(OpenedFiles, openedFiles = new OpenedFiles(this));
	}
	
	function init()
	{
		dragAndDrop.init(template().dragAndDrop);
		
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
		window.resize(function(e) resize(window.width(), window.height()));
		
		window.blur(function(_) q(".dropdown-toggle").parent().removeClass('open')); // fix to close menu on click on iframe
		
		q(Browser.document).find(".nav>li").mousedown(function(e) e.preventDefault());
		
		template().moviePage.hide();
		template().startPage.show();
		
		q(Browser.document.body).on("contextmenu", function(e) e.preventDefault());
		template().inputContextMenu.build(q(Browser.document.body), "input[type=text],textarea", preferences.storage.getMenu("inputContextMenu"), function(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, item:JQuery) : Bool
		{
			var input = new JQuery(e.currentTarget);
			if (input.prop("disabled")) return false;
			return true;
		});
	}
	
	function libraryTab_click(e) showLibraryPanel();
	
	function propertiesTab_click(e) showPropertiesPanel();
	
	function outputTab_click(e) showOutputPanel();
	
	public function showLibraryPanel()
	{
		switchPanel(template().libraryTab);
		view.library.updateLayout();
	}
	
	public function showPropertiesPanel()
	{
		switchPanel(template().propertiesTab);
	}
	
	public function showOutputPanel()
	{
		switchPanel(template().outputTab);
	}
	
	function switchPanel(tab:JQuery)
	{
		var elements : Array<{ tab:JQuery, pane:{ function show():Void; function hide():Void; } }> =
		[
			{ tab:template().libraryTab,	pane:view.library },
			{ tab:template().propertiesTab,	pane:view.properties },
			{ tab:template().outputTab,		pane:view.output }
		];
		
		var n = elements.findIndex(x -> x.tab.attr("id") == tab.attr("id"));
		
		for (e in elements) if (e.tab.attr("id") != tab.attr("id")) e.tab.removeClass("active");
		tab.addClass("active");
		
		for (i in 0...elements.length) if (i != n) elements[i].pane.hide();
		elements[n].pane.show();
	}
	
	function onResizeEast(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
		template().library.resize(paneState.innerWidth, paneState.innerHeight - template().rightNav.outerHeight());
		template().properties.resize(paneState.innerWidth, paneState.innerHeight - template().rightNav.outerHeight());
		template().output.resize(paneState.innerWidth, paneState.innerHeight - template().rightNav.outerHeight());
	}
	
	function onResizeCenter(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
		var documentsHeight = template().openedFiles.outerHeight();
		
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
	
	function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.height(maxHeight);
		layoutInstance.resizeAll();
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}