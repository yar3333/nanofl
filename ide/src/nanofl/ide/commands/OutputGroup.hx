package nanofl.ide.commands;

import nanofl.ide.ui.View;

@:rtti
class OutputGroup extends BaseGroup
{
	@inject var view : View;
	@inject var clipboard : Clipboard;
	
	public function clear()	view.output.clear();
	public function copy()	tempActiveView(ActiveView.OUTPUT, clipboard.copy);
}
