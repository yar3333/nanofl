package components.nanofl.library.librarytoolbar;

import nanofl.ide.Application;
import nanofl.ide.Globals;

@:rtti
class Code extends wquery.Component
{
	@inject var app : Application;
	
	function init()
	{
		Globals.injector.injectInto(this);
	}
	
	function newMovieClip_click(e)
	{
		app.document.library.createEmptyMovieClip();
	}
	
	function newFolder_click(e)
	{
		app.document.library.createFolder();
	}
	
	function properties_click(e)
	{
		app.document.library.showPropertiesPopup();
	}
	
	function removeItems_click(e)
	{
		app.document.library.removeSelected();
	}
}