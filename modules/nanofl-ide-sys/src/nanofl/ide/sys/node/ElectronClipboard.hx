package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;
using StringTools;
using Lambda;

class ElectronClipboard implements nanofl.ide.sys.Clipboard
{
	public function new() {}

    public function hasText() : Bool
    {
        final formats : Array<String> = ElectronApi.callMethod("clipboard", "availableFormats");
        return formats.exists(x -> x.startsWith("text/"));
    }

    public function hasImage() : Bool
    {
        final formats : Array<String> = ElectronApi.callMethod("clipboard", "availableFormats");
        return formats.exists(x -> x.startsWith("image/"));
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
        
    public function writeText(data:String) : Void
    {
        ElectronApi.callMethod("clipboard", "writeText", data);
    }
}
