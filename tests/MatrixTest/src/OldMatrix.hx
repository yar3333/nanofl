/**
 * Matrix from easeljs 0.7.0
 */
class OldMatrix
{
	static var DEG_TO_RAD = Math.PI / 180;
	
	public var a : Float = 1.0;
	public var b : Float = 0.0;
	public var c : Float = 0.0;
	public var d : Float = 1.0;
	public var tx : Float = 0.0;
	public var ty : Float = 0.0;
	
	public function appendMatrix(m:OldMatrix)
	{
		return append(m.a, m.b, m.c, m.d, m.tx, m.ty);
	}
	
	public function prependMatrix(m:OldMatrix)
	{
		return prepend(m.a, m.b, m.c, m.d, m.tx, m.ty);
	}
	
	public function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float)
	{
		var a1 = this.a;
		var b1 = this.b;
		var c1 = this.c;
		var d1 = this.d;

		this.a  = a*a1+b*c1;
		this.b  = a*b1+b*d1;
		this.c  = c*a1+d*c1;
		this.d  = c*b1+d*d1;
		this.tx = tx*a1+ty*c1+this.tx;
		this.ty = tx*b1+ty*d1+this.ty;
		return this;
	}

	public function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float)
	{
		var tx1 = this.tx;
		if (a != 1 || b != 0 || c != 0 || d != 1) {
			var a1 = this.a;
			var c1 = this.c;
			this.a  = a1*a+this.b*c;
			this.b  = a1*b+this.b*d;
			this.c  = c1*a+this.d*c;
			this.d  = c1*b+this.d*d;
		}
		this.tx = tx1*a+this.ty*c+tx;
		this.ty = tx1*b+this.ty*d+ty;
		return this;
	}

	public function appendTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, regX:Float, regY:Float)
	{
		var sin:Float;
		var cos:Float;
		
		if (rotation%360!=0) {
			var r = rotation*DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		} else {
			cos = 1;
			sin = 0;
		}

		if (skewX!=0 || skewY!=0) {
			// TODO: can this be combined into a single append?
			skewX *= DEG_TO_RAD;
			skewY *= DEG_TO_RAD;
			this.append(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), x, y);
			this.append(cos*scaleX, sin*scaleX, -sin*scaleY, cos*scaleY, 0, 0);
		} else {
			this.append(cos*scaleX, sin*scaleX, -sin*scaleY, cos*scaleY, x, y);
		}

		if (regX!=0 || regY!=0) {
			// prepend the registration offset:
			this.tx -= regX*this.a+regY*this.c;
			this.ty -= regX*this.b+regY*this.d;
		}
		return this;
	}

	public function prependTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, regX:Float, regY:Float)
	{
		var sin:Float;
		var cos:Float;
		
		if (rotation%360!=0) {
			var r = rotation*DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		} else {
			cos = 1;
			sin = 0;
		}

		if (regX!=0 || regY!=0) {
			// append the registration offset:
			this.tx -= regX; this.ty -= regY;
		}
		if (skewX!=0 || skewY!=0) {
			// TODO: can this be combined into a single prepend operation?
			skewX *= DEG_TO_RAD;
			skewY *= DEG_TO_RAD;
			this.prepend(cos*scaleX, sin*scaleX, -sin*scaleY, cos*scaleY, 0, 0);
			this.prepend(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), x, y);
		} else {
			this.prepend(cos*scaleX, sin*scaleX, -sin*scaleY, cos*scaleY, x, y);
		}
		return this;
	}

	public function rotate(angle:Float)
	{
		angle = angle * DEG_TO_RAD;
		
		var cos = Math.cos(angle);
		var sin = Math.sin(angle);

		var a1 = this.a;
		var c1 = this.c;
		var tx1 = this.tx;

		this.a = a1*cos-this.b*sin;
		this.b = a1*sin+this.b*cos;
		this.c = c1*cos-this.d*sin;
		this.d = c1*sin+this.d*cos;
		this.tx = tx1*cos-this.ty*sin;
		this.ty = tx1*sin+this.ty*cos;
		return this;
	}

	public function skew(skewX:Float, skewY:Float)
	{
		skewX = skewX*DEG_TO_RAD;
		skewY = skewY*DEG_TO_RAD;
		this.append(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), 0, 0);
		return this;
	}

	public function scale(x, y)
	{
		this.a *= x;
		this.d *= y;
		this.c *= x;
		this.b *= y;
		this.tx *= x;
		this.ty *= y;
		return this;
	}

	public function translate(x, y)
	{
		this.tx += x;
		this.ty += y;
		return this;
	}

	public function invert()
	{
		var a1 = this.a;
		var b1 = this.b;
		var c1 = this.c;
		var d1 = this.d;
		var tx1 = this.tx;
		var n = a1*d1-b1*c1;

		this.a = d1/n;
		this.b = -b1/n;
		this.c = -c1/n;
		this.d = a1/n;
		this.tx = (c1*this.ty-d1*tx1)/n;
		this.ty = -(a1*this.ty-b1*tx1)/n;
		return this;
	}

	public function transformPoint(x, y, pt)
	{
		return
		{
			x : x*this.a+y*this.c+this.tx,
			y : x*this.b+y*this.d+this.ty
		};
	}

	public function decompose(target:Dynamic) : Dynamic
	{
		// TODO: it would be nice to be able to solve for whether the matrix can be decomposed into only scale/rotation even when scale is negative
		if (target == null) { target = {}; }
		target.x = this.tx;
		target.y = this.ty;
		target.scaleX = Math.sqrt(this.a * this.a + this.b * this.b);
		target.scaleY = Math.sqrt(this.c * this.c + this.d * this.d);

		var skewX = Math.atan2(-this.c, this.d);
		var skewY = Math.atan2(this.b, this.a);

		if (skewX == skewY) {
			target.rotation = skewY/DEG_TO_RAD;
			if (this.a < 0 && this.d >= 0) {
				target.rotation += (target.rotation <= 0) ? 180 : -180;
			}
			target.skewX = target.skewY = 0;
		} else {
			target.skewX = skewX/DEG_TO_RAD;
			target.skewY = skewY/DEG_TO_RAD;
		}
		return target;
	}
}