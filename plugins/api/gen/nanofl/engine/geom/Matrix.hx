package nanofl.engine.geom;

extern class Matrix {
	function new(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float):Void;
	var a : Float;
	var b : Float;
	var c : Float;
	var d : Float;
	var tx : Float;
	var ty : Float;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson(obj:Dynamic):Void;
	function decompose(?flipX:Bool, ?flipY:Bool):{ var rotation : Float; var scaleX : Float; var scaleY : Float; var skewX : Float; var skewY : Float; var x : Float; var y : Float; };
	function setMatrix(m:{ var a : Float; var b : Float; var c : Float; var d : Float; var tx : Float; var ty : Float; }):nanofl.engine.geom.Matrix;
	function isIdentity():Bool;
	function invert():nanofl.engine.geom.Matrix;
	function transformPoint(x:Float, y:Float):nanofl.engine.geom.Point;
	function transformPointP(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	function clone():nanofl.engine.geom.Matrix;
	function translate(tx:Float, ty:Float):nanofl.engine.geom.Matrix;
	function equ(m:nanofl.engine.geom.Matrix):Bool;
	function setTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float):nanofl.engine.geom.Matrix;
	function appendMatrix(m:nanofl.engine.geom.Matrix):nanofl.engine.geom.Matrix;
	function prependMatrix(m:nanofl.engine.geom.Matrix):nanofl.engine.geom.Matrix;
	function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):nanofl.engine.geom.Matrix;
	function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):nanofl.engine.geom.Matrix;
	function appendTransform(x:Float, y:Float, ?scaleX:Float, ?scaleY:Float, ?rotation:Float, ?skewX:Float, ?skewY:Float, ?regX:Float, ?regY:Float):nanofl.engine.geom.Matrix;
	function prependTransform(x:Float, y:Float, ?scaleX:Float, ?scaleY:Float, ?rotation:Float, ?skewX:Float, ?skewY:Float, ?regX:Float, ?regY:Float):nanofl.engine.geom.Matrix;
	function rotate(angle:Float):nanofl.engine.geom.Matrix;
	function skew(skewX:Float, skewY:Float):nanofl.engine.geom.Matrix;
	function scale(kx:Float, ky:Float):nanofl.engine.geom.Matrix;
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
			 
	**/
	function createGradientBox(width:Float, height:Float, ?rotation:Float, ?tx:Float, ?ty:Float):nanofl.engine.geom.Matrix;
	function getAverageScale():Float;
	function toNative():easeljs.geom.Matrix2D;
	function toArray():Array<Float>;
	function toString():String;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.geom.Matrix;
	static function loadJson(obj:Dynamic):nanofl.engine.geom.Matrix;
	static function fromNative(m:easeljs.geom.Matrix2D):nanofl.engine.geom.Matrix;
}