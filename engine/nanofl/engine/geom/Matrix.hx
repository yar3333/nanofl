package nanofl.engine.geom;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class Matrix
{
	static final DEG_TO_RAD = Math.PI / 180;
	
	public var a : Float;
	public var b : Float;
	public var c : Float;
	public var d : Float;
	public var tx : Float;
	public var ty : Float;
	
	public function new(a=1.0, b=0.0, c=0.0, d=1.0, tx=0.0, ty=0.0)
	{
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
		this.tx = tx;
		this.ty = ty;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement) : Matrix
	{
		var coefs = node.getAttr("matrix", [0.0]);
		return coefs != null
			? new Matrix(coefs[0], coefs[1], coefs[2], coefs[3], node.getAttr("x", 0.0), node.getAttr("y", 0.0))
			: new Matrix(1.0, 0.0, 0.0, 1.0, node.getAttr("x", 0.0), node.getAttr("y", 0.0));
	}
    #end

	public static function loadJson(obj:Dynamic) : Matrix
	{
		return obj.matrix != null
			? new Matrix(obj.matrix[0], obj.matrix[1], obj.matrix[2], obj.matrix[3], obj.x ?? 0.0, obj.y ?? 0.0)
			: new Matrix(1.0, 0.0, 0.0, 1.0, obj.x ?? 0.0, obj.y ?? 0.0);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		if (tx != 0.0 || ty != 0.0)
		{
			out.attr("x", tx);
			out.attr("y", ty);
		}
		
		if (a != 1.0 || b != 0.0 || c != 0.0 || d != 1.0)
		{
			out.attr("matrix", [a, b, c, d].join(","));
		}
	}

	public function saveJson(obj:Dynamic) : Void
	{
		if (tx != 0.0 || ty != 0.0)
		{
			obj.x = tx;
			obj.y = ty;
		}
		
		if (a != 1.0 || b != 0.0 || c != 0.0 || d != 1.0)
		{
			obj.matrix = [a, b, c, d];
		}
	}
    #end

	public function decompose() : { x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float }
	{
		var r : Dynamic = {};
		
		r.x = tx;
		r.y = ty;
		r.scaleX = Math.sqrt(a * a + b * b);
		r.scaleY = Math.sqrt(c * c + d * d);
	
		var skewX = Math.atan2(-c, d);
		var skewY = Math.atan2(b, a);
		
		if (skewX == skewY)
		{
			r.rotation = skewY * 180 / Math.PI;
			if (a < 0 && d >= 0)
			{
				r.rotation += (r.rotation <= 0) ? 180 : -180;
			}
			r.skewX = r.skewY = 0;
		}
		else
		{
			r.rotation = 0;
			r.skewX = skewX * 180 / Math.PI;
			r.skewY = skewY * 180 / Math.PI;
		}
		
		return r;
	}
    // // https://stackoverflow.com/questions/5107134/find-the-rotation-and-skew-of-a-matrix-transformation
    // public function decompose() : { x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float }
	// {
    //     final angle = Math.atan2(b, a);
    //     final denom = Math.pow(a, 2) + Math.pow(b, 2);
    //     final scaleX = Math.sqrt(denom);
    //     final scaleY = (a * d - c * b) / scaleX;
    //     final skewX = Math.atan2(a * c + b * d, denom);
    //     return
    //     {
    //         rotation: angle / DEG_TO_RAD,  // this is rotation angle in degrees
    //         scaleX: scaleX,                // scaleX factor  
    //         scaleY: scaleY,                // scaleY factor
    //         skewX: skewX / DEG_TO_RAD,     // skewX angle degrees
    //         skewY: 0,                      // skewY angle degrees
    //         x: tx,                         // translation point x
    //         y: ty,                         // translation point y
    //     };
	// }
	
	public function setMatrix(m:{ a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float }) : Matrix
	{
		a = m.a;
		b = m.b;
		c = m.c;
		d = m.d;
		tx = m.tx;
		ty = m.ty;
		return this;
	}
	
	public function isIdentity() : Bool
	{
		return a == 1.0 && b == 0.0 && c == 0.0 && d == 1.0 && tx == 0.0 && ty == 0.0;
	}
	
	public function invert() : Matrix
	{
		var a1 = a;
		var b1 = b;
		var c1 = c;
		var d1 = d;
		var tx1 = tx;
		var n = a1 * d1 - b1 * c1;
		
		a =  d1 / n;
		b = -b1 / n;
		c = -c1 / n;
		d =  a1 / n;
		tx =  (c1 * ty - d1 * tx1) / n;
		ty = -(a1 * ty - b1 * tx1) / n;
		
		return this;
	}
	
	public function transformPoint(x:Float, y:Float) : Point
	{
		return { x:x * a + y * c + tx, y:x * b + y * d + ty };
	}
	
	public function transformPointP(pos:Point) : Point
	{
		return { x:pos.x * a + pos.y * c + tx, y:pos.x * b + pos.y * d + ty };
	}
	
	public function clone() : Matrix
	{
		return new Matrix(a, b, c, d, tx, ty);
	}
	
	public function translate(tx:Float, ty:Float) : Matrix
	{
		this.tx += tx;
		this.ty += ty;
		return this;
	}
	
	public function equ(m:Matrix) : Bool
	{
		return m.a == a && m.b == b && m.c == c && m.d == d && m.tx == tx && m.ty == ty;
	}
	
	public function setTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float) : Matrix
	{
		return setMatrix(new Matrix().appendTransform(x, y, scaleX, scaleY, rotation, skewX, skewY, regX, regY));
	}
    // // https://github.com/leeoniya/transformation-matrix-js/blob/master/src/matrix.js
	// public function setTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, regX=0.0, regY=0.0) : Matrix
	// {
    //     // a - scale x
    //     // b - skew y
    //     // c - skew x
    //     // d - scale y
    //     // e - translate x
    //     // f - translate y
    //     final r = new Matrix(scaleX, skewY, skewX, scaleY, x, y);
    //     if (rotation != 0) r.rotate(rotation);
	// 	if (regX != 0 || regY != 0)
	// 	{
	// 		r.tx -= regX * r.a + regY * r.c;
	// 		r.ty -= regX * r.b + regY * r.d;
	// 	}
    //     return setMatrix(r);
	// }
	
	public function appendMatrix(m:Matrix) : Matrix
	{
		return append(m.a, m.b, m.c, m.d, m.tx, m.ty);
	}
	
	public function prependMatrix(m:Matrix) : Matrix
	{
		return prepend(m.a, m.b, m.c, m.d, m.tx, m.ty);
	}
	
	public function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix
	{
		var a1 = this.a;
		var b1 = this.b;
		var c1 = this.c;
		var d1 = this.d;
		
		this.a  = a * a1 + b * c1;
		this.b  = a * b1 + b * d1;
		this.c  = c * a1 + d * c1;
		this.d  = c * b1 + d * d1;
		this.tx = tx * a1 + ty * c1 + this.tx;
		this.ty = tx * b1 + ty * d1 + this.ty;
		
		return this;
	}
	
	public function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix
	{
		var tx1 = this.tx;
		if (a != 1 || b != 0 || c != 0 || d != 1)
		{
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
	
	public function appendTransform(x:Float, y:Float, scaleX=1.0, scaleY=1.0, rotation=0.0, skewX=0.0, skewY=0.0, regX=0.0, regY=0.0) : Matrix
	{
		var sin : Float;
		var cos : Float;
		
		if (rotation % 360 != 0)
		{
			var r = rotation * DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		}
		else
		{
			cos = 1;
			sin = 0;
		}

		if (skewX != 0 || skewY != 0)
		{
			skewX *= DEG_TO_RAD;
			skewY *= DEG_TO_RAD;
			this.append(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), x, y);
			this.append(cos * scaleX, sin * scaleX, -sin * scaleY, cos * scaleY, 0, 0);
		}
		else
		{
			this.append(cos * scaleX, sin * scaleX, -sin * scaleY, cos * scaleY, x, y);
		}

		if (regX != 0 || regY != 0)
		{
			this.tx -= regX * this.a + regY * this.c;
			this.ty -= regX * this.b + regY * this.d;
		}
		return this;
	}
	
	public function prependTransform(x:Float, y:Float, scaleX=1.0, scaleY=1.0, rotation=0.0, skewX=0.0, skewY=0.0, regX=0.0, regY=0.0) : Matrix
	{
		var sin : Float;
		var cos : Float;
		
		if (rotation % 360 != 0)
		{
			var r = rotation * DEG_TO_RAD;
			cos = Math.cos(r);
			sin = Math.sin(r);
		}
		else
		{
			cos = 1;
			sin = 0;
		}
		
		this.tx -= regX;
		this.ty -= regY;
		
		if (skewX != 0 || skewY != 0)
		{
			skewX *= DEG_TO_RAD;
			skewY *= DEG_TO_RAD;
			this.prepend(cos * scaleX, sin * scaleX, -sin * scaleY, cos * scaleY, 0, 0);
			this.prepend(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), x, y);
		}
		else
		{
			this.prepend(cos * scaleX, sin * scaleX, -sin * scaleY, cos * scaleY, x, y);
		}
		return this;
	}
	
	public function rotate(angle:Float) : Matrix
	{
        // rotate: function(angle) {
        // 	var cos = Math.cos(angle),
        // 		sin = Math.sin(angle);
        // 	this.append(cos, sin, -sin, cos, 0, 0);

		var cos = Math.cos(angle);
		var sin = Math.sin(angle);

		var a1 = this.a;
		var c1 = this.c;
		var tx1 = this.tx;

		this.a = a1 * cos - this.b * sin;
		this.b = a1 * sin + this.b * cos;
		this.c = c1 * cos - this.d * sin;
		this.d = c1 * sin + this.d * cos;
		this.tx = tx1 * cos - this.ty * sin;
		this.ty = tx1 * sin + this.ty * cos;
		
		return this;
	}
	
	public function skew(skewX:Float, skewY:Float) : Matrix
	{
		skewX = skewX*DEG_TO_RAD;
		skewY = skewY*DEG_TO_RAD;
		append(Math.cos(skewY), Math.sin(skewY), -Math.sin(skewX), Math.cos(skewX), 0, 0);
		return this;
	}
	
	public function scale(kx:Float, ky:Float) : Matrix
	{
		a *= kx;
		d *= ky;
		c *= kx;
		b *= ky;
		tx *= kx;
		ty *= ky;
		return this;
	}
	
	/**
	 * Creates the specific style of matrix expected by the
	 * <code>beginGradientFill()</code> and <code>lineGradientStyle()</code>
	 * methods of the Graphics class. Width and height are scaled to a
	 * <code>scaleX</code>/<code>scaleY</code> pair and the
	 * <code>tx</code>/<code>ty</code> values are offset by half the width and
	 * height.
	 *
	 * <p>For example, consider a gradient with the following
	 * characteristics:</p>
	 *
	 * <ul>
	 *   <li><code>GradientType.LINEAR</code></li>
	 *   <li>Two colors, green and blue, with the ratios array set to <code>[0,255]</code></li>
	 *   <li><code>SpreadMethod.PAD</code></li>
	 *   <li><code>InterpolationMethod.LINEAR_RGB</code></li>
	 * </ul>
	 *
	 * <p>The following illustrations show gradients in which the matrix was
	 * defined using the <code>createGradientBox()</code> method with different
	 * parameter settings:</p>
	 * 
	 * @param width    The width of the gradient box.
	 * @param height   The height of the gradient box.
	 * @param rotation The amount to rotate, in radians.
	 * @param tx       The distance, in pixels, to translate to the right along
	 *                 the <i>x</i> axis. This value is offset by half of the
	 *                 <code>width</code> parameter.
	 * @param ty       The distance, in pixels, to translate down along the
	 *                 <i>y</i> axis. This value is offset by half of the
	 *                 <code>height</code> parameter.
	 */
	public function createGradientBox(width:Float, height:Float, rotation=0.0, tx=0.0, ty=0.0) : Matrix
	{
		a = width / 1638.4;
		d = height / 1638.4;
		
		// rotation is clockwise
		if (rotation != 0)
		{
			var cos = Math.cos(rotation);
			var sin = Math.sin(rotation);
			
			b = sin * d;
			c = -sin * a;
			a *= cos;
			d *= cos;
		}
		else
		{
			b = 0;
			c = 0;
		}
		
		this.tx = tx + width / 2;
		this.ty = ty + height / 2;
		
		return this;
	}
	
	public function getAverageScale() : Float
	{
		return (Math.sqrt(a*a + c*c) + Math.sqrt(b*b + d*d)) / 2;
	}
	
	public function toNative() : easeljs.geom.Matrix2D
	{
		return new easeljs.geom.Matrix2D(a, b, c, d, tx, ty);
	}
	
	public static function fromNative(m:easeljs.geom.Matrix2D) : Matrix
	{
		return new Matrix(m.a, m.b, m.c, m.d, m.tx, m.ty);
	}
	
	public function toArray() : Array<Float>
	{
		return [ a, b, c, d, tx, ty ];
	}
	
	public function toString() : String
	{
		return 'Matrix($a, $b, $c, $d, $tx, $ty)';
	}
}
