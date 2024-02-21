package js.three.objects;

/**
 * A class for displaying {@link Points}
 * @remarks
 * The {@link Points} are rendered by the {@link THREE.WebGLRenderer | WebGLRenderer} using {@link https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/drawElements | gl.POINTS}.
 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Points | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Points.js | Source}
 */
/**
	
	 * A class for displaying {@link Points}
	 * @remarks
	 * The {@link Points} are rendered by the {@link THREE.WebGLRenderer | WebGLRenderer} using {@link https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext/drawElements | gl.POINTS}.
	 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Points | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Points.js | Source}
	 
**/
@:native("THREE.Points") extern class Points<TGeometry:(js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalOrGLBufferAttributes>), TMaterial:(haxe.extern.EitherType<js.three.materials.Material, Array<js.three.materials.Material>>)> {

}