package nanofl.ide.keyboard;

import js.Browser;
import js.JQuery;
import stdlib.Event;
using stdlib.Lambda;
using stdlib.StringTools;
using nanofl.ide.keyboard.ShortcutTools;

@:rtti
class Keyboard
{
	final commands : Commands;
	
	public var keymap(default, null) = new Array<KeymapItem>();
	
	public final onCtrlButtonChange : Event<{ pressed:Bool }>;
	public final onShiftButtonChange : Event<{ pressed:Bool }>;
	public final onAltButtonChange : Event<{ pressed:Bool }>;
	
	public final onKeymapChange : Event<{}>;
	public final onKeyDown : Event<KeyDownEvent>;
	
	var disabled = 0;
	public function enable()  disabled--;
	public function disable() disabled++;
	
	public function new(commands:Commands)
	{
		onCtrlButtonChange = new Event<{ pressed:Bool }>(this);
		onShiftButtonChange = new Event<{ pressed:Bool }>(this);
		onAltButtonChange = new Event<{ pressed:Bool }>(this);
	
		onKeymapChange = new Event<{}>(this);
		onKeyDown = new Event<KeyDownEvent>(this);
		
		this.commands = commands;
		
		new JQuery(Browser.document)
			.keydown(e ->
			{
				//log("keydown");
				
				if (!isInputActive() 
				 && !ShortcutTools.ctrl(Keys.X).equ(e)
				 && !ShortcutTools.ctrl(Keys.C).equ(e)
				 && !ShortcutTools.ctrl(Keys.V).equ(e))
				{
                    //log("keydown: disabled = " + disabled);
                    if (disabled <= 0)
                    {
                        processKeyDown(e);
                    }
				}
			})
			.keyup(e ->
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

    function processKeyDown(e:JqEvent)
    {
        switch (e.keyCode)
        {
            case Keys.CTRL:
                onCtrlButtonChange.call({ pressed:true });
                
            case Keys.SHIFT:
                onShiftButtonChange.call({ pressed:true });

            case Keys.ALT: 
                onAltButtonChange.call({ pressed:true });

            case _:
                var processed = false;

                onKeyDown.call
                ({
                    altKey : e.altKey,
                    ctrlKey : e.ctrlKey,
                    shiftKey : e.shiftKey,
                    processShortcut : (filter, whenVars) ->
                    {
                        final r = processShortcut(e, keymap, filter, whenVars);
                        if (r) processed = true;
                        return r;
                    }
                });

                log("processed = " + processed);
                
                if (processed)
                {
                    e.preventDefault();
                    e.stopPropagation();
                }
        }
    }
	
	public function setKeymap(keymap:Array<KeymapItem>)
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
	
	function getKeymap() : Array<KeymapItem>
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
	}
	
	function processShortcut(e:Shortcut, keymap:Array<KeymapItem>, filter:String, whenVars:WhenVars) : Bool
	{
        filter = filter ?? "";

		final shortcut = e.toString();
        log("shortcut = " + shortcut + "; filter = " + filter);
		
		final km = keymap.find(x -> x.shortcut == shortcut && (filter == "" || filter == x.command.split(".")[0]) && testWhen(x.when, whenVars));
		if (km == null) return false;
        
        log("command = " + km.command);
		
		return commands.run(km.command);
	}

    function testWhen(when:String, vars:WhenVars) : Bool
    {
        if (when == null || when.trim() == "") return true;
        
        final editor = vars.editor;
        final library = vars.library;
        return js.Lib.eval(when);
    }
	
	static function log(v:Dynamic)
	{
		//trace(Reflect.isFunction(v) ? v() : v);
	}
}