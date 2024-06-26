package nanofl.ide.commands;

import stdlib.Timer;
import nanofl.ide.Clipboard;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.ui.Popups;

@:rtti
class DocumentGroup extends BaseGroup
{
	@inject var popups : Popups;
	@inject var clipboard : Clipboard;
	
	public function createNewEmpty(?width:Int, ?height:Int, ?framerate:Float) Timer.delayAsync(1).then(_ -> app.createNewEmptyDocument(width, height, framerate));
	
	public function open(path:String)			Timer.delayAsync(1).then(_ -> app.openDocument(path));
	public function save()						app.document.save();
	public function saveAs()					app.document.saveAs();
	public function import_(pluginName:String)	app.importDocument(ImporterPlugins.plugins.get(pluginName));
	public function export(pluginName:String)	app.document.export(ExporterPlugins.plugins.get(pluginName));
	
	public function test()						app.document.test();
	
	public function publishSettings()			popups.publishSettings.show();
	public function publish()					app.document.publish();
	
	public function undo()						app.document.undoQueue.undo();
	public function redo()						app.document.undoQueue.redo();
	
	public function cut()						clipboard.cut();
	public function copy()						clipboard.copy();
	public function paste()						clipboard.paste();
	
	public function properties()				popups.documentProperties.show();
}
