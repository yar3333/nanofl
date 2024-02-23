package components.nanofl.common.contextmenu;

import htmlparser.XmlBuilder;
import js.Browser;
import js.bootstrap.ContextMenu;
import js.JQuery;
import js.html.DocumentFragment;
import nanofl.ide.Application;
import nanofl.ide.Clipboard;
import nanofl.ide.Globals;
import nanofl.ide.OpenedFiles;
import nanofl.ide.commands.Commands;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.menu.MenuItem;
import nanofl.ide.ui.menu.MenuTools;
import wquery.AttachMode;
import wquery.Component;

@:rtti
class Code extends wquery.Component
{
	@inject var keyboard : Keyboard;
	@inject var commands : Commands;
	@inject var app : Application;
	@inject var openedFiles : OpenedFiles;
	@inject var clipboard : Clipboard;
	@inject var preferences : Preferences;
	
	function init()
	{
		Globals.injector.injectInto(this);
	}
	
	override function attachNode(node:js.html.Element, parentNode:JQuery, attachMode:AttachMode):Void 
	{
		parentNode.remove();
		Browser.document.body.appendChild(node);
	}
	
	public function build(target:JQuery, ?selector:String, items:Array<MenuItem>, ?toggleItems:Code->JqEvent->JQuery->Bool)
	{
		var out = new XmlBuilder();
		for (item in items)
		{
			MenuTools.writeItem(item, keyboard, prefixID, out);
		}
		template().content.html(out.toString());
		
		var savedActiveElement : js.html.Element;
		
		ContextMenu.contextmenu(target,
		{
			selector: selector,
			
			target: "#" + template().container.attr("id"),
			
			before: function(_, e:JqEvent, t:JQuery)
			{
				e.preventDefault();
				
				if (toggleItems != null)
				{
					if (!toggleItems(this, e, t)) return false;
				}
				else
				{
					getAllItems().show();
				}
				
				MenuTools.updateItemStates(template().container, app, openedFiles, clipboard, preferences);
				
				template().container.find(">ul>li.divider").show();
				var items = template().container.find(">ul>li").toArray().filter(item -> item.style.display != "none");
				
				while (items.length > 0 && new JQuery(items[0]).hasClass("divider"))
				{
					new JQuery(items[0]).hide();
					items = items.slice(1);
				}
				var i = 0; while (i < items.length)
				{
					if (new JQuery(items[i]).hasClass("divider") && (i + 1 == items.length || new JQuery(items[i + 1]).hasClass("divider")))
					{
						new JQuery(items[i]).hide();
						items.splice(i, 1);
					}
					else
					{
						i++;
					}
				}
				
				savedActiveElement = js.Browser.document.activeElement;
				
				return true;
			},
			
			onItem: function(_, e:JqEvent, menuItem:js.JQuery)
			{
				if (savedActiveElement != null) q(savedActiveElement).focus();
				MenuTools.onItemClick(menuItem, commands);
			},
			
			onShow: function(_)
			{
				MenuTools.fixWidth(template().container);
			}
		});
	}
	
	public function getItem(command:String) : JQuery
	{
		return template().container.find(">ul>li>a[data-command='" + command + "']").parent();
	}
	
	public function getAllItems() : JQuery
	{
		return template().container.find(">ul>li");
	}
	
	public function showItem(command:String) : Void
	{
		getItem(command).show();
	}
	
	public function toggleItem(command:String, b:Bool) : Void
	{
		getItem(command).toggle(b);
	}
	
	public function showItems(commands:Array<String>) : Void
	{
		for (command in commands) getItem(command).show();
	}
	
	public function enableItem(command:String, b:Bool) : Void
	{
		getItem(command).toggleClass("disabled", !b);
	}
}
