package js.three.core;

extern interface Event<TEventType:(String), TTarget> {
	var type(default, null) : TEventType;
	var target(default, null) : TTarget;
}