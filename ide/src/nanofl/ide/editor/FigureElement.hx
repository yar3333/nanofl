package nanofl.ide.editor;

import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;

enum FigureElement 
{
	STROKE_EDGE(edge:StrokeEdge);
	POLYGON(polygon:Polygon);
}