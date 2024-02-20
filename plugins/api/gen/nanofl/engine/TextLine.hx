package nanofl.engine;

typedef TextLine = {
	var align : String;
	var chunks : Array<nanofl.engine.TextChunk>;
	var maxY : Float;
	var minY : Float;
	var spacing : Float;
	var width : Float;
};