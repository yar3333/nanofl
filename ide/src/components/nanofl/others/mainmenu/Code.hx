package components.nanofl.others.mainmenu;

import js.JQuery;
import htmlparser.XmlBuilder;
import nanofl.ide.Clipboard;
import nanofl.ide.Globals;
import nanofl.ide.OpenedFiles;
import nanofl.ide.Recents;
import nanofl.ide.commands.Commands;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.Application;
import nanofl.ide.ui.View;
import nanofl.ide.ui.menu.MenuTools;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.ui.views.IMainMenuView;
using stdlib.Lambda;
using StringTools;

@:rtti
class Code extends wquery.Component implements IMainMenuView
{
	@inject var app : Application;
	@inject var preferences : Preferences;
	@inject var recents : Recents;
	@inject var commands : Commands;
	@inject var keyboard : Keyboard;
	@inject var openedFiles : OpenedFiles;
	@inject var clipboard : Clipboard;
	@inject var view : View;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		// prevent menu from hiding when click on disabled item & divider
		template().container.on("click", ".dropdown-menu", function(e)
		{
			if (q(e.target).hasClass("dropdown-menu") || q(e.target).hasClass("disabled"))
			{
				e.stopPropagation();
			}
		});
		
		template().content.on("click", ">li>ul>li a", function(e) MenuTools.onItemClick(new JQuery(e.target), commands));
		
		update();
	}
	
	public function offset(pos:{ left:Int, top:Int })
	{
		template().container.offset(pos);
	}
	
	public function update()
	{
		final items = preferences.storage.getMenu("mainMenu");
		
		final importMenuItem = MenuTools.findItem(items, "import");
		for (importer in ImporterPlugins.plugins)
		{
			importMenuItem.items.push
			({
				name: importer.menuItemName,
				icon: importer.menuItemIcon,
				command: "document.import",
				params: [ importer.name ]
			});
		}
		
		final exportMenuItem = MenuTools.findItem(items, "export");
		for (exporter in ExporterPlugins.plugins)
		{
			exportMenuItem.items.push
			({
				name: exporter.menuItemName,
				icon: exporter.menuItemIcon,
				command: "document.export",
				params: [ exporter.name ]
			});
		}
		
		final out = new XmlBuilder();
		for (item in items)
		{
			MenuTools.writeItem(item, keyboard, prefixID, out);
		}
		template().content.html(out.toString());
		
		q("<input type='file' id='file' class='file' title='' />")
			.on("mouseover", _ -> q("#fileUpload>a").focus())
			.on("mouseout",  _ -> q("#fileUpload>a").blur())
			.prependTo(q("#fileUpload"));
		
		template().container.find(".shortcut").css("position", "absolute");
		
		final mainItems = template().container.find(".nav>li");
		final aa = mainItems.find(">a");
		aa.mouseover(e ->
		{
			if (mainItems.is(".open"))
			{
				mainItems.removeClass("open");
				var li = q(e.currentTarget).parent();
				li.addClass("open");
				MenuTools.fixWidth(li);
				MenuTools.updateItemStates(li, app, openedFiles, clipboard, preferences, view.movie.timeline);
			}
		});
		aa.on("mouseout", e -> q(e.currentTarget).blur());
		
		mainItems.click(e ->
		{
			if (!q(e.currentTarget).hasClass("open"))
			{
				MenuTools.updateItemStates(q(e.currentTarget), app, openedFiles, clipboard, preferences, view.movie.timeline);
				q(e.currentTarget).addClass("open");
				MenuTools.fixWidth(q(e.currentTarget));
				q(e.currentTarget).removeClass("open");
			}
		});
		
		updateRecents();
		
		enableMenuItem("timeline",	app.document != null);
		enableMenuItem("editor",	app.document != null);
		enableMenuItem("library",	app.document != null);
		enableMenuItem("export", 	app.document != null);
	}
	
	function enableMenuItem(id:String, enable:Bool)
	{
		q("#" + id).toggleClass("disabled", !enable);
	}
	
	function updateRecents()
	{
		q("#fileRecents>ul").html(recents.getAsMenuItems(prefixID).toString());
	}
}