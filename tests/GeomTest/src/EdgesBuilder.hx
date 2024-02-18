import nanofl.engine.geom.Edge;

class EdgesBuilder
{
	var x = 0.0;
	var y = 0.0;
	
	public var edges = new Array<Edge>();
	
	public function new() { }
	
	public function moveTo(x, y)
	{
		this.x = x;
		this.y = y;
	}
	
	public function lineTo(x, y)
	{
		edges.push(new Edge(this.x, this.y, x, y));
		this.x = x;
		this.y = y;
	}
	
	public function curveTo(x1, y1, x2, y2)
	{
		edges.push(new Edge(this.x, this.y, x1, y1, x2, y2));
		this.x = x2;
		this.y = y2;
	}
	
	public function quadraticCurveTo(x1, y1, x2, y2) curveTo(x1, y1, x2, y2);
}