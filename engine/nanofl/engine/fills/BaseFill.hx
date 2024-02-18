package nanofl.engine.fills;

import js.lib.Error;
import htmlparser.HtmlNodeElement;
using htmlparser.HtmlParserTools;

abstract class BaseFill
{
	public abstract function setLibrary(library:Library) : Void;

    public static function load(node:HtmlNodeElement, version:String) : IFill
    {
        return switch (node.getAttr("type", "solid"))
        {
            case "solid":   SolidFill.load(node, version);
            case "linear": LinearFill.load(node, version);
            case "radial": RadialFill.load(node, version);
            case "bitmap": BitmapFill.load(node, version);
            case _: throw new Error("Unknow fill type '" + node.getAttr("type") + "'.");
        }
    }
}