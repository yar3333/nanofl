package components.nanofl.popups.basepopup;

import nanofl.ide.Globals;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.keyboard.Keys;
import nanofl.ide.keyboard.Shortcut;
using js.bootstrap.Modal;
using nanofl.ide.keyboard.ShortcutTools;

@:rtti
class Code extends wquery.Component
{
	static var opened = new Array<components.nanofl.popups.basepopup.Code>();
	
	@inject var keyboard : Keyboard;
	
	function init()
    {
		Globals.injector.injectInto(this);
		
        var popup = template().popup;
		
		popup.modal({ backdrop:false, keyboard:false, show:false });
		
		popup.keypress(e ->
		{
			if (ShortcutTools.key(Keys.ENTER).equ(e))
			{
				popup.find(".btn-primary").click();
			}
			else
			if (ShortcutTools.key(Keys.ESCAPE).equ(e))
			{
				cancel_click(null);
			}
		});
		
		popup.on("hidden", _ ->
		{
            keyboard.enable();
			
            onClose();
			
			template().overlay.hide();
			
			var self = opened.pop();
			if (self != this) trace("WARNING: unexpected popup close.");
			
			if (opened.length > 0)
			{
				opened[opened.length - 1].template().overlay.show();
			}
		});
    }
	
	function showPopup()
	{
		keyboard.disable();
		if (opened.length > 0) opened[opened.length - 1].template().overlay.hide();
		
		opened.push(this);
		
		var zIndex = 2000 + opened.length;
		template().overlay.css("z-index", zIndex);
		template().popup.css("z-index", zIndex);
		
		template().popup.css("max-width", (js.Browser.window.innerWidth - 10) + "px");
		template().popup.css("max-height", (js.Browser.window.innerHeight - 10) + "px");
		
		template().overlay.show();
		template().popup.modalShow();
		
		center();
	}
	
	function center()
	{
		template().popup.css("top", (q(js.Browser.window).height() - template().popup.height()) / 3);
		template().popup.css("margin-left", -template().popup.width() / 2);
	}
	
	function hide()
	{
		template().popup.modalHide();
	}
	
	function ok_click    (_) { onOK();     hide(); }
	function cancel_click(_) { onCancel(); hide(); }
	function close_click (_) cancel_click(null);
	
	function onOK() : Void {}
	function onCancel() : Void {}
	function onClose() : Void {}
}