package js.three.core;

extern interface BaseEvent<TEventType:(String)> {
	var type(default, null) : TEventType;
}