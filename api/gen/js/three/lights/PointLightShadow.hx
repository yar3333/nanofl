package js.three.lights;

/**
 * Shadow for {@link THREE.PointLight | PointLight}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/PointLightShadow.js | Source}
 */
/**
	
	 * Shadow for {@link THREE.PointLight | PointLight}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/PointLightShadow.js | Source}
	 
**/
@:native("THREE.PointLightShadow") extern class PointLightShadow extends js.three.lights.LightShadow<js.three.cameras.PerspectiveCamera> {
	/**
		
			 * Read-only flag to check if a given object is of type {@link PointLightShadow}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isPointLightShadow(default, null) : Dynamic;
	/**
		
		     * Update the matrices for the camera and shadow, used internally by the renderer.
		     * @param light The light for which the shadow is being rendered.
		     
	**/
	override function updateMatrices(light:js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>, ?viewportIndex:Int):Void;
}