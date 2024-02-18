package js.three.textures;

typedef IEventTarget = {
	/**
		
				Register an event handler of a specific event type on the `EventTarget`.
				@throws DOMError
			
	**/
	function addEventListener(type:String, listener:haxe.Constraints.Function, ?options:haxe.extern.EitherType<js.html.AddEventListenerOptions, Bool>, ?wantsUntrusted:Bool):Void;
	/**
		
		        Dispatch an event to this `EventTarget`.
		        @throws DOMError
		    
	**/
	function dispatchEvent(event:js.html.Event):Bool;
	/**
		
		        Removes an event listener from the `EventTarget`.
		        @throws DOMError
		    
	**/
	function removeEventListener(type:String, listener:haxe.Constraints.Function, ?options:haxe.extern.EitherType<js.html.EventListenerOptions, Bool>):Void;
};