package nanofl.ide.timeline;

import htmlparser.XmlDocument;

interface ITimelineView
{
	function insertFrame() : Void;
	function convertToKeyFrame() : Void;
	function addBlankKeyFrame() : Void;
	function gotoPrevFrame() : Void;
	function gotoNextFrame() : Void;
	function createTween() : Void;
	function removeTween() : Void;
	function removeSelectedFrames() : Void;
	function updateFrames() : Void;
	function update() : Void;
	
	function play() : Void;
	function stop() : Void;
	
	function setSelectedLayerType(type:String) : Void;
	
	function renameActiveLayerByUser() : Void;
    function addLayer() : Void;
    function addFolder() : Void;
    function removeLayer() : Void;
	
	function pasteFromXml(xml:XmlDocument) : Bool;

    var frameCollapseFactor(get, set) : Int;
}