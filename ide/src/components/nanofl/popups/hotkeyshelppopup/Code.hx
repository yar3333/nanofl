package components.nanofl.popups.hotkeyshelppopup;
import wquery.ComponentList;

class Code extends components.nanofl.popups.basepopup.Code
{
	var hotkey : ComponentList<components.nanofl.popups.hotkeyshelppopup_item.Code>;
	
	override function init()
	{
		super.init();
		
		hotkey = new ComponentList<components.nanofl.popups.hotkeyshelppopup_item.Code>(components.nanofl.popups.hotkeyshelppopup_item.Code, this, template().hotkeys);
	}
	
	public function show()
	{
		template().pane.css("max-height", Math.round(js.Browser.window.innerHeight * 0.7 - 100) + "px");
		
		hotkey.clear();
		
		for (hk in keyboard.getGroupedKeymap())
		{
			// TODO: check params
			hotkey.create(hk);
		}
		
		showPopup();
	}
}