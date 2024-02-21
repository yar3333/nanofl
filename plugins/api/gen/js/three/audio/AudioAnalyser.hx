package js.three.audio;

/**
 * Create a {@link AudioAnalyser} object, which uses an {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode | AnalyserNode} to analyse audio data.
 * This uses the {@link https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API | Web Audio API}.
 * @example
 * ```typescript
 * // create an AudioListener and add it to the camera
 * const listener = new THREE.AudioListener();
 * camera.add(listener);
 * // create an Audio source
 * const sound = new THREE.Audio(listener);
 * // load a sound and set it as the Audio object's buffer
 * const audioLoader = new THREE.AudioLoader();
 * audioLoader.load('sounds/ambient.ogg', function (buffer) {
 *     sound.setBuffer(buffer);
 *     sound.setLoop(true);
 *     sound.setVolume(0.5);
 *     sound.play();
 * });
 * // create an AudioAnalyser, passing in the sound and desired fftSize
 * const analyser = new THREE.AudioAnalyser(sound, 32);
 * // get the average frequency of the sound
 * const data = analyser.getAverageFrequency();
 * ```
 * @see Example: {@link https://threejs.org/examples/#webaudio_sandbox | webaudio / sandbox }
 * @see Example: {@link https://threejs.org/examples/#webaudio_visualizer | webaudio / visualizer }
 * @see {@link https://threejs.org/docs/index.html#api/en/audio/AudioAnalyser | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/audio/AudioAnalyser.js | Source}
 */
/**
	
	 * Create a {@link AudioAnalyser} object, which uses an {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode | AnalyserNode} to analyse audio data.
	 * This uses the {@link https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API | Web Audio API}.
	 * @example
	 * ```typescript
	 * // create an AudioListener and add it to the camera
	 * const listener = new THREE.AudioListener();
	 * camera.add(listener);
	 * // create an Audio source
	 * const sound = new THREE.Audio(listener);
	 * // load a sound and set it as the Audio object's buffer
	 * const audioLoader = new THREE.AudioLoader();
	 * audioLoader.load('sounds/ambient.ogg', function (buffer) {
	 *     sound.setBuffer(buffer);
	 *     sound.setLoop(true);
	 *     sound.setVolume(0.5);
	 *     sound.play();
	 * });
	 * // create an AudioAnalyser, passing in the sound and desired fftSize
	 * const analyser = new THREE.AudioAnalyser(sound, 32);
	 * // get the average frequency of the sound
	 * const data = analyser.getAverageFrequency();
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webaudio_sandbox | webaudio / sandbox }
	 * @see Example: {@link https://threejs.org/examples/#webaudio_visualizer | webaudio / visualizer }
	 * @see {@link https://threejs.org/docs/index.html#api/en/audio/AudioAnalyser | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/audio/AudioAnalyser.js | Source}
	 
**/
@:native("THREE.AudioAnalyser") extern class AudioAnalyser {
	/**
		
			 * Create a {@link AudioAnalyser} object, which uses an {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode | AnalyserNode} to analyse audio data.
			 * This uses the {@link https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API | Web Audio API}.
			 * @example
			 * ```typescript
			 * // create an AudioListener and add it to the camera
			 * const listener = new THREE.AudioListener();
			 * camera.add(listener);
			 * // create an Audio source
			 * const sound = new THREE.Audio(listener);
			 * // load a sound and set it as the Audio object's buffer
			 * const audioLoader = new THREE.AudioLoader();
			 * audioLoader.load('sounds/ambient.ogg', function (buffer) {
			 *     sound.setBuffer(buffer);
			 *     sound.setLoop(true);
			 *     sound.setVolume(0.5);
			 *     sound.play();
			 * });
			 * // create an AudioAnalyser, passing in the sound and desired fftSize
			 * const analyser = new THREE.AudioAnalyser(sound, 32);
			 * // get the average frequency of the sound
			 * const data = analyser.getAverageFrequency();
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webaudio_sandbox | webaudio / sandbox }
			 * @see Example: {@link https://threejs.org/examples/#webaudio_visualizer | webaudio / visualizer }
			 * @see {@link https://threejs.org/docs/index.html#api/en/audio/AudioAnalyser | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/audio/AudioAnalyser.js | Source}
			 
	**/
	function new(audio:js.three.audio.Audio<js.html.audio.AudioNode>, ?fftSize:Float):Void;
	/**
		
			 * An {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode | AnalyserNode} used to analyze audio.
			 
	**/
	var analyser : js.html.audio.AnalyserNode;
	/**
		
			 * A Uint8Array with size determined by {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/frequencyBinCount | analyser.frequencyBinCount} used to hold analysis data.
			 
	**/
	var data : js.lib.Uint8Array;
	/**
		
			 * Uses the Web Audio's {@link https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/getByteFrequencyData | getByteFrequencyData} method
			 
	**/
	function getFrequencyData():js.lib.Uint8Array;
	/**
		
			 * Get the average of the frequencies returned by the {@link AudioAnalyser.getFrequencyData | getFrequencyData} method.
			 
	**/
	function getAverageFrequency():Float;
}