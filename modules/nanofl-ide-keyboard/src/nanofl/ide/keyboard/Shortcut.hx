package nanofl.ide.keyboard;

class Shortcut
{
	var keyCode : Int;
	var ctrlKey : Bool;
	var shiftKey : Bool;
	var altKey : Bool;
	
	function new(keyCode:Int, ctrlKey=false, shiftKey=false, altKey=false)
	{
		this.keyCode = keyCode;
		this.ctrlKey = ctrlKey;
		this.shiftKey = shiftKey;
		this.altKey = altKey;
	}
	
	public function test(e:{ keyCode:Int, ctrlKey:Bool, shiftKey:Bool, altKey:Bool }) : Bool
	{
		return e.keyCode == keyCode
			&& e.ctrlKey == ctrlKey
			&& e.shiftKey == shiftKey
			&& e.altKey == altKey;
	}
	
	public static function key(keyCode:Int) return new Shortcut(keyCode);
	public static function ctrl(keyCode:Int) return new Shortcut(keyCode, true);
	public static function shift(keyCode:Int) return new Shortcut(keyCode, false, true);
	public static function alt(keyCode:Int) return new Shortcut(keyCode, false, false, true);
	public static function ctrlShift(keyCode:Int) return new Shortcut(keyCode, true, true);
}