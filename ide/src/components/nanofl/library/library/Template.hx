package components.nanofl.library.library;

@:access(wquery.Component)
class Template extends components.nanofl.library.libraryview.Template
{
	public var toolbar(get, never) : components.nanofl.library.librarytoolbar.Code;
	inline function get_toolbar() return cast component.children.toolbar;
	
	public var contextMenu(get, never) : components.nanofl.common.contextmenu.Code;
	inline function get_contextMenu() return cast component.children.contextMenu;
}