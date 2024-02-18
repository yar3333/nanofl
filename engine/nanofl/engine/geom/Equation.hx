package nanofl.engine.geom;

#if profiler @:build(Profiler.buildMarked()) #end
class Equation
{
	static inline var EPS = 1e-10;
	
	@:profile
	public static function solveCube(a:Float, b:Float, c:Float, d:Float) : Array<Float>
	{
		if (Math.abs(a) < EPS) return solveQuadratic(b, c, d);
		
		// https://en.wikipedia.org/wiki/Cubic_function#Cardano.27s_method
		
		// x3 + ax2 + bx + d = 0
		var z = a;
		a = b / z;
		b = c / z;
		c = d / z;
		
		var p = b - a * a / 3;
		var q = a * (2 * a * a - 9 * b) / 27 + c;
		var p3 = p * p * p;
		var D = q * q + 4 * p3 / 27;
		var offset = -a / 3;
		if (D > EPS)
		{
			z = Math.sqrt(D);
			var u = (-q + z) / 2;
			var v = (-q - z) / 2;
			u = u >= 0 ? Math.pow(u, 1 / 3) : -Math.pow(-u, 1 / 3);
			v = v >= 0 ? Math.pow(v, 1 / 3) : -Math.pow(-v, 1 / 3);
			return [ u + v + offset ];
		}
		else if (D < -EPS)
		{
			var u = 2 * Math.sqrt(-p / 3);
			var v = Math.acos(-Math.sqrt(-27 / p3) * q / 2) / 3;
			return
			[
				u * Math.cos(v) + offset, u * Math.cos(v + 2 * Math.PI / 3) + offset, 
				u * Math.cos(v + 4 * Math.PI / 3) + offset
			];
		}
		else
		{
			var u = q < 0 ? Math.pow(-q / 2, 1 / 3) : -Math.pow(q / 2, 1 / 3);
			return [ 2*u + offset, -u + offset ];
		}
	}
	
	@:profile
	public static function solveQuadratic(a:Float, b:Float, c:Float) : Array<Float>
	{
		if (Math.abs(a) <= EPS) return Math.abs(b) > EPS ? [ -c / b ] : [];
		
		var D = b * b - 4 * a * c;
		if (D > EPS)
		{
			D = Math.sqrt(D);
			return
			[
				(-b - D) / (2 * a),
				(-b + D) / (2 * a)
			];
		}
		
		if (D > -EPS) return [ -b / (2 * a) ];
		
		return [];
	}
}
