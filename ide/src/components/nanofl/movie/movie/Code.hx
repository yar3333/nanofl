package components.nanofl.movie.movie;

import nanofl.engine.Log.console;
using js.jquery.Layout;
using Lambda;

class Code extends wquery.Component
{
	static var imports =
	{
		"timeline": components.nanofl.movie.timeline.Code,
		"toolbar": components.nanofl.movie.toolbar.Code,
		"navigator": components.nanofl.movie.navigator.Code,
		"zoomer": components.nanofl.movie.zoomer.Code,
		"editor": components.nanofl.movie.editor.Code,
		"status-bar": components.nanofl.others.statusbar.Code
	};

	var editorLayout : LayoutInstance;
	var frameLayout : LayoutInstance;
    
	public var navigator : components.nanofl.movie.navigator.Code;
	public var timeline : components.nanofl.movie.timeline.Code;
	public var editor : components.nanofl.movie.editor.Code;
	public var toolbar : components.nanofl.movie.toolbar.Code;
	public var statusBar : components.nanofl.others.statusbar.Code;
	public var zoomer : components.nanofl.movie.zoomer.Code;
	
	function init()
    {
		editorLayout = template().container.layout
		({
			defaults: { enableCursorHotkey:false },
			north: { onresize_end:onResizeEditorNorth, size: 110 },
		});
		
		frameLayout = template().frameContainer.layout
		({
			defaults: { enableCursorHotkey:false },
			west: { size:37, resizable:false, closable:false, spacing_open:1 },
			center: { onresize_end:onResizeFrameCenter }
		});
		
		navigator = template().navigator;
		timeline = template().timeline;
		editor = template().editor;
		toolbar = template().toolbar;
		statusBar = template().statusBar;
		zoomer = template().zoomer;
    }
	
	public function resize()
	{
		template().container.height(template().container.parent().height());
		editorLayout.resizeAll();
		frameLayout.resizeAll();
		fixTimelineSize();
	}
	
	public function show()
	{
		template().container.show();
	}
	
	public function hide()
	{
		template().container.hide();
	}
	
	function onResizeEditorNorth(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
        try
        {
            fixTimelineSize();
        }
        catch (e)
        {
            console.error(e);
        }
	}
	
	function onResizeFrameCenter(paneName:String, paneElem:js.JQuery, paneState:LayoutPaneState, paneOptions:LayoutPaneOptions, paneLayoutName:String) : Void
	{
        try
        {
            resizeEditor(paneState.innerWidth, paneState.innerHeight - template().navigatorLine.height() - statusBar.height());
        }
        catch (e)
        {
            console.error(e);
        }
	}
	
	function fixTimelineSize()
	{
		if (editorLayout.panes.north != null)
		{
			resizeTimeline
			(
				editorLayout.panes.north.innerWidth(),
				editorLayout.panes.north.innerHeight()
			);
		}
	}
	
	function resizeEditor(width:Int, height:Int)
	{
		editor.resize(width, height);
	}
	
	function resizeTimeline(width:Int, height:Int)
	{
		timeline.resize(width, height);
	}
}