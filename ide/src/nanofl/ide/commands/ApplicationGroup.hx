package nanofl.ide.commands;

import nanofl.ide.OpenedFiles;
import nanofl.ide.plugins.Plugins;
import nanofl.ide.ui.Popups;
using stdlib.StringTools;
using stdlib.Lambda;

@:rtti
class ApplicationGroup extends BaseGroup
{
	@inject var popups : Popups;
	@inject var plugins : Plugins;
	@inject var openedFiles : OpenedFiles;
	
	public function preferences() 		popups.preferences.show();
	public function reloadPlugins()		plugins.reload();
	public function showHotkeys()		popups.hotkeysHelp.show();
	public function about()				popups.aboutApplication.show();
	public function quit() 				app.quit();
	
	public function openFile(path:String)
	{
		var doc = openedFiles.find(x -> x.getPath() == path);
		if (doc != null) doc.activate();
		else app.openDocument(path);
	}
	
	#if !no_trial
	@:noapi public function register() 	popups.register.show();
	#end
}
