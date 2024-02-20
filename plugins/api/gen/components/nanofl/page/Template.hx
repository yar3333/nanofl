package components.nanofl.page;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var mainMenuContainer(get, never) : js.JQuery;
	var rightNav(get, never) : js.JQuery;
	var libraryTab(get, never) : js.JQuery;
	var propertiesTab(get, never) : js.JQuery;
	var outputTab(get, never) : js.JQuery;
	var library(get, never) : components.nanofl.library.library.Code;
	var properties(get, never) : components.nanofl.others.properties.Code;
	var output(get, never) : components.nanofl.others.output.Code;
	var openedFiles(get, never) : components.nanofl.others.openedfiles.Code;
	var content(get, never) : js.JQuery;
	var startPage(get, never) : js.JQuery;
	var startPageComponent(get, never) : components.nanofl.others.startpage.Code;
	var moviePage(get, never) : js.JQuery;
	var movie(get, never) : components.nanofl.movie.movie.Code;
	var popupsContainer(get, never) : components.nanofl.others.allpopups.Code;
	var waiter(get, never) : components.nanofl.common.waiter.Code;
	var shadow(get, never) : components.nanofl.common.shadow.Code;
	var mainMenu(get, never) : components.nanofl.others.mainmenu.Code;
	var alerter(get, never) : components.nanofl.others.alerter.Code;
	var fpsMeter(get, never) : components.nanofl.others.fpsmeter.Code;
	var dragAndDrop(get, never) : components.nanofl.others.draganddrop.Code;
	var inputContextMenu(get, never) : components.nanofl.common.contextmenu.Code;
}