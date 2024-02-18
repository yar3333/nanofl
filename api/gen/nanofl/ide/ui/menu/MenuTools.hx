package nanofl.ide.ui.menu;

extern class MenuTools {
	static function findItem(items:Array<nanofl.ide.ui.menu.MenuItem>, id:String):nanofl.ide.ui.menu.MenuItem;
	static function writeItem(item:nanofl.ide.ui.menu.MenuItem, keyboard:nanofl.ide.keyboard.Keyboard, prefixID:String, ?nesting:Int, out:htmlparser.XmlBuilder):Void;
	static function fixWidth(container:js.JQuery):Void;
	static function updateItemStates(container:js.JQuery, app:nanofl.ide.Application, openedFiles:nanofl.ide.OpenedFiles, clipboard:nanofl.ide.Clipboard, preferences:nanofl.ide.preferences.Preferences):Void;
	static function enableItem(container:js.JQuery, command:String, ?enable:Bool):Void;
	static function enableItemLazy(container:js.JQuery, command:String, enable:() -> Bool):Void;
	static function toggleItem(container:js.JQuery, command:String, ?show:Bool):Void;
	static function onItemClick(a:js.JQuery, commands:nanofl.ide.commands.Commands):Void;
}