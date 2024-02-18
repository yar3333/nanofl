import haxe.PosInfos;
import neko.Lib;
import stdlib.Debug;

class Main
{
	static function main()
	{
		var m1 = new OldMatrix().translate(100, 50).prependMatrix(processOld());
		var m2 = new NewMatrix().translate(100, 50).prependMatrix(processNew1());
		assert(m1, m2, "(1)");
		
		m2 = new NewMatrix().translate(100, 50).prependMatrix(processNew2());
		assert(m1, m2, "(2)");
	}
	
	static function processOld()
	{
		var m = new OldMatrix();
		m.translate(-50, -100);
		m.rotate(30);
		m.translate(50, 100);
		return m;
	}
	
	static function processNew1()
	{
		var m = new NewMatrix();
		m.translate(-50, -100);
		m.rotate(30);
		m.translate(50, 100);
		return m;
	}
	
	static function processNew2()
	{
		var m = new NewMatrix();
		m.translate(50, 100);
		m.rotate(30);
		m.translate(-50, -100);
		return m;
	}
	
	static function assert(m1:Dynamic, m2:Dynamic, t:String)
	{
		if (equ(m1, m2)) Lib.println(t + " OK");
		else             Lib.println(t + " FAIL");
	}
	
	static function equ(m1:Dynamic, m2:Dynamic) : Bool
	{
		return m1.a == m2.a && m1.b == m2.b && m1.c == m2.c && m1.d == m2.d && m1.tx == m2.tx && m1.ty == m2.ty;
	}
}
