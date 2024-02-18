package nanofl.ide.commands;

import nanofl.ide.ui.View;

@:rtti
class CodeGroup extends BaseGroup
{
	@inject var view : View;
	@inject var clipboard : Clipboard;
	@inject var openedFiles : OpenedFiles;
	
	public function compile() openedFiles.active.relatedDocument.publish();
	public function run() openedFiles.active.relatedDocument.test();
}