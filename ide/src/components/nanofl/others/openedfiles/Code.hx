package components.nanofl.others.openedfiles;

import js.Browser;
import js.lib.Promise;
import haxe.io.Path;
import htmlparser.XmlBuilder;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.ui.View;
import nanofl.ide.ui.menu.MenuTools;
import wquery.ComponentList;
import js.JQuery;
import nanofl.ide.Application;
import nanofl.ide.Document;
import nanofl.ide.OpenedFiles;
import nanofl.ide.ui.IconTools;
import nanofl.ide.OpenedFile;
import nanofl.ide.ui.menu.MenuItem;
import stdlib.Debug;
import stdlib.Std;
import nanofl.ide.Globals;
using stdlib.Lambda;

@:rtti
class Code extends wquery.Component
{
	static var imports =
	{
		"dropdown-menu": components.nanofl.common.dropdownmenu.Code
	};
	
	@inject var view : View;
	@inject var keyboard : Keyboard;
	
	public var active(default, null) : OpenedFile;
	
	var templateItems : ComponentList<components.nanofl.others.openedfiles.item.Code>;
	var items : Array<OpenedFile> = new Array<OpenedFile>();
	
	public var length(get, never) : Int;
	function get_length() return items.length;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		templateItems = new ComponentList<components.nanofl.others.openedfiles.item.Code>(components.nanofl.others.openedfiles.item.Code, this, template().tabs);
		
		template().tabs.on("click", ">li>a", function(e)
		{
			var li = new JQuery(e.currentTarget).parent();
			var doc = items.find(x -> x.id == li.attr("data-id"));
			doc.activate();
		});
		
		template().tabs.on("click", ">li>a>button", function(e:JqEvent)
		{
			e.stopPropagation();
			var li = new JQuery(e.currentTarget).parent().parent();
			var doc = items.find(x -> x.id == li.attr("data-id"));
			doc.close();
		});
	}
	
	public function add(doc:OpenedFile)
	{
		items.push(doc);
		addTab(doc, true);
		normalizeTabCount();
	}
	
	public function close(doc:OpenedFile)
	{
		var n = items.indexOf(doc);
		if (n >= 0)
		{
			removeTab(doc.id);
			items.remove(doc);
			if (active == doc)
			{
				n = Std.min(n, items.length - 1);
				if (n >= 0) items[n].activate();
				else        activate(null);
			}
		}
	}
	
	public function activate(id:String)
	{
		if (active != null && active.id == id) return;
		
		if (active != null) active.deactivate();
		
		template().tabs.find(">li").removeClass("active");
		template().tabs.find(">li>a")
			.css("color", "")
			.css("backgroundColor", "");
		
		if (id != null)
		{
			var n = items.findIndex(x -> x.id == id);
			Debug.assert(n >= 0);
			active = items[n];
			Debug.assert(active != null);
			
			if (n < items.length - 1)
			{
				items.splice(n, 1);
				items.push(active);
			}
			
			var li = getLi(id);
			if (li.length == 0)
			{
				addTab(active, true);
				normalizeTabCount();
				li = getLi(id);
			}
			li.addClass("active");
			
			li.find(">a")
			  .css("color", li.data("textColor"))
			  .css("background-color", li.data("backgroundColor"));
		}
		else
		{
			active = null;
		}
		
		var page = (cast this.page : components.nanofl.page.Code);
		
		if (Std.isOfType(active, Document))
		{
			page.template().startPage.hide();
			page.template().moviePage.show();
			
			view.movie.resize();
		}
		else
		{
			page.template().moviePage.hide();
			page.template().startPage.show();
			
			view.library.update();
			view.properties.update();
		}
		
		titleChanged(active);
		view.mainMenu.update();
	}
	
	public function closeAll(?force:Bool) : Promise<{}>
	{
		var items = this.items.copy();
		
		var queue = Promise.resolve();
		
		for (item in items)
		{
			queue = queue.then(function(_)
			{
				log("close " + item.id);
				return item.close(force);
			});
		}
		
		return queue.then(function(_)
		{
			log("finish closing");
			return null;
		});
	}
	
	function addTab(doc:OpenedFile, append:Bool)
	{
		templateItems.create
		(
			{
				documentID: doc.id,
				icon: IconTools.toHtml(doc.getIcon()),
				name: doc.getShortTitle(),
				title: doc.getLongTitle(),
				textColor: doc.getTabTextColor(),
				backgroundColor: doc.getTabBackgroundColor()
			},
			append
		);
	}
	
	function removeTab(id:String)
	{
		getLi(id).remove();
	}
	
	public function iterator()
	{
		return items.iterator();
	}
	
	public function outerHeight() return template().tabs.outerHeight();
	
	public function titleChanged(doc:OpenedFile) : Void
	{
		if (doc == active)
		{
			Browser.document.title = active != null ? active.getShortTitle() + " - NanoFL" : "NanoFL";
			
			if (active != null)
			{
				var li = getLi(active.id);
				li.find(">a>span").html(active.getShortTitle());
				li.find(">a").attr("title", active.getLongTitle());
			}
		}
	}
	
	function getLi(id:String) : JQuery
	{
		return template().tabs.find(">li[data-id=" + id + "]");
	}
	
	function toggleMenu_click(e)
	{
		var menuItems = new XmlBuilder();
		
		for (item in items)
		{
			MenuTools.writeItem
			(
				{
					name: Path.withoutDirectory(item.getPath()),
					command: "application.openFile",
					params: [ item.getPath() ],
					icon: item.getIcon(),
					title: item.getPath()
				},
				keyboard,
				"",
				menuItems
			);
		}
		
		template().menu.show(template().toggleMenu, menuItems.toString());
	}
	
	function normalizeTabCount()
	{
		var maxWidth = template().container.width() - template().toggleMenu.width() - 10;
		var tabs = template().tabs.find(">*");
		
		var width = 0; for (tab in tabs) width += tab.outerWidth();
		
		var revItems = items.copy();
		revItems.reverse();
		
		while (width < maxWidth && items.exists(x -> !tabs.exists(y -> x.id == y.data("id"))))
		{
			for (item in revItems)
			{
				if (!tabs.exists(x -> item.id == x.data("id")))
				{
					addTab(item, false);
					tabs = template().tabs.find(">*");
					width += getLi(item.id).outerWidth();
					break;
				}
			}
		}
		
		if (tabs.length > 1)
		{
			while (tabs.length > 1 && width > maxWidth)
			{
				width -= q(tabs[0]).outerWidth();
				tabs[0].remove();
				tabs = tabs.not(tabs[0]);
			}
		}
	}
	
	public function resize()
	{
		normalizeTabCount();
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}