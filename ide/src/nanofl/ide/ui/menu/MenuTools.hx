package nanofl.ide.ui.menu;

import haxe.Serializer;
import haxe.Unserializer;
import htmlparser.XmlBuilder;
import js.JQuery;
import nanofl.engine.libraryitems.FolderItem;
import nanofl.ide.Application;
import nanofl.ide.Clipboard;
import nanofl.ide.Document;
import nanofl.ide.OpenedFiles;
import nanofl.ide.commands.Commands;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.preferences.Preferences;
import stdlib.Std;
using stdlib.Lambda;

class MenuTools
{
	static var mustNotBeDefined : Array<String>;
	
	public static function findItem(items:Array<MenuItem>, id:String) : MenuItem
	{
		for (item in items)
		{
			if (item.id == id) return item;
			if (item.items != null)
			{
				var r = findItem(item.items, id);
				if (r != null) return r;
			}
		}
		return null;
	}
	
	public static function writeItem(item:MenuItem, keyboard:Keyboard, prefixID:String, nesting=0, out:XmlBuilder) : Void
	{
		var defines = item.version != null ? item.version.split(" ") : [];
		
		if (defines.foreach(x -> getMustNotBeDefined().indexOf(x) < 0))
		{
			if (item.items != null)
			{
				out.begin("li").attr("class", (nesting == 0 ? "dropdown" : "dropdown-submenu") + (item.align == "right" ? " pull-right": ""));
					if (item.id != null) out.attr("id", prefixID + item.id);
					out.begin("a");
						if (nesting == 0)
						{
							out.attr("class", "dropdown-toggle");
							out.attr("data-toggle", "dropdown");
						}
						else
						{
							out.attr("tabindex", "-1");
							out.attr("href", "javascript:void(0)");
							IconTools.write(item.icon, out);
						}
						out.content(item.name);
					out.end();
					out.begin("ul").attr("class", "dropdown-menu");
						for (subItem in item.items)
						{
							writeItem(subItem, keyboard, prefixID, nesting + 1, out);
						}
					out.end();
				out.end();
			}
			else
			{
				if (item.name != null && !(~/^-+$/.match(item.name)))
				{
					var isUrl = item.command != null && item.command.indexOf("://") >= 0;
					
					out.begin("li");
						if (item.id != null) out.attr("id", prefixID + item.id);
						out.begin("a").attr("href", isUrl ? item.command : "javascript:void(0)");
							if (isUrl)
							{
								out.attr("target", "_blank");
							}
							else
							{
								if (item.command != null) out.attr("data-command", item.command);
								if (item.params != null) out.attr("data-params", Serializer.run(item.params));
							}
							IconTools.write(item.icon, out);
							out.content(item.name);
							if (item.command != null && item.params == null && !isUrl)
							{
								var shortcut = keyboard.getShortcutsForCommand(item.command).join(", ");
								if (shortcut != "")
								{
									out.begin("span").attr("class", "shortcut").content(shortcut).end();
								}
							}
						out.end();
					out.end();
				}
				else
				{
					out.begin("li").attr("class", "divider").end();
				}
			}
		}
	}
	
	public static function fixWidth(container:JQuery)
	{
		var ul = container.find(">ul");
		var shortcuts = ul.find(">li>a>span.shortcut");
		var maxShortcutWidth = 0; for (shortcut in shortcuts) maxShortcutWidth = Std.max(maxShortcutWidth, shortcut.width());
		ul.css("width", "");
		ul.width(ul.width() + maxShortcutWidth + 10);
	}
	
