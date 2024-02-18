package nanofl.ide.commands;

@:rtti
class OpenedFileGroup extends BaseGroup
{
	@inject var openedFiles : OpenedFiles;
	@inject var clipboard : Clipboard;
	
	public function save()				openedFiles.active.save();
	
	public function undo()				openedFiles.active.undo();
	public function redo()				openedFiles.active.redo();
	
	public function cut()				clipboard.cut();
	public function copy()				clipboard.copy();
	
	public function paste()				clipboard.paste();
	
	public function toggleSelection()	openedFiles.active.toggleSelection();
	public function deselectAll()		openedFiles.active.deselectAll();
}
