package js.three.math;

@:enum typedef EulerOrder = String;

@:native("THREE.Euler") extern class Euler {
	function new(?x:Float, ?y:Float, ?z:Float, ?order:js.three.math.Euler.EulerOrder):Void;
	/**
		
			 * @default 0
			 
	**/
	var x : Float;
	/**
		
			 * @default 0
			 
	**/
	var y : Float;
	/**
		
			 * @default 0
			 
	**/
	var z : Float;
	/**
		
			 * @default THREE.Euler.DEFAULT_ORDER
			 
	**/
	var order : js.three.math.Euler.EulerOrder;
	var isEuler(default, null) : Bool;
	var _onChangeCallback : () -> Void;
	var Euler : Dynamic;
	function set(x:Float, y:Float, z:Float, ?order:js.three.math.Euler.EulerOrder):js.three.math.Euler;
	function clone():js.three.math.Euler;
	function copy(euler:js.three.math.Euler):js.three.math.Euler;
	function setFromRotationMatrix(m:js.three.math.Matrix4, ?order:js.three.math.Euler.EulerOrder, ?update:Bool):js.three.math.Euler;
	function setFromQuaternion(q:js.three.math.Quaternion, ?order:js.three.math.Euler.EulerOrder, ?update:Bool):js.three.math.Euler;
	function setFromVector3(v:js.three.math.Vector3, ?order:js.three.math.Euler.EulerOrder):js.three.math.Euler;
	function reorder(newOrder:js.three.math.Euler.EulerOrder):js.three.math.Euler;
	function equals(euler:js.three.math.Euler):Bool;
	/**
		
		        [number, number, number, EulerOrder?,, any:Dynamic
		    
	**/
	function fromArray(xyzo:Array<Dynamic>):js.three.math.Euler;
	function toArray(?array:Array<haxe.extern.EitherType<Float, haxe.extern.EitherType<String, { }>>>, ?offset:Float):Array<haxe.extern.EitherType<Float, haxe.extern.EitherType<String, { }>>>;
	function _onChange(callback:() -> Void):js.three.math.Euler;
	static var DEFAULT_ORDER : String;
}