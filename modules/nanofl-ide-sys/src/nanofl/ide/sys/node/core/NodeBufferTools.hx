package nanofl.ide.sys.node.core;

class NodeBufferTools
{
	public static function toBytes(b:NodeBuffer) : haxe.io.Bytes untyped
    {
		var o = Object.create(haxe.io.Bytes.prototype);
		// the following is basically a haxe.io.Bytes constructor,
		// but using given buffer instead of creating new Uint8Array
		o.length = b.byteLength;
		o.b = b;
		b.bufferValue = b;
		b.hxBytes = o;
		b.bytes = b;
		return o;
	}

	public static function toBuffer(b:haxe.io.Bytes) : NodeBuffer
    {
		var data = @:privateAccess b.b;
		return ElectronApi.createBuffer(data.buffer, data.byteOffset, b.length);
	}
}
