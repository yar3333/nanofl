package components.nanofl.others.output;

import nanofl.ide.Globals;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.View;
import js.JQuery;
import nanofl.ide.Application;
import nanofl.ide.ui.menu.ContextMenu;
using stdlib.Lambda;
using js.jquery.Selection;

@:rtti
class Code extends wquery.Component implements nanofl.ide.ui.views.IOutputView
{
	static var imports =
	{
		"context-menu": components.nanofl.common.contextmenu.Code
	};
	
	@inject var app : Application;
	@inject var preferences : Preferences;
	@inject var view : View;
	
	function init()
	{
		Globals.injector.injectInto(this);
		
		template().contextMenu.build(template().container, preferences.storage.getMenu("outputContextMenu"));
		
		template().container.on("mousedown", ">.error-in-file", function(e) e.preventDefault());
		
		template().container.on("click", ">.error-in-file", function(e)
		{
			var node = q(e.target);
			node.addClass("active");
			template().container.find(">*").not(node).removeClass("active");
		});
	}
	
	public function writeInfo(message:String) writeMessage("info", message);
	public function writeError(message:String) writeMessage("error", message);
	public function writeWarning(message:String) writeMessage("warn", message);
	
	function writeMessage(type:String, message:String) : Void
	{
		template().container.append(q('<span class=".output-' + type + '">' + StringTools.htmlEscape(message) + '\n</span>'));
	}
	
	public function writeCompileError(file:String, line:Int, startCh:Int, endCh:Int, message:String) : Void
	{
		var htmlMessage = StringTools.htmlEscape(message);
		
		var inner = '<i class="custom-icon-comment"></i>'
		      + ' ' + StringTools.htmlEscape(file) + ':' + line + ':'
			  + ' characters ' + startCh + "-" + endCh
			  + " : " + htmlMessage;
		
		var data =
		[
			"file" => file,
			"line" => Std.string(line),
			"start-ch" => Std.string(startCh),
			"end-ch" => Std.string(endCh)
		];
		
		var dataStr = data.keys().map(x -> "data-" + x + '="' + data.get(x) + '"').join(" ");
		
		template().container.append(q('<span class="error-in-file" title="' + htmlMessage + '" ' + dataStr + '>' + inner + '\n</span>'));
	}
	
	public function clear() : Void
	{
		template().container.html("");
	}
	
	public function show() template().container.show();
	
	public function hide() template().container.hide();
	
	public function activate()
	{
		(cast page : components.nanofl.page.Code).showOutputPanel();
	}
	
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.css("height", maxHeight);
	}
	
	public function on(event:String, callb:JqEvent->Void)
	{
		template().container.on(event, callb);
	}
	
	public function hasSelected() : Bool
	{
		return [ "", " " ].indexOf(JQuery.selection()) < 0;
	}
	
	public function getSelectedText() : String
	{
		return JQuery.selection();
	}
}