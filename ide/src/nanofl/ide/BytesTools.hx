package nanofl.ide;

import haxe.io.Bytes;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;
using StringTools;

class BytesTools
{
	public static function fromString(s:String) : Bytes
	{
		return Bytes.ofData(stringToArrayBuffer(s));
	}
	
	static function stringToArrayBuffer(str:String) : ArrayBuffer
	{
		var buf = new ArrayBuffer(str.length);
		var view = new Uint8Array(buf);
		for (i in 0...str.length)
		{
			view[i] = str.fastCodeAt(i);
		}
		return buf;
	}
	
	public static function toArray(data:haxe.io.Bytes) : Array<Int>
	{
		return untyped Array.prototype.slice.call(data.b);
	}
}