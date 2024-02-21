package js.three.math;

@:native("THREE.SphericalHarmonics3") extern class SphericalHarmonics3 {
	function new():Void;
	/**
		
			 * @default [new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(),
			 * new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()]
			 
	**/
	var coefficients : Array<js.three.math.Vector3>;
	var isSphericalHarmonics3(default, null) : Bool;
	function set(coefficients:Array<js.three.math.Vector3>):js.three.math.SphericalHarmonics3;
	function zero():js.three.math.SphericalHarmonics3;
	function add(sh:js.three.math.SphericalHarmonics3):js.three.math.SphericalHarmonics3;
	function addScaledSH(sh:js.three.math.SphericalHarmonics3, s:Float):js.three.math.SphericalHarmonics3;
	function scale(s:Float):js.three.math.SphericalHarmonics3;
	function lerp(sh:js.three.math.SphericalHarmonics3, alpha:Float):js.three.math.SphericalHarmonics3;
	function equals(sh:js.three.math.SphericalHarmonics3):Bool;
	function copy(sh:js.three.math.SphericalHarmonics3):js.three.math.SphericalHarmonics3;
	function clone():js.three.math.SphericalHarmonics3;
	/**
		
			 * Sets the values of this spherical harmonics from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.SphericalHarmonics3;
	/**
		
			 * Returns an array with the values of this spherical harmonics, or copies them into the provided array.
			 * @return The created or provided array.
			 * Returns an array with the values of this spherical harmonics, or copies them into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function getAt(normal:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function getIrradianceAt(normal:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	static function getBasisAt(normal:js.three.math.Vector3, shBasis:Array<Float>):Void;
}