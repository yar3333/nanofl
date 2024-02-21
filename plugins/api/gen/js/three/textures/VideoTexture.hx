package js.three.textures;

/**
 * Creates a texture for use with a video.
 * @remarks
 * Note: After the initial use of a texture, the video cannot be changed
 * Instead, call {@link dispose | .dispose()} on the texture and instantiate a new one.
 * @example
 * ```typescript
 * // assuming you have created a HTML video element with id="video"
 * const video = document.getElementById('video');
 * const texture = new THREE.VideoTexture(video);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video | materials / video}
 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video_webcam | materials / video / webcam}
 * @see Example: {@link https://threejs.org/examples/#webgl_video_kinect | video / kinect}
 * @see Example: {@link https://threejs.org/examples/#webgl_video_panorama_equirectangular | video / panorama / equirectangular}
 * @see Example: {@link https://threejs.org/examples/#webxr_vr_video | vr / video}
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/VideoTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/VideoTexture.js | Source}
 */
/**
	
	 * Creates a texture for use with a video.
	 * @remarks
	 * Note: After the initial use of a texture, the video cannot be changed
	 * Instead, call {@link dispose | .dispose()} on the texture and instantiate a new one.
	 * @example
	 * ```typescript
	 * // assuming you have created a HTML video element with id="video"
	 * const video = document.getElementById('video');
	 * const texture = new THREE.VideoTexture(video);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video | materials / video}
	 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video_webcam | materials / video / webcam}
	 * @see Example: {@link https://threejs.org/examples/#webgl_video_kinect | video / kinect}
	 * @see Example: {@link https://threejs.org/examples/#webgl_video_panorama_equirectangular | video / panorama / equirectangular}
	 * @see Example: {@link https://threejs.org/examples/#webxr_vr_video | vr / video}
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/VideoTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/VideoTexture.js | Source}
	 
**/
@:native("THREE.VideoTexture") extern class VideoTexture extends js.three.textures.Texture {
	/**
		
			 * Creates a texture for use with a video.
			 * @remarks
			 * Note: After the initial use of a texture, the video cannot be changed
			 * Instead, call {@link dispose | .dispose()} on the texture and instantiate a new one.
			 * @example
			 * ```typescript
			 * // assuming you have created a HTML video element with id="video"
			 * const video = document.getElementById('video');
			 * const texture = new THREE.VideoTexture(video);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video | materials / video}
			 * @see Example: {@link https://threejs.org/examples/#webgl_materials_video_webcam | materials / video / webcam}
			 * @see Example: {@link https://threejs.org/examples/#webgl_video_kinect | video / kinect}
			 * @see Example: {@link https://threejs.org/examples/#webgl_video_panorama_equirectangular | video / panorama / equirectangular}
			 * @see Example: {@link https://threejs.org/examples/#webxr_vr_video | vr / video}
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/VideoTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/VideoTexture.js | Source}
			 
	**/
	function new(video:js.html.VideoElement, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?format:js.three.PixelFormat, ?type:js.three.TextureDataType, ?anisotropy:Int):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link VideoTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isVideoTexture(default, null) : Bool;
	/**
		
			 * This is called automatically and sets {@link needsUpdate | .needsUpdate } to `true` every time a new frame is available.
			 
	**/
	function update():Void;
}