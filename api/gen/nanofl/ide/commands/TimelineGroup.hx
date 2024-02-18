package nanofl.ide.commands;

extern class TimelineGroup extends nanofl.ide.commands.BaseGroup {
	function new():Void;
	function insertFrame():Void;
	function convertToKeyFrame():Void;
	function addBlankKeyFrame():Void;
	function gotoPrevFrame():Void;
	function gotoNextFrame():Void;
	function createTween():Void;
	function removeTween():Void;
	function removeFrame():Void;
	function play():Void;
	function stop():Void;
	function switchLayerTypeToNormal():Void;
	function switchLayerTypeToMask():Void;
	function switchLayerTypeToMasked():Void;
	function switchLayerTypeToGuide():Void;
	function switchLayerTypeToGuided():Void;
	function cut():Void;
	function copy():Void;
	function paste():Void;
	function renameLayer():Void;
}