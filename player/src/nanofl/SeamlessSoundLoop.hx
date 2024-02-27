package nanofl;

import js.html.Audio;
import haxe.Timer;
import js.Browser;

@:expose
class SeamlessSoundLoop
{
	static var delay : Int;
	
	var sounds : Array<Audio>;
	var timer : Timer;
	
	var n = 1;
	
	public function new(audio:Audio)
	{
		if (audio.duration == null || audio.duration == 0) return;
		if (delay == null) delay = detectDelay();
		sounds = [ audio, cast audio.cloneNode() ];
		switchSound();
	}
	
	public function stop()
	{
        if (sounds[0] != null)
        {
            sounds[0].pause(); sounds[0] = null;
            sounds[1].pause(); sounds[1] = null;
            timer.stop();
        }
	}
	
	function switchSound()
	{
		n = n == 1 ? 0 : 1;
        if (sounds[n] != null)
        {
            sounds[n].play();
            timer = Timer.delay(switchSound, Math.round(sounds[0].duration));
        }
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