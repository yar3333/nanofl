package js.three.lights;

/**
 * Abstract base class for lights.
 * @remarks All other light types inherit the properties and methods described here.
 */
/**
	
	 * Abstract base class for lights.
	 * @remarks All other light types inherit the properties and methods described here.
	 
**/
@:native("THREE.Light") extern class Light<TShadowSupport:(haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>)> extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
		     * Creates a new {@link Light}
		     * @remarks
		     * **Note** that this is not intended to be called directly (use one of derived classes instead).
		     * @param color Hexadecimal color of the light. Default `0xffffff` _(white)_.
		     * @param intensity Numeric value of the light's strength/intensity. Expects a `Float`. Default `1`.
		     
	**/
	function new(?color:js.three.math.ColorRepresentation, ?intensity:Float):Void;
	/**
		
		      * Read-only flag to check if a given object is of type {@link HemisphereLight}.
		      * @remarks This is a _constant_ value
		      * @defaultValue `true`
		      
	**/
	var isLight(default, null) : Bool;
	/**
		
		      * Color of the light. \
		      * @defaultValue `new THREE.Color(0xffffff)` _(white)_.
		      
	**/
	var color : js.three.math.Color;
	/**
		
		      * The light's intensity, or strength.
		      * The units of intensity depend on the type of light.
		      * @defaultValue `1`
		      
	**/
	var intensity : Float;
	/**
		
		      * A {@link THREE.LightShadow | LightShadow} used to calculate shadows for this light.
		      * @remarks Available only on Light's that support shadows.
		      
	**/
	var shadow : TShadowSupport;
	/**
		
		      * Copies value of all the properties from the {@link Light | source} to this instance.
		      * @param source
		      * @param recursive
		      
	**/
	override function copy(source:js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>, ?recursive:Bool):js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>;
	/**
		
		      * Frees the GPU-related resources allocated by this instance
		      * @remarks
		      * Call this method whenever this instance is no longer used in your app.
		      
	**/
	function dispose():Void;
}