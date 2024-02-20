package wquery;

extern class Event<EventArgsType> {
	function new():Void;
	function on(handler:EventArgsType -> Void):Void;
	function off(?handler:EventArgsType -> Void):Void;
	function emit(args:EventArgsType):Void;
}