package components.nanofl.popups.fontpropertiespopup.item;

import js.JQuery;
import wquery.Event;

class Code extends wquery.Component
{
	public var event_removeVariant = new Event<JqEvent>();
	
	function removeVariant_click(e)
	{
		event_removeVariant.emit(null);
	}
	
	override public function remove()
	{
		q("#row").remove();
		
		super.remove();
	}
}