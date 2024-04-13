package components.nanofl.page;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var container(get, never) : js.JQuery;
	inline function get_container() return component.q('#container');
	
	public var mainMenuContainer(get, never) : js.JQuery;
	inline function get_mainMenuContainer() return component.q('#mainMenuContainer');
	
	public var rightNav(get, never) : js.JQuery;
	inline function get_rightNav() return component.q('#rightNav');
	
	public var libraryTab(get, never) : js.JQuery;
	inline function get_libraryTab() return component.q('#libraryTab');
	
	public var propertiesTab(get, never) : js.JQuery;
	inline function get_propertiesTab() return component.q('#propertiesTab');
	
	public var library(get, never) : components.nanofl.library.library.Code;
	inline function get_library() return cast component.children.library;
	
	public var properties(get, never) : components.nanofl.others.properties.Code;
	inline function get_properties() return cast component.children.properties;
	
	public var openedFiles(get, never) : components.nanofl.others.openedfiles.Code;
	inline function get_openedFiles() return cast component.children.openedFiles;
	
	public var content(get, never) : js.JQuery;
	inline function get_content() return component.q('#content');
	
	public var startPage(get, never) : js.JQuery;
	inline function get_startPage() return component.q('#startPage');
	
	public var startPageComponent(get, never) : components.nanofl.others.startpage.Code;
	inline function get_startPageComponent() return cast component.children.startPageComponent;
	
	public var moviePage(get, never) : js.JQuery;
	inline function get_moviePage() return component.q('#moviePage');
	
	public var movie(get, never) : components.nanofl.movie.movie.Code;
	inline function get_movie() return cast component.children.movie;
	
	public var popupsContainer(get, never) : components.nanofl.others.allpopups.Code;
	inline function get_popupsContainer() return cast component.children.popupsContainer;
	
	public var waiter(get, never) : components.nanofl.common.waiter.Code;
	inline function get_waiter() return cast component.children.waiter;
	
	public var shadow(get, never) : components.nanofl.common.shadow.Code;
	inline function get_shadow() return cast component.children.shadow;
	
	public var mainMenu(get, never) : components.nanofl.others.mainmenu.Code;
	inline function get_mainMenu() return cast component.children.mainMenu;
	
	public var alerter(get, never) : components.nanofl.others.alerter.Code;
	inline function get_alerter() return cast component.children.alerter;
	
	public var fpsMeter(get, never) : components.nanofl.others.fpsmeter.Code;
	inline function get_fpsMeter() return cast component.children.fpsMeter;
	
	public var dragAndDrop(get, never) : components.nanofl.others.draganddrop.Code;
	inline function get_dragAndDrop() return cast component.children.dragAndDrop;
	
	public var inputContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_inputContextMenu() return cast component.children.inputContextMenu;

	public function new(component:wquery.Component) this.component = component;
}