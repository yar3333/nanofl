package nanofl.ide;

extern class Invalidater {
	function new():Void;
	function invalidateTimelineHeader():nanofl.ide.Invalidater;
	function invalidateTimelineFrames():nanofl.ide.Invalidater;
	function invalidateTimelineActiveFrame():nanofl.ide.Invalidater;
	function invalidateEditorShapes():nanofl.ide.Invalidater;
	function invalidateEditorLight():nanofl.ide.Invalidater;
	function invalidateEditorDeep():nanofl.ide.Invalidater;
	function invalidateLibrary():nanofl.ide.Invalidater;
	function updateInvalidated(editor:nanofl.ide.editor.Editor, timeline:nanofl.ide.timeline.IIdeTimeline, libraryView:components.nanofl.library.libraryview.Code):Void;
}