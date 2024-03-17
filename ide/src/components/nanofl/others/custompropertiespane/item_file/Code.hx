package components.nanofl.others.custompropertiespane.item_file;

import haxe.Unserializer;
import nanofl.ide.Globals;
import nanofl.ide.ui.Popups;

@:rtti
class Code extends wquery.Component
{
	@inject var popups : Popups;

    var title = "";
    var name = "";
    var value ="";
    var fileFilters = "";
	var onChange = (v:String) -> {};

    var label = ""; // unused, just to prevent wquery warning
    var units = ""; // unused, just to prevent wquery warning
	
	function init()
	{
		Globals.injector.injectInto(this);
	}
	
	function browse_click(e)
	{
		popups.showOpenFile
		(
			template().value.attr("title"),
			Unserializer.run(template().browse.attr("data-file-filters"))
		)
        .then(filePath -> 
        {
            if (filePath == null) return;
            
            template().value.val(filePath);
            value_change(null);
        });
	}
	
	function value_change(_) if (onChange != null) onChange(template().value.val());
}