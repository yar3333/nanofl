package nanofl.ide.keyboard;

import js.Browser;
import js.JQuery;
import stdlib.Event;
using stdlib.Lambda;

@:rtti
class Keyboard
{
	var commands : Commands;
	
	public var keymap(default, null) = new Array<{ shortcut:String, command:String }>();
	
	var disabled = 0;
	
	public var onCtrlButtonChange : Event<{ pressed:Bool }>;
	public var onShiftButtonChange : Event<{ pressed:Bool }>;
	
	public var onKeymapChange : Event<{}>;
	public var onKeyDown : Event<KeyDownEvent>;
	
	public function new(commands:Commands)
	{
		onCtrlButtonChange = new Event<{ pressed:Bool }>(this);
		onShiftButtonChange = new Event<{ pressed:Bool }>(this);
	
		onKeymapChange = new Event<{}>(this);
		onKeyDown = new Event<KeyDownEvent>(this);
		
		this.commands = commands;
		
		new JQuery(Browser.document)
			.keydown(function(e:JqEvent)
			{
				log("key down");
				
				if (!isInputActive() 
				 && !Shortcut.ctrl(Keys.X).test(e)
				 && !Shortcut.ctrl(Keys.C).test(e)
				 && !Shortcut.ctrl(Keys.V).test(e))
				{
					log("key down(1)");
					if (disabled <= 0)
					{
						log("key down(2)");
						if (e.keyCode == Keys.CTRL)
						{
							onCtrlButtonChange.call({ pressed:true });
						}
						if (e.keyCode == Keys.SHIFT)
						{
							onShiftButtonChange.call({ pressed:true });
						}
						
						var processed = false;
						
						onKeyDown.call
						({
							altKey : e.altKey,
							ctrlKey : e.ctrlKey,
							shiftKey : e.shiftKey,
							processShortcut : function(filter:String)
							{
								var r = processShortcut(e, keymap, filter);
								if (r) processed = true;
								return r;
							}
						});
						
						if (processed)
						{
							e.preventDefault();
							e.stopPropagation();
						}
						
						log("key processed");
					}
				}
			})
			.keyup(function(e)
			{
				if (disabled > 0) return;
				
				if (e.keyCode == Keys.SHIFT)
				{
					onShiftButtonChange.call({ pressed:false });
				}
				if (e.keyCode == Keys.CTRL)
				{
					onCtrlButtonChange.call({ pressed:false });
				}
			});
	}
	
	public function setKeymap(keymap:Array<{ shortcut:String, command:String }>)
	{
		this.keymap = keymap;
		
		for (command in keymap.map((x) -> x.command))
		{
			commands.validateCommand(command);
		}
		
		onKeymapChange.call(null);
	}
	
	public function getShortcutsForCommand(command:String) : Array<String>
	{
		commands.validateCommand(command);
		return getKeymap().filter((x) -> x.command == command).map((x) -> x.shortcut);
	}
	
	public function getGroupedKeymap() : Array<{ shortcuts:String, command:String }>
	{
		var keymap = getKeymap();
		
		var r = [];
		var i = 0; while (i < keymap.length)
		{
			var shortcuts = [ keymap[i].shortcut ];
			var j = i + 1; while (j < keymap.length)
			{
				if (keymap[i].command == keymap[j].command)
				{
					shortcuts.push(keymap[j].shortcut);
					keymap.splice(j, 1);
				}
				else
				{
					j++;
				}
			}
			r.push({ shortcuts:shortcuts.join(", "), command:keymap[i].command });
			
			i++;
		}
		
		return r.sorted((a, b) -> Reflect.compare(a.command, b.command));
	}
	
	public function enable()  disabled--;
	public function disable() disabled++;
	
	function getKeymap() : Array<{ shortcut:String, command:String }>
	{
		var r = keymap.copy();
		
		r.push({ shortcut:"Ctrl+X", command:"document.cut" });
		r.push({ shortcut:"Ctrl+C", command:"document.copy" });
		r.push({ shortcut:"Ctrl+V", command:"document.paste" });
		
		r.push({ shortcut:"Ctrl+X", command:"editor.cut" });
		r.push({ shortcut:"Ctrl+C", command:"editor.copy" });
		r.push({ shortcut:"Ctrl+V", command:"editor.paste" });
		
		r.push({ shortcut:"Ctrl+X", command:"library.cut" });
		r.push({ shortcut:"Ctrl+C", command:"library.copy" });
		r.push({ shortcut:"Ctrl+V", command:"library.paste" });
		
		r.push({ shortcut:"Ctrl+X", command:"timeline.cut" });
		r.push({ shortcut:"Ctrl+C", command:"timeline.copy" });
		r.push({ shortcut:"Ctrl+V", command:"timeline.paste" });
		
		return r;
	}
	
	function isInputActive() : Bool
	{
		var activeElement = Browser.document.activeElement;
        if (activeElement == null) return false;
        if (!["textarea", "input", "select"].contains(activeElement.nodeName.toLowerCase())) return false;
        return true;
        //var style = Browser.window.getComputedStyle(activeElement);
		//return style.display != "none";
	}
	
	function processShortcut(e:{ keyCode:Int, ctrlKey:Bool, shiftKey:Bool, altKey:Bool }, keymap:Array<{ shortcut:String, command:String }>, filter:String) : Bool
	{
		var key = "";
		
		if (e.ctrlKey) key += "Ctrl+";
		if (e.shiftKey) key += "Shift+";
		if (e.altKey) key += "Alt+";
		
		key += Keys.toString(e.keyCode);
		
		var km = keymap.find((x) ->
			x.shortcut == key &&
			(filter == null || filter == "" || filter == x.command.split(".")[0])
		);
		
		if (km == null) return false;
		
		return commands.run(km.command);
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}