package nanofl.ide.commands;

@:rtti
class ClipboardGroup extends BaseGroup
{
	@inject var clipboard : Clipboard;

	public function cut()	clipboard.cut();
	public function copy()	clipboard.copy();
	public function paste()	clipboard.paste();
}
