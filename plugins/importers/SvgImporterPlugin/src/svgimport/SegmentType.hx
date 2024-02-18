package svgimport;

import svgimport.segments.ArcSegment;
import svgimport.segments.CubicSegment;
import svgimport.segments.DrawSegment;
import svgimport.segments.MoveSegment;
import svgimport.segments.QuadraticSegment;

enum SegmentType 
{
	MOVE(seg:MoveSegment);
	DRAW(seg:DrawSegment);
	CURVE(seg:QuadraticSegment);
	CUBIC(seg:CubicSegment);
	ARC(seg:ArcSegment);
}