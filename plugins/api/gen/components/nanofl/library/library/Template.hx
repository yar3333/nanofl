package components.nanofl.library.library;

@:access(wquery.Component) extern class Template extends components.nanofl.library.libraryview.Template {
	function new(component:wquery.Component):Void;
	var toolbar(get, never) : components.nanofl.library.librarytoolbar.Code;
	var contextMenu(get, never) : components.nanofl.common.contextmenu.Code;
}