	public static function updateItemStates(container:JQuery, app:Application, openedFiles:OpenedFiles, clipboard:Clipboard, preferences:Preferences) : Void
	{
		enableItemLazy(container, "openedFile.save",		function() return openedFiles.active != null && openedFiles.active.canBeSaved());
		
		enableItemLazy(container, "openedFile.undo",		function() return openedFiles.active != null && openedFiles.active.canUndo());
		enableItemLazy(container, "openedFile.redo",		function() return openedFiles.active != null && openedFiles.active.canRedo());
		
		enableItemLazy(container, "openedFile.cut",			function() return openedFiles.active != null && clipboard.canCut());
		enableItemLazy(container, "openedFile.copy",		function() return openedFiles.active != null && clipboard.canCopy());
		enableItemLazy(container, "openedFile.paste",		function() return openedFiles.active != null && clipboard.canPaste());
		enableItemLazy(container, "openedFile.toggleSelection",function() return openedFiles.active != null);
		enableItemLazy(container, "openedFile.deselectAll", function() return openedFiles.active != null);
		
		enableItemLazy(container, "document.save",			function() return app.document != null && app.document.canBeSaved());
		enableItemLazy(container, "document.test",			function() return app.document != null);
		enableItemLazy(container, "document.publish",		function() return app.document != null);
		enableItemLazy(container, "document.properties",	function() return app.document != null);
		enableItemLazy(container, "document.publishSettings",function() return app.document != null);
		enableItemLazy(container, "document.saveAs",		function() return openedFiles.active != null && openedFiles.active.type == OpenedFileType.DOCUMENT);
		
		enableItemLazy(container, "library.importImages", 	function() return app.document != null);
		enableItemLazy(container, "library.importSounds", 	function() return app.document != null);
		enableItemLazy(container, "library.importMeshes", 	function() return app.document != null);
		
		enableItemLazy(container, "document.undo",			function() return app.document != null && app.document.undoQueue.canUndo());
		enableItemLazy(container, "document.redo",			function() return app.document != null && app.document.undoQueue.canRedo());
		
		enableItemLazy(container, "document.cut",			function() return app.document != null && clipboard.canCut());
		enableItemLazy(container, "document.copy",			function() return app.document != null && clipboard.canCopy());
		enableItemLazy(container, "document.paste",			function() return app.document != null && clipboard.canPaste());
		
		enableItemLazy(container, "editor.cut",				function() return tempActiveView(app, ActiveView.EDITOR,	function() return app.document != null && clipboard.canCut()));
		enableItemLazy(container, "editor.copy",			function() return tempActiveView(app, ActiveView.EDITOR,	function() return app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "editor.paste",			function() return tempActiveView(app, ActiveView.EDITOR,	function() return app.document != null && clipboard.canPaste()));
		
		enableItemLazy(container, "library.cut",			function() return tempActiveView(app, ActiveView.LIBRARY,	function() return app.document != null && clipboard.canCut()));
		enableItemLazy(container, "library.copy",			function() return tempActiveView(app, ActiveView.LIBRARY,	function() return app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "library.paste",			function() return tempActiveView(app, ActiveView.LIBRARY,	function() return app.document != null && clipboard.canPaste()));
		
		enableItemLazy(container, "timeline.cut",			function() return tempActiveView(app, ActiveView.TIMELINE,	function() return app.document != null && clipboard.canCut()));
		enableItemLazy(container, "timeline.copy",			function() return tempActiveView(app, ActiveView.TIMELINE,	function() return app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "timeline.paste",			function() return tempActiveView(app, ActiveView.TIMELINE,	function() return app.document != null && clipboard.canPaste()));
		
		enableItemLazy(container, "output.copy",			function() return tempActiveView(app, ActiveView.OUTPUT, function() return clipboard.canCopy()));
		
		#if !no_trial
		toggleItem(container, "application.register", !preferences.application.registered);
		#end
	}

	public static function enableItem(container:JQuery, command:String, enable=true)
	{
		enableItemLazy(container, command, function() return enable);
	}

	public static function enableItemLazy(container:JQuery, command:String, enable:Void->Bool)
	{
		var a = container.find("a[data-command='" + command + "']");
		if (a.length > 0) a.parent().toggleClass("disabled", !enable());
	}
	
	public static function toggleItem(container:JQuery, command:String, show=true)
	{
		var a = container.find("a[data-command='" + command + "']");
		a.parent().toggle(show);
	}
	
	public static function onItemClick(a:JQuery, commands:Commands)
	{
		if (a[0].tagName.toLowerCase() != "a") a = a.parent();
		
		var command = a.attr("data-command");
		if (command != null && command != "")
		{
			var rawParams = a.attr("data-params");
			commands.run(command, rawParams != null && rawParams != "" ? Unserializer.run(rawParams) : []);
		}
	}
	
	static function getMustNotBeDefined() : Array<String>
	{
		if (mustNotBeDefined == null)
		{
			mustNotBeDefined = [];
			
			mustNotBeDefined.push
			(
				#if no_trial
				"trial"
				#else
				"no-trial"
				#end
			);
		}
		
		return mustNotBeDefined;
	}
	
	static function tempActiveView<T>(app:Application, view:ActiveView, callb:Void->T) : T
	{
		var saved = app.activeView;
		app.activeView = view;
		
		var r = callb();
		
		app.activeView = saved;
		
		return r;
	}
}