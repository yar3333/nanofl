package nanofl.ide.sys.node;

import nanofl.ide.sys.Fonts;

class NodeFonts implements Fonts
{
	public function new() {}
	
	public function getFontNames() : Array<String>
	{
		return [ "Arial", "Courier", "Tahoma", "Verdana" ];
	}
}