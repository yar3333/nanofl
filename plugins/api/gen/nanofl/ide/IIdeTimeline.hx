package nanofl.ide;

interface IIdeTimeline extends nanofl.engine.ITimeline {
	function getTimelineState():nanofl.ide.undo.states.TimelineState;
	function setTimelineState(state:nanofl.ide.undo.states.TimelineState):Void;
}