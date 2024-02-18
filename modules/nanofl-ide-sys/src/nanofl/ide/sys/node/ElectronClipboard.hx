package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;

class ElectronClipboard implements nanofl.ide.sys.Clipboard
{
	public function new() {}
    
    public function writeText(data:String) : Void
    {
        ElectronApi.callMethod("clipboard", "writeText", data);
    }

    public function has(format:String) : Bool
    {
        return ElectronApi.callMethod("clipboard", "has", format);
    }
    
    public function readText() : String
    {
        return ElectronApi.callMethod("clipboard", "readText");
    }

    public function readImageAsPngBytes() : haxe.io.Bytes
    {
        var r : electron.NativeImage = ElectronApi.callMethod("clipboard", "readImage");
        return r != null ? r.toPNG().hxToBytes() : null;
    }
}
