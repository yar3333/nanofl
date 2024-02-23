package components.nanofl.popups.tabbablepopup;

import js.JQuery;
import nanofl.ide.ui.IconTools;
using stdlib.Lambda;

class Code extends components.nanofl.popups.basepopup.Code
{
	var callb : Void->Void;
	
	override function init()
	{
		super.init();
		
		template().parts.on("click", ">li a[data-value], >li button[data-value]", function(e)
		{
			initPane(q(e.currentTarget).attr("data-value"));
		});
	}
	
	public function show(?callb:Void->Void)
	{
		this.callb = callb;
		
		initPopup();
		template().parts.html(getLinks().join(""));
		showPopup();
		
		template().parts.append("<li />");
		
		var maxHeight = template().tabbable.parent().innerHeight();
		template().parts.height(maxHeight);
		template().panes.height(maxHeight);
		
		updatePartsFillerHeight();
		initFirst();
	}
	
	function initFirst()
	{
		template().panes.find(">*").removeClass("active");
		template().parts.find(">li>a").first().click();
	}
	
	function updatePartsFillerHeight()
	{
		var items = JQuery.makeArray(template().parts.find(">li"));
		items.pop();
		var itemsHeight = items.map(x -> q(x).outerHeight(true)).fold((a, b) -> a + b, 0);
		template().parts.find(">li:last-child").height(template().parts.height() - itemsHeight);
	}
	
	function createHeaderTab(name:String) : String
	{
		return "<li class='nav-header'>" + name + "</li>";
	}
	
	function createItemTab(pane:JQuery, command:String, prefix:String, name:String, icon:String, grey:Bool, preHtml="") : String
	{
		return "<li>"
				+ preHtml
				+ "<a"
					+ " href='#" + pane.attr("id") + "'"
					+ " data-value='" + prefix + "-" + command + "'"
					+ " data-toggle='tab'"
					+ (grey ? " class='grey'" : "")
					+ ">"
					+ IconTools.toHtml(icon) + " " + name
				+ "</a>"
			 + "</li>";
 	}
	
	function setLinkGrey(command:String, grey:Bool)
	{
		template().parts.find(">li>a[data-value=" + command + "]").toggleClass("grey", grey);
	}
	
	function initPopup() {}
	function getLinks() : Array<String> return [];
	function initPane(command:String) {}
	
	override function onClose()
	{
		if (callb != null) callb();
	}
}