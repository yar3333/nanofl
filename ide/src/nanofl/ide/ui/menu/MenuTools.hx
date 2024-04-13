package nanofl.ide.ui.menu;

import haxe.Json;
import js.JQuery;
import htmlparser.XmlBuilder;
import nanofl.engine.Log.console;
import nanofl.ide.Application;
import nanofl.ide.Clipboard;
import nanofl.ide.OpenedFiles;
import nanofl.ide.commands.Commands;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.views.TimelineView;
import stdlib.Std;
using stdlib.Lambda;
using StringTools;

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
				final r = findItem(item.items, id);
				if (r != null) return r;
			}
		}
		return null;
	}
	
	public static function writeItem(item:MenuItem, keyboard:Keyboard, prefixID:String, nesting=0, out:XmlBuilder) : Void
	{
		var defines = item.version != null ? item.version.split(" ") : [];
		if (defines.exists(x -> getMustNotBeDefined().contains(x))) return;
		
        if (item.items != null)
            writeSubMenu(item, keyboard, prefixID, nesting, out);
        else
        {
            if (item.name != null && !(~/^-+$/.match(item.name)))
                writeSimpleMenuItem(item, keyboard, prefixID, nesting, out);
            else
                out.begin("li").attr("class", "divider").end();
        }
	}

	static function writeSubMenu(item:MenuItem, keyboard:Keyboard, prefixID:String, nesting=0, out:XmlBuilder) : Void
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
	
	static function writeSimpleMenuItem(item:MenuItem, keyboard:Keyboard, prefixID:String, nesting=0, out:XmlBuilder) : Void
	{
        final isUrl = item.command != null && item.command.indexOf("://") >= 0;
        
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
                    if (item.params != null) out.attr("data-params", StringTools.htmlEscape(Json.stringify(item.params), true));
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

	public static function fixWidth(container:JQuery)
	{
		final ul = container.find(">ul");
		final shortcuts = ul.find(">li>a>span.shortcut");
		var maxShortcutWidth = 0; for (shortcut in shortcuts) maxShortcutWidth = Std.max(maxShortcutWidth, shortcut.width());
		ul.css("width", "");
		ul.width(ul.width() + maxShortcutWidth + 10);
	}
	
	public static function updateItemStates(container:JQuery, app:Application, openedFiles:OpenedFiles, clipboard:Clipboard, preferences:Preferences, timelineView:TimelineView) : Void
	{
        final document = app.document;
        final library = document?.library;

        enableItemLazy(container, "clipboard.cut",			    () -> document != null && clipboard.canCut());
		enableItemLazy(container, "clipboard.copy",		        () -> document != null && clipboard.canCopy());
		enableItemLazy(container, "clipboard.paste",		    () -> document != null && clipboard.canPaste());
		
		enableItemLazy(container, "document.save",			    () -> document != null && document.canBeSaved());
		enableItemLazy(container, "document.test",			    () -> document != null);
		enableItemLazy(container, "document.publish",		    () -> document != null);
		enableItemLazy(container, "document.properties",	    () -> document != null);
		enableItemLazy(container, "document.publishSettings",   () -> document != null);
		enableItemLazy(container, "document.saveAs",		    () -> document != null);
		enableItemLazy(container, "document.undo",			    () -> document != null && document.undoQueue.canUndo());
		enableItemLazy(container, "document.redo",			    () -> document != null && document.undoQueue.canRedo());
		
        enableItemLazy(container, "document.cut",			    () -> document != null && clipboard.canCut());
		enableItemLazy(container, "document.copy",			    () -> document != null && clipboard.canCopy());
		enableItemLazy(container, "document.paste",			    () -> document != null && clipboard.canPaste());
		
		enableItemLazy(container, "library.importFiles", 	    () -> document != null);
		enableItemLazy(container, "library.rename", 	        () -> library != null && library.getSelectedItems().length == 1);
		enableItemLazy(container, "library.properties", 	    () -> library != null && library.getSelectedItems().length == 1);
		enableItemLazy(container, "library.duplicate", 	        () -> library != null && library.getSelectedItems().length > 0);
		
        enableItemLazy(container, "library.cut",			    () -> tempActiveView(app, ActiveView.LIBRARY,	() -> app.document != null && clipboard.canCut()));
		enableItemLazy(container, "library.copy",			    () -> tempActiveView(app, ActiveView.LIBRARY,	() -> app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "library.paste",			    () -> tempActiveView(app, ActiveView.LIBRARY,	() -> app.document != null && clipboard.canPaste()));

        enableItemLazy(container, "timeline.createTween",       () -> timelineView.hasSelectedFramesWithoutTween());
		enableItemLazy(container, "timeline.removeTween",       () -> timelineView.hasSelectedFramesWithTween());
		
        enableItemLazy(container, "timeline.cut",			    () -> tempActiveView(app, ActiveView.TIMELINE,	() -> app.document != null && clipboard.canCut()));
		enableItemLazy(container, "timeline.copy",			    () -> tempActiveView(app, ActiveView.TIMELINE,	() -> app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "timeline.paste",			    () -> tempActiveView(app, ActiveView.TIMELINE,	() -> app.document != null && clipboard.canPaste()));
		
		enableItemLazy(container, "editor.cut",				    () -> tempActiveView(app, ActiveView.EDITOR,	() -> app.document != null && clipboard.canCut()));
		enableItemLazy(container, "editor.copy",			    () -> tempActiveView(app, ActiveView.EDITOR,	() -> app.document != null && clipboard.canCopy()));
		enableItemLazy(container, "editor.paste",			    () -> tempActiveView(app, ActiveView.EDITOR,	() -> app.document != null && clipboard.canPaste()));
	}

	public static function enableItem(container:JQuery, command:String, enable=true)
	{
		enableItemLazy(container, command, () -> enable);
	}

	static function enableItemLazy(container:JQuery, command:String, enable:Void->Bool)
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
			commands.run(command, parseParams(a.attr("data-params")));
		}
	}
	
	static function getMustNotBeDefined() : Array<String>
	{
		if (mustNotBeDefined == null)
		{
			mustNotBeDefined = [];

            // ADD CODE HERE
		}
		
		return mustNotBeDefined;
	}
	
	static function tempActiveView<T>(app:Application, view:ActiveView, callb:Void->T) : T
	{
		final saved = app.activeView;
		app.setActiveView(view, null);
		
		final r = callb();
		
		app.setActiveView(saved, null);
		
		return r;
	}

    static function parseParams(rawParams:String) : Array<Dynamic>
    {
        if (rawParams == null) return [];
        rawParams = rawParams.trim();
        if (rawParams == "") return [];
        rawParams = StringTools.htmlUnescape(rawParams);
        final r = Json.parse(rawParams);
        if (!Std.isOfType(r, Array))
        {
            console.warn("MenuTools: menu item params must be array in json format (found: " + rawParams + ").");
            return [];
        }
        return r;
    }
}