package nanofl.engine;

import easeljs.geom.Rectangle;
import easeljs.display.Text;

typedef TextChunk =
{
	var text : Text;
	var textSecond : Text;
	var charIndex : Int;
	var bounds : Rectangle;
	var backgroundColor : String;
	var format : TextRun;
}