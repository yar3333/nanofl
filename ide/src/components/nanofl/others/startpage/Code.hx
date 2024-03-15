package components.nanofl.others.startpage;

import js.JQuery;
import nanofl.ide.Globals;
import nanofl.ide.Recents;
import nanofl.ide.commands.Commands;
import nanofl.ide.ui.menu.MenuTools;

@:rtti
class Code extends wquery.Component
{
	@inject var recents : Recents;
	@inject var commands : Commands;
    
	function init()
    {
		Globals.injector.injectInto(this);
		
		template().recents.on("click", ">li>a", (e:JqEvent) ->
		{
			MenuTools.onItemClick(q(e.target), commands);
		});
		
		template().creates.on("click", ">li>a", (e:JqEvent) ->
		{
			MenuTools.onItemClick(q(e.target), commands);
		});
		
		update();
    }
	
	public function update()
	{
		var xmlMenuItems = recents.getAsMenuItems(prefixID, { countLimit:10, lengthLimit:25 });
		
		template().recents.html
		(
			'<li class="nav-header"><i class="custom-icon-open"></i> Open Recent</li>'
			+ (xmlMenuItems.children.length > 0 ? xmlMenuItems.toString() : "")
		);
	}
}