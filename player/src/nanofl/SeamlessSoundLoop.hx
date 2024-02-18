package nanofl;

import haxe.Timer;
import js.Browser;
import soundjs.AbstractSoundInstance;
import soundjs.Sound;

@:expose
class SeamlessSoundLoop
{
	static var delay : Int;
	
	var sounds : Array<AbstractSoundInstance>;
	var timer : Timer;
	
	var n = 1;
	
	public function new(sound:AbstractSoundInstance)
	{
		if (sound.duration == null || sound.duration == 0) return;
		if (delay == null) delay = detectDelay();
		sounds = [ sound, Sound.createInstance(sound.src) ];
		switchSound();
	}
	
	public function stop()
	{
		sounds[0].destroy();
		sounds[1].destroy();
		timer.stop();
	}
	
	function switchSound()
	{
		n = n == 1 ? 0 : 1;
		sounds[n].play();
		timer = Timer.delay(switchSound, Math.round(sounds[0].duration));
	}
	
	function detectDelay() : Int
	{
		var window : Dynamic = Browser.window;
		var document : Dynamic = Browser.document;
		
		if (window.mozInnerScreenX != null && ~/firefox/i.match(Browser.navigator.userAgent)) return -25; // ff
		if (document.all) return -30; // ie
		if (window.chrome) return -25; // chrome
		if (~/safari/i.match(Browser.navigator.userAgent) && window.getComputedStyle && !window.globalStorage) return -30;
		
		return 0;
	}
}