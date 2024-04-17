package nanofl.ide;

import nanofl.ide.editor.Editor;
import nanofl.ide.timeline.ITimelineView;

class Invalidater
{
	public function new() {}
	
	var updateTimelineHeader = false;
	var updateTimelineFrames = false;
	var updateTimelineActiveFrame = false;
	
	var updateShapes = false;
	var updateEditor = false;
	var rebindEditor = false;
	
	var updateLibrary = false;
	
	public function invalidateTimelineHeader() { updateTimelineHeader = true; return this; }
	public function invalidateTimelineFrames() { updateTimelineFrames = true; return this; }
	public function invalidateTimelineActiveFrame() { updateTimelineActiveFrame = true; return this; }
	
	public function invalidateEditorShapes() { updateShapes = true; return this; }
	public function invalidateEditorLight() { updateEditor = true; return this; }
	public function invalidateEditorDeep() { rebindEditor = true; return this; }
	
	public function invalidateLibrary() { updateLibrary = true; return this; }
	
	public function updateInvalidated(editor:Editor, timeline:ITimelineView, libraryView:components.nanofl.library.libraryview.Code)
	{
		if (updateTimelineFrames) timeline.updateFrames();
		else
		if (updateTimelineHeader) timeline.updateHeader();
		
		if (updateTimelineActiveFrame) timeline.updateActiveFrame();
		
		if (updateShapes) cast(editor, Editor).figure.updateShapes();
		
		if (rebindEditor)
		{
			editor.rebind();
		}
		else
		{
			if (updateShapes || updateEditor) editor.update();
		}
		
		if (updateLibrary)
		{
			libraryView.update();
		}
		
		updateTimelineHeader = false;
		updateTimelineFrames = false;
		
		updateShapes = false;
		updateEditor = false;
		rebindEditor = false;
		
		updateLibrary = false;
	}
}