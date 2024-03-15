package components.nanofl.common.dropdownmenu;

import nanofl.ide.Globals;
import nanofl.ide.commands.Commands;
import nanofl.ide.ui.menu.MenuTools;
import js.JQuery;

@:rtti
class Code extends wquery.Component
{
	@inject var commands : Commands;
    
	function init()
    {
		Globals.injector.injectInto(this);
		
		q("body").append(template().container.detach());
		
		template().menu.on("click", ">li>a[data-command]", (e:JqEvent) -> MenuTools.onItemClick(q(e.target), commands));
		template().container.click(_ -> template().container.hide());
    }
	
	public function show(button:JQuery, itemsHtml:String)
	{
		template().container.show();
		var p = button.offset();
		template().container.offset
		({
			left: p.left,
			top: p.top + button.outerHeight()
		});
		
		template().menu.html(itemsHtml);
	}
}