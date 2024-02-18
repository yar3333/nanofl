import nanofl.engine.geom.Contours;
import nanofl.engine.geom.Edge;
using Lambda;

@:access(nanofl.engine.geom.Contours)
class GeomContoursTest extends BaseTest
{
	function getRandomEdgesClosedSequence(count) : Array<Edge>
	{
		var r = [];
		
		var x = 0.0;
		var y = 0.0;
		for (i in 1...count)
		{
			var nx = Math.random() * 1000;
			var ny = Math.random() * 1000;
			r.push(new Edge(x, y, nx, ny));
			x = nx;
			y = ny;
		}
		r.push(new Edge(x, y, r[0].x1, r[0].y1));
		
		return r;
	}
	
	public function testSpeed() 
	{
		var edges = getRandomEdgesClosedSequence(1000);
		
		Profiler.begin("testSpeed/Contours.fromEdges");
		var contours = Contours.fromEdges(edges);
		Profiler.end();
		
		Profiler.traceResults();
		
		assertTrue(true);
	}
}
