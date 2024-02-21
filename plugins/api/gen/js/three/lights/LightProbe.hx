package js.three.lights;

/**
 * Light probes are an alternative way of adding light to a 3D scene.
 * @remarks
 * Unlike classical light sources (e.g
 * directional, point or spot lights), light probes do not emit light
 * Instead they store information about light passing through 3D space
 * During rendering, the light that hits a 3D object is approximated by using the data from the light probe.
 * Light probes are usually created from (radiance) environment maps
 * The class {@link THREE.LightProbeGenerator | LightProbeGenerator} can be used to create light probes from
 * instances of {@link THREE.CubeTexture | CubeTexture} or {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}
 * However, light estimation data could also be provided in other forms e.g
 * by WebXR
 * This enables the rendering of augmented reality content that reacts to real world lighting.
 * The current probe implementation in three.js supports so-called diffuse light probes
 * This type of light probe is functionally equivalent to an irradiance environment map.
 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe | WebGL / light probe }
 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe_cubecamera | WebGL / light probe / cube camera }
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/LightProbe | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/LightProbe.js | Source}
 */
/**
	
	 * Light probes are an alternative way of adding light to a 3D scene.
	 * @remarks
	 * Unlike classical light sources (e.g
	 * directional, point or spot lights), light probes do not emit light
	 * Instead they store information about light passing through 3D space
	 * During rendering, the light that hits a 3D object is approximated by using the data from the light probe.
	 * Light probes are usually created from (radiance) environment maps
	 * The class {@link THREE.LightProbeGenerator | LightProbeGenerator} can be used to create light probes from
	 * instances of {@link THREE.CubeTexture | CubeTexture} or {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}
	 * However, light estimation data could also be provided in other forms e.g
	 * by WebXR
	 * This enables the rendering of augmented reality content that reacts to real world lighting.
	 * The current probe implementation in three.js supports so-called diffuse light probes
	 * This type of light probe is functionally equivalent to an irradiance environment map.
	 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe | WebGL / light probe }
	 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe_cubecamera | WebGL / light probe / cube camera }
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/LightProbe | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/LightProbe.js | Source}
	 
**/
@:native("THREE.LightProbe") extern class LightProbe extends js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>> {
	/**
		
			 * Light probes are an alternative way of adding light to a 3D scene.
			 * @remarks
			 * Unlike classical light sources (e.g
			 * directional, point or spot lights), light probes do not emit light
			 * Instead they store information about light passing through 3D space
			 * During rendering, the light that hits a 3D object is approximated by using the data from the light probe.
			 * Light probes are usually created from (radiance) environment maps
			 * The class {@link THREE.LightProbeGenerator | LightProbeGenerator} can be used to create light probes from
			 * instances of {@link THREE.CubeTexture | CubeTexture} or {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}
			 * However, light estimation data could also be provided in other forms e.g
			 * by WebXR
			 * This enables the rendering of augmented reality content that reacts to real world lighting.
			 * The current probe implementation in three.js supports so-called diffuse light probes
			 * This type of light probe is functionally equivalent to an irradiance environment map.
			 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe | WebGL / light probe }
			 * @see Example: {@link https://threejs.org/examples/#webgl_lightprobe_cubecamera | WebGL / light probe / cube camera }
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/LightProbe | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/LightProbe.js | Source}
			 
	**/
	function new(?sh:js.three.math.SphericalHarmonics3, ?intensity:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link DirectionalLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isLightProbe(default, null) : Bool;
	/**
		
			 * A light probe uses spherical harmonics to encode lighting information.
			 * @defaultValue `new THREE.SphericalHarmonics3()`
			 
	**/
	var sh : js.three.math.SphericalHarmonics3;
	/**
		
			 * @internal 
			 
	**/
	function fromJSON(json:{ }):js.three.lights.LightProbe;
}