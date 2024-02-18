package nanofl.ide;

interface ITimeline extends nanofl.engine.ITimeline
{
	function getTimelineState() : nanofl.ide.undo.states.TimelineState;
	function setTimelineState(state:nanofl.ide.undo.states.TimelineState) : Void;
}