package nanofl.ide.commands;

import nanofl.ide.Clipboard;
import nanofl.ide.timeline.ITimelineView;
import nanofl.ide.ui.View;

@:rtti
class TimelineGroup extends BaseGroup
{
	@inject var view : View;
	@inject var clipboard : Clipboard;
	
	var timeline(get, never) : ITimelineView;
    function get_timeline() return app.document != null ? view.movie.timeline : null;
	
	public function insertFrame()		timeline.insertFrame();
	public function convertToKeyFrame()	timeline.convertToKeyFrame();
	public function addBlankKeyFrame()	timeline.addBlankKeyFrame();
	public function gotoPrevFrame()		timeline.gotoPrevFrame();
	public function gotoNextFrame()		timeline.gotoNextFrame();
	public function createTween()		timeline.createTween();
	public function removeTween()		timeline.removeTween();
	public function removeFrame()		timeline.removeSelectedFrames();
	
	public function play() timeline.play();
	public function stop() timeline.stop();
	
	public function switchLayerTypeToNormal()	timeline.setSelectedLayerType("normal");
	public function switchLayerTypeToMask()		timeline.setSelectedLayerType("mask");
	public function switchLayerTypeToMasked()	timeline.setSelectedLayerType("masked");
	public function switchLayerTypeToGuide()	timeline.setSelectedLayerType("guide");
	public function switchLayerTypeToGuided()	timeline.setSelectedLayerType("guided");
	
	public function renameLayer()   timeline.renameActiveLayerByUser();
	public function addLayer()      timeline.addLayer();
	public function addFolder()     timeline.addFolder();
	public function removeLayer()   timeline.removeLayer();
	
    public function cut()	tempActiveView(ActiveView.TIMELINE, clipboard.cut);
	public function copy()	tempActiveView(ActiveView.TIMELINE, clipboard.copy);
	public function paste()	tempActiveView(ActiveView.TIMELINE, clipboard.paste);
}
