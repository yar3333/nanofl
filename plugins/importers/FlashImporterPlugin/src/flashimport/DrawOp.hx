package flashimport;

enum DrawOp
{
	move(x:Float, y:Float);
	line(x:Float, y:Float);
	curve(x1:Float, y1:Float, x2:Float, y2:Float);
}