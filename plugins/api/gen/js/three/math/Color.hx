package js.three.math;

/**
 * Represents a color. See also {@link ColorUtils}.
 *
 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Color.js|src/math/Color.js}
 *
 * @example
 * const color = new THREE.Color( 0xff0000 );
 */
/**
	
	 * Represents a color. See also {@link ColorUtils}.
	 * 
	 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Color.js|src/math/Color.js}
	 * 
	 * @example
	 * const color = new THREE.Color( 0xff0000 );
	 
**/
@:native("THREE.Color") extern class Color {
	/**
		
			 * Represents a color. See also {@link ColorUtils}.
			 * 
			 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Color.js|src/math/Color.js}
			 * 
			 * @example
			 * const color = new THREE.Color( 0xff0000 );
			 
	**/
	@:overload(function(?color:js.three.math.ColorRepresentation):Void { })
	function new(r:Float, g:Float, b:Float):Void;
	var isColor(default, null) : Bool;
	/**
		
			 * Red channel value between 0 and 1. Default is 1.
			 * @default 1
			 
	**/
	var r : Float;
	/**
		
			 * Green channel value between 0 and 1. Default is 1.
			 * @default 1
			 
	**/
	var g : Float;
	/**
		
			 * Blue channel value between 0 and 1. Default is 1.
			 * @default 1
			 
	**/
	var b : Float;
	@:overload(function(rgb:Array<Float>):js.three.math.Color { })
	function set(color:js.three.math.ColorRepresentation):js.three.math.Color;
	/**
		
			 * Sets this color's {@link r}, {@link g} and {@link b} components from the x, y, and z components of the specified
			 * {@link Vector3 | vector}.
			 
	**/
	function setFromVector3(vector:js.three.math.Vector3):js.three.math.Color;
	function setScalar(scalar:Float):js.three.math.Color;
	function setHex(hex:Int, ?colorSpace:js.three.ColorSpace):js.three.math.Color;
	/**
		
			 * Sets this color from RGB values.
			 
	**/
	function setRGB(r:Float, g:Float, b:Float, ?colorSpace:js.three.ColorSpace):js.three.math.Color;
	/**
		
			 * Sets this color from HSL values.
			 * Based on MochiKit implementation by Bob Ippolito.
			 
	**/
	function setHSL(h:Float, s:Float, l:Float, ?colorSpace:js.three.ColorSpace):js.three.math.Color;
	/**
		
			 * Sets this color from a CSS context style string.
			 
	**/
	function setStyle(style:String, ?colorSpace:js.three.ColorSpace):js.three.math.Color;
	/**
		
			 * Sets this color from a color name.
			 * Faster than {@link Color#setStyle .setStyle()} method if you don't need the other CSS-style formats.
			 
	**/
	function setColorName(style:String, ?colorSpace:js.three.ColorSpace):js.three.math.Color;
	/**
		
			 * Clones this color.
			 
	**/
	function clone():js.three.math.Color;
	/**
		
			 * Copies given color.
			 
	**/
	function copy(color:js.three.math.Color):js.three.math.Color;
	/**
		
			 * Copies given color making conversion from sRGB to linear space.
			 
	**/
	function copySRGBToLinear(color:js.three.math.Color):js.three.math.Color;
	/**
		
			 * Copies given color making conversion from linear to sRGB space.
			 
	**/
	function copyLinearToSRGB(color:js.three.math.Color):js.three.math.Color;
	/**
		
			 * Converts this color from sRGB to linear space.
			 
	**/
	function convertSRGBToLinear():js.three.math.Color;
	/**
		
			 * Converts this color from linear to sRGB space.
			 
	**/
	function convertLinearToSRGB():js.three.math.Color;
	/**
		
			 * Returns the hexadecimal value of this color.
			 
	**/
	function getHex(?colorSpace:js.three.ColorSpace):Int;
	/**
		
			 * Returns the string formated hexadecimal value of this color.
			 
	**/
	function getHexString(?colorSpace:js.three.ColorSpace):String;
	function getHSL(target:js.three.math.Color.HSL, ?colorSpace:js.three.ColorSpace):js.three.math.Color.HSL;
	function getRGB(target:js.three.math.Color.RGB, ?colorSpace:js.three.ColorSpace):js.three.math.Color.RGB;
	/**
		
			 * Returns the value of this color in CSS context style.
			 * Example: rgb(r, g, b)
			 
	**/
	function getStyle(?colorSpace:js.three.ColorSpace):String;
	function offsetHSL(h:Float, s:Float, l:Float):js.three.math.Color;
	function add(color:js.three.math.Color):js.three.math.Color;
	function addColors(color1:js.three.math.Color, color2:js.three.math.Color):js.three.math.Color;
	function addScalar(s:Float):js.three.math.Color;
	/**
		
			 * Applies the transform {@link Matrix3 | m} to this color's RGB components.
			 
	**/
	function applyMatrix3(m:js.three.math.Matrix3):js.three.math.Color;
	function sub(color:js.three.math.Color):js.three.math.Color;
	function multiply(color:js.three.math.Color):js.three.math.Color;
	function multiplyScalar(s:Float):js.three.math.Color;
	function lerp(color:js.three.math.Color, alpha:Float):js.three.math.Color;
	function lerpColors(color1:js.three.math.Color, color2:js.three.math.Color, alpha:Float):js.three.math.Color;
	function lerpHSL(color:js.three.math.Color, alpha:Float):js.three.math.Color;
	function equals(color:js.three.math.Color):Bool;
	/**
		
			 * Sets this color's red, green and blue value from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Color;
	/**
		
			 * Returns an array [red, green, blue], or copies red, green and blue into the provided array.
			 * @return The created or provided array.
			 * Copies red, green and blue into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(xyz:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		
			 * This method defines the serialization result of Color.
			 * @return The color as a hexadecimal value.
			 
	**/
	function toJSON():Float;
	function fromBufferAttribute(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, js.three.core.InterleavedBufferAttribute>, index:Int):js.three.math.Color;
	/**
		
			 * List of X11 color names.
			 
	**/
	static var NAMES : js.three.math.ColorKeywords;
}

typedef HSL = {
	var h : Float;
	var l : Float;
	var s : Float;
};

typedef RGB = {
	var b : Float;
	var g : Float;
	var r : Float;
};