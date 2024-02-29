package components.nanofl.popups.soundpropertiespopup;

import nanofl.engine.libraryitems.SoundItem;
import nanofl.ide.Application;

@:rtti
class Code extends components.nanofl.popups.basepopup.Code
{
	@inject var app : Application;
	
    var item : SoundItem;
	
	public function show(item:SoundItem)
	{
		this.item = item;
		
		template().loop.prop("checked", item.loop);
		template().linkage.val(item.linkage);
		
		showPopup();
	}
	
	override function onOK()
	{
		app.document.undoQueue.beginTransaction({ libraryChangeItems:[ item.namePath ] });
		
		item.loop = template().loop.prop("checked");
		item.linkage = template().linkage.val();
		
		app.document.undoQueue.commitTransaction();
		
		app.document.library.update();
	}
}