package nanofl.engine;

typedef TextLine =
{
	var chunks : Array<TextChunk>;
	var width : Float;
	var minY : Float;
	var maxY : Float;
	var align : String;
	var spacing : Float;
}