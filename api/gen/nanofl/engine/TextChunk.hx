package nanofl.engine;

typedef TextChunk = {
	var backgroundColor : String;
	var bounds : easeljs.geom.Rectangle;
	var charIndex : Int;
	var format : nanofl.TextRun;
	var text : easeljs.display.Text;
	var textSecond : easeljs.display.Text;
};