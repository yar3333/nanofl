package nanofl.ide.keyboard;

class Keys
{
	public static var BACKSPACE(default, never) = 8;
	public static var TAB(default, never) = 9;
	public static var ENTER(default, never) = 13;
	public static var SHIFT(default, never) = 16;
	public static var CTRL(default, never) = 17;
	public static var ALT(default, never) = 18;
	public static var PAUSE(default, never) = 19;
	public static var CAPS_LOCK(default, never) = 20;
	public static var ESCAPE(default, never) = 27;
	public static var SPACEBAR(default, never) = 32;
	public static var PAGE_UP(default, never) = 33;
	public static var PAGE_DOWN(default, never) = 34;
	public static var END(default, never) = 35;
	public static var HOME(default, never) = 36;
	public static var LEFT_ARROW(default, never) = 37;
	public static var UP_ARROW(default, never) = 38;
	public static var RIGHT_ARROW(default, never) = 39;
	public static var DOWN_ARROW(default, never) = 40;
	public static var INSERT(default, never) = 45;
	public static var DELETE(default, never) = 46;
	public static var LEFT_WINDOW_KEY(default, never) = 91;
	public static var RIGHT_WINDOW_KEY(default, never) = 92;
	public static var SELECT_KEY(default, never) = 93;
	public static var NUMPAD_0(default, never) = 96;
	public static var NUMPAD_1(default, never) = 97;
	public static var NUMPAD_2(default, never) = 98;
	public static var NUMPAD_3(default, never) = 99;
	public static var NUMPAD_4(default, never) = 100;
	public static var NUMPAD_5(default, never) = 101;
	public static var NUMPAD_6(default, never) = 102;
	public static var NUMPAD_7(default, never) = 103;
	public static var NUMPAD_8(default, never) = 104;
	public static var NUMPAD_9(default, never) = 105;
	public static var MULTIPLY(default, never) = 106;
	public static var ADD(default, never) = 107;
	public static var SUBTRACT(default, never) = 109;
	public static var DECIMAL_POINT(default, never) = 110;
	public static var DIVIDE(default, never) = 111;
	public static var F1(default, never) = 112;
	public static var F2(default, never) = 113;
	public static var F3(default, never) = 114;
	public static var F4(default, never) = 115;
	public static var F5(default, never) = 116;
	public static var F6(default, never) = 117;
	public static var F7(default, never) = 118;
	public static var F8(default, never) = 119;
	public static var F9(default, never) = 120;
	public static var F10(default, never) = 121;
	public static var F11(default, never) = 122;
	public static var F12(default, never) = 123;
	public static var NUM_LOCK(default, never) = 144;
	public static var SCROLL_LOCK(default, never) = 145;
	public static var SEMICOLON(default, never) = 186;
	public static var EQUAL_SIGN(default, never) = 187;
	public static var COMMA(default, never) = 188;
	public static var DASH(default, never) = 189;
	public static var PERIOD(default, never) = 190;
	public static var FORWARD_SLASH(default, never) = 191;
	public static var GRAVE_ACCENT(default, never) = 192;
	public static var OPEN_BRACKET(default, never) = 219;
	public static var BACK_SLASH(default, never) = 220;
	public static var CLOSE_BRAKET(default, never) = 221;
	public static var SINGLE_QUOTE(default, never) = 222;
	
	public static var DIGIT_0(default, never) = 48;
	public static var DIGIT_1(default, never) = 49;
	public static var DIGIT_2(default, never) = 50;
	public static var DIGIT_3(default, never) = 51;
	public static var DIGIT_4(default, never) = 52;
	public static var DIGIT_5(default, never) = 53;
	public static var DIGIT_6(default, never) = 54;
	public static var DIGIT_7(default, never) = 55;
	public static var DIGIT_8(default, never) = 56;
	public static var DIGIT_9(default, never) = 57;
	
	public static var A(default, never) = 65;
	public static var B(default, never) = 66;
	public static var C(default, never) = 67;
	public static var D(default, never) = 68;
	public static var E(default, never) = 69;
	public static var F(default, never) = 70;
	public static var G(default, never) = 71;
	public static var H(default, never) = 72;
	public static var I(default, never) = 73;
	public static var J(default, never) = 74;
	public static var K(default, never) = 75;
	public static var L(default, never) = 76;
	public static var M(default, never) = 77;
	public static var N(default, never) = 78;
	public static var O(default, never) = 79;
	public static var P(default, never) = 80;
	public static var Q(default, never) = 81;
	public static var R(default, never) = 82;
	public static var S(default, never) = 83;
	public static var T(default, never) = 84;
	public static var U(default, never) = 85;
	public static var V(default, never) = 86;
	public static var W(default, never) = 87;
	public static var X(default, never) = 88;
	public static var Y(default, never) = 89;
	public static var Z(default, never) = 90;
	
	public static function toString(code:Int) : String
	{
		switch (code)
		{
			case Keys.BACKSPACE:		return "Backspace";
			case Keys.TAB:				return "Tab";
			case Keys.ENTER:			return "Enter";
			case Keys.SHIFT:			return "Shift";
			case Keys.CTRL:				return "Ctrl";
			case Keys.ALT:				return "Alt";
			case Keys.PAUSE:			return "Pause";
			case Keys.CAPS_LOCK:		return "Caps Lock";
			case Keys.ESCAPE:			return "Escape";
			case Keys.SPACEBAR:			return "Space";
			case Keys.PAGE_UP:			return "Page Up";
			case Keys.PAGE_DOWN:		return "Page Down";
			case Keys.END:				return "End";
			case Keys.HOME:				return "Home";
			case Keys.LEFT_ARROW:		return "Left";
			case Keys.UP_ARROW:			return "Up";
			case Keys.RIGHT_ARROW:		return "Right";
			case Keys.DOWN_ARROW:		return "Down";
			case Keys.INSERT:			return "Insert";
			case Keys.DELETE:			return "Delete";
			case Keys.LEFT_WINDOW_KEY:	return "Left Win";
			case Keys.RIGHT_WINDOW_KEY:	return "Right Win";
			case Keys.SELECT_KEY:		return "Select";
			case Keys.NUMPAD_0:			return "Num 0";
			case Keys.NUMPAD_1:			return "Num 1";
			case Keys.NUMPAD_2:			return "Num 2";
			case Keys.NUMPAD_3:			return "Num 3";
			case Keys.NUMPAD_4:			return "Num 4";
			case Keys.NUMPAD_5:			return "Num 5";
			case Keys.NUMPAD_6:			return "Num 6";
			case Keys.NUMPAD_7:			return "Num 7";
			case Keys.NUMPAD_8:			return "Num 8";
			case Keys.NUMPAD_9:			return "Num 9";
			case Keys.MULTIPLY:			return "Num '*'";
			case Keys.ADD:				return "Num '+'";
			case Keys.SUBTRACT:			return "Num '-'";
			case Keys.DECIMAL_POINT:	return "Num '.'";
			case Keys.DIVIDE:			return "Num '/'";
			
			case Keys.F1:				return "F1";
			case Keys.F2:				return "F2";
			case Keys.F3:				return "F3";
			case Keys.F4:				return "F4";
			case Keys.F5:				return "F5";
			case Keys.F6:				return "F6";
			case Keys.F7:				return "F7";
			case Keys.F8:				return "F8";
			case Keys.F9:				return "F9";
			case Keys.F10:				return "F10";
			case Keys.F11:				return "F11";
			case Keys.F12:				return "F12";
			
			case Keys.NUM_LOCK:			return "Num Lock";
			case Keys.SCROLL_LOCK:		return "Scroll Lock";
			case Keys.SEMICOLON:		return "';'";
			case Keys.EQUAL_SIGN:		return "'='";
			case Keys.COMMA:			return "','";
			case Keys.DASH:				return "-";
			case Keys.PERIOD:			return ".";
			case Keys.FORWARD_SLASH:	return "'/'";
			case Keys.GRAVE_ACCENT:		return "GRAVE_ACCENT";
			case Keys.OPEN_BRACKET:		return "'['";
			case Keys.BACK_SLASH:		return "'\\'";
			case Keys.CLOSE_BRAKET:		return "']'";
			case Keys.SINGLE_QUOTE:		return "\"'\"";
			
			case Keys.DIGIT_0:			return "0";
			case Keys.DIGIT_1:			return "1";
			case Keys.DIGIT_2:			return "2";
			case Keys.DIGIT_3:			return "3";
			case Keys.DIGIT_4:			return "4";
			case Keys.DIGIT_5:			return "5";
			case Keys.DIGIT_6:			return "6";
			case Keys.DIGIT_7:			return "7";
			case Keys.DIGIT_8:			return "8";
			case Keys.DIGIT_9:			return "9";
			
			case Keys.A:				return "A";
			case Keys.B:				return "B";
			case Keys.C:				return "C";
			case Keys.D:				return "D";
			case Keys.E:				return "E";
			case Keys.F:				return "F";
			case Keys.G:				return "G";
			case Keys.H:				return "H";
			case Keys.I:				return "I";
			case Keys.J:				return "J";
			case Keys.K:				return "K";
			case Keys.L:				return "L";
			case Keys.M:				return "M";
			case Keys.N:				return "N";
			case Keys.O:				return "O";
			case Keys.P:				return "P";
			case Keys.Q:				return "Q";
			case Keys.R:				return "R";
			case Keys.S:				return "S";
			case Keys.T:				return "T";
			case Keys.U:				return "U";
			case Keys.V:				return "V";
			case Keys.W:				return "W";
			case Keys.X:				return "X";
			case Keys.Y:				return "Y";
			case Keys.Z:				return "Z";		
		};
		
		return null;
	}
}