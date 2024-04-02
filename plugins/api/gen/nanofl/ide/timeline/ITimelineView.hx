package nanofl.ide.timeline;

interface ITimelineView {
	function insertFrame():Void;
	function convertToKeyFrame():Void;
	function addBlankKeyFrame():Void;
	function gotoPrevFrame():Void;
	function gotoNextFrame():Void;
	function createTween():Void;
	function removeTween():Void;
	function removeSelectedFrames():Void;
	function updateFrames(?isUpdateHeader:Bool):Void;
	function updateHeader():Void;
	function updateActiveFrame():Void;
	function update():Void;
	function play():Void;
	function stop():Void;
	function setSelectedLayerType(type:String):Void;
	function renameActiveLayerByUser():Void;
	function pasteFromXml(xml:htmlparser.XmlDocument):Bool;
}