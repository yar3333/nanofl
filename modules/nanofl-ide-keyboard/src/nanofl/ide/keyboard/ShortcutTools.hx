package nanofl.ide.keyboard;

using stdlib.StringTools;

class ShortcutTools
{
	public static function equ(a:Shortcut, b:Shortcut) : Bool
	{
		return a.keyCode == b.keyCode
			&& a.ctrlKey == b.ctrlKey
			&& a.shiftKey == b.shiftKey
			&& a.altKey == b.altKey;
	}
	
	public static function key(keyCode:Int) : Shortcut return { keyCode:keyCode };
	public static function ctrl(keyCode:Int) : Shortcut return { keyCode:keyCode, ctrlKey:true };
	public static function shift(keyCode:Int) : Shortcut return { keyCode:keyCode, shiftKey:true };
	public static function alt(keyCode:Int) : Shortcut return { keyCode:keyCode, altKey:true };
	public static function ctrlShift(keyCode:Int) : Shortcut return { keyCode:keyCode, ctrlKey:true, shiftKey:true };

    public static function toString(e:Shortcut) : String
    {
        return (e.ctrlKey ? "Ctrl+" : "")
             + (e.shiftKey ? "Shift+" : "")
             + (e.altKey ? "Alt+" : "")
             + Keys.toString(e.keyCode);
    }
}