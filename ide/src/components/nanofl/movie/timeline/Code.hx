package components.nanofl.movie.timeline;

import js.JQuery;
import js.Browser;
import stdlib.ExceptionTools;
import wquery.ComponentList;
import htmlparser.XmlBuilder;
import htmlparser.XmlNodeElement;
import nanofl.engine.LayerType;
import nanofl.engine.Version;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.ide.Globals;
import nanofl.ide.AsyncTicker;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.draganddrop.IDragAndDrop;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.draganddrop.AllowedDropEffect;
import nanofl.ide.timeline.ITimelineView;
import nanofl.ide.timeline.EditorTimeline;
import nanofl.ide.timeline.droppers.LayerToHeaderTitleDropper;
import nanofl.ide.timeline.droppers.LayerToLayerDropper;
import nanofl.ide.timeline.droppers.LayerToTitleDropper;
import nanofl.ide.ui.AutoScrollHorizontally;
import stdlib.Debug;
import stdlib.Std;
using stdlib.StringTools;
using js.jquery.Editable;
using nanofl.ide.HtmlElementTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class Code extends wquery.Component 
    implements ITimelineView
{
	static var imports =
	{
		"horizontal-scrollbar": components.nanofl.common.horizontalscrollbar.Code,
		"context-menu": components.nanofl.common.contextmenu.Code
	};
	
	static var ADDITIONAL_FRAMES_TO_DISPLAY(null, never) = 200;
	static var FRAME_WIDTH(null, never) = 10;
	static var SCROLLBAR_SIZE(null, never) = 20;
	
	@inject var dragAndDrop : DragAndDrop;
	
	var layers : ComponentList<components.nanofl.movie.timelinelayer.Code>;
	
	var adapter : EditorTimeline;
	
	function getLayerNodes() : JQuery return template().content.find(">div");
	function getLayerNodeByIndex(n:Int) : JQuery return template().content.find(">div:nth-child(" + (n + 1) + ")");
	function getLayerNodeByFrameNode(elem:JQuery) : JQuery return elem.parent().parent().parent();
	function getLayerFramesContainerByIndex(n:Int) : JQuery return layers.getByIndex(n).q("#framesContent");
	
	function getFrameNodes(filter="") : JQuery return template().content.find(">div>.frames-content>*>*" + filter);
	function getFrameNodesByLayerIndex(n:Int, filter="") : JQuery return template().content.find(">div:nth-child(" + (n + 1) + ")>.frames-content>*>*" + filter);
	function getFrameNodesByLayer(elem:JQuery, filter="") : JQuery return elem.find(">.frames-content>*>*" + filter);
	
	function getLayerByLayerNode(elem:JQuery) : Layer return adapter.layers[elem.index()];
	
	var mouseDownOnHeader : Bool;
	var mouseDownOnFrame : JQuery;
	
	var playTimer : AsyncTicker;
	var playStartFrameIndex : Int;
	
	var freeze = false;
	
	public function bind(adapter:EditorTimeline)
	{
		this.adapter = adapter;
		
		if (adapter == null) return;
		
		template().layerContextMenu.build(template().container,	"#" + template().content[0].id + ">*",	adapter.getLayerContextMenu(), toggleLayerContextMenuItems);
		template().frameContextMenu.build(template().content,	">*>.frames-content>*>*",				adapter.getFrameContextMenu(), toggleFrameContextMenuItems);
	}
	
	public function init()
	{
		Globals.injector.injectInto(this);
		
		layers = new ComponentList<components.nanofl.movie.timelinelayer.Code>(components.nanofl.movie.timelinelayer.Code, this, template().content);
		
		q(js.Browser.document).mouseup(function(e)
		{
			if (e.which == 1)
			{
				mouseDownOnHeader = false;
				mouseDownOnFrame = null;
			}
		});
		
		q(js.Browser.document).on("mousedown", _ ->
		{
			if (adapter != null && adapter.frameIndex != playStartFrameIndex) stop();
		});

		q(js.Browser.document).on("keydown", (e:JqEvent) ->
		{
            if (!e.ctrlKey && !e.shiftKey && !e.altKey && e.key == "Enter") return;
			if (adapter != null && adapter.frameIndex != playStartFrameIndex) stop();
		});
		
		template().framesHeader.on("mousedown", ">*", e -> if (e.which == 1) onFrameHeaderMouseDown(e));
		template().framesBorder.on("mousedown", ">*", e -> if (e.which == 1) onFrameHeaderMouseDown(e));
		template().framesHeader.on("mousemove", ">*", onFrameHeaderMouseMove);
		template().framesBorder.on("mousemove", ">*", onFrameHeaderMouseMove);
		
		template().content.on("mousedown", ">*>.frames-content>*>*", e -> if (e.which == 1) onFrameMouseDown(e));
		template().content.on("mousemove", ">*>.frames-content>*>*", onFrameMouseMove);
		template().content.on("dblclick",  ">*>.frames-content>*>*", onDoubleClickOnFrame);
		template().content.on("click",     ">*>.frames-content>*>*", e -> if (e.altKey) onDoubleClickOnFrame(e));
		
		dragAndDrop.ready.then(api ->
		{
			api.droppable
			(
				template().headerTitle,
				[
					"layer" => new LayerToHeaderTitleDropper()
				]
			);
			
			api.droppable
			(
				template().content,
				[
					"layer" => new LayerToLayerDropper(template().content)
				]
			);
		});
		
		var padLeft = template().buttons.width();
		var padRight = SCROLLBAR_SIZE;
		new AutoScrollHorizontally(template().headers, template().hScrollbar, padLeft, padRight, onAutoScrollHorizontally);
		new AutoScrollHorizontally(template().borders, template().hScrollbar, padLeft, padRight, onAutoScrollHorizontally);
		new AutoScrollHorizontally(template().content, template().hScrollbar, padLeft, padRight, onAutoScrollHorizontally);
	}
	
	function onAutoScrollHorizontally(dx:Int)
	{
		if (dx < 0)
		{
			adapter.frameIndex = Math.ceil(template().hScrollbar.position / FRAME_WIDTH);
		}
		else
		if (dx > 0)
		{
			adapter.frameIndex = Math.floor((template().hScrollbar.position + getVisibleFramesWidth()) / FRAME_WIDTH) - 1;
		}
	}
	
	function toggleLayerContextMenuItems(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, layerElem:JQuery)
	{
		if (!adapter.editable) return false;
		
		deselectAllFrames();
		deselectAllLayers();
		layerElem.addClass("selected");
		
		var indexes = getSelectedLayerIndexes();
		Debug.assert(indexes.length == 1);
		
		var index = indexes[0];
		var layer = adapter.layers[index];
		
		if (layer.type == LayerType.folder)
		{
			e.preventDefault();
			return false;
		}
		
		freezed(function() adapter.layerIndex = index);
		
		var parentIndex = getPotentialParentLayerIndex(index);
		var parentLayerType = parentIndex != null ? adapter.layers[parentIndex].type : null;
		var humanType = layer.getHumanType();
		
		menu.toggleItem("timeline.switchLayerTypeToMask",	humanType != "masked" && humanType != "guided");
		menu.toggleItem("timeline.switchLayerTypeToGuide",	humanType != "masked" && humanType != "guided");
		menu.toggleItem("timeline.switchLayerTypeToMasked",	parentLayerType == LayerType.mask);
		menu.toggleItem("timeline.switchLayerTypeToGuided",	parentLayerType == LayerType.guide);
		
		menu.getAllItems().removeClass("checked");
		menu.getItem("timeline.switchLayerTypeTo" + layer.getHumanType().capitalize()).addClass("checked");
		
		return true;
	}
	
	function toggleFrameContextMenuItems(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, frameNode:JQuery)
	{
		if (!adapter.editable) return false;
		
		if (!frameNode.hasClass("selected"))
		{
			var layerNode = getLayerNodeByFrameNode(frameNode);
			freezed(() ->
			{
				adapter.layerIndex = layerNode.index();
				adapter.frameIndex = frameNode.index();
			});
			deselectAllFrames();
			deselectAllLayers();
			frameNode.addClass("selected");
			layerNode.addClass("selected");
			fixActiveFrame();
		}
		
		var hasFrameWiTween = false;
		var hasFrameWoTween = false;
		for (frameNode in getFrameNodes(".selected"))
		{
			hasFrameWiTween = hasFrameWiTween ||  (frameNode.hasClass("tween") || frameNode.hasClass("tween-bad"));
			hasFrameWoTween = hasFrameWoTween || !(frameNode.hasClass("tween") || frameNode.hasClass("tween-bad"));
			if (hasFrameWiTween && hasFrameWoTween) break;
		}
		
		menu.enableItem("timeline.createTween", hasFrameWoTween);
		menu.enableItem("timeline.removeTween", hasFrameWiTween);
		
		return true;
	}
	
	@:profile
	public function update()
	{
		if (freeze) return;
		
		var editable = adapter.editable;
		template().controls.find("button").prop("disabled", !editable);
		template().visibleAll.add(template().lockedAll).css("visibility", editable ? "" : "hidden");
		
		layers.clear();
		template().content.html("");
		
		for (i in 0...adapter.layers.length)
		{
			createLayer(i);
		}
		
		resize(template().container.width(), template().container.height());
		updateHeader();
		updateScrolls();
		
		fixActiveFrame();
	}
	
	function extendSelection(layerIndex:Int, frameIndex:Int)
	{
		var fromLayerIndex = Std.min(layerIndex, adapter.layerIndex);
		var fromFrameIndex = Std.min(frameIndex, adapter.frameIndex);
		var toLayerIndex = Std.max(layerIndex, adapter.layerIndex);
		var toFrameIndex = Std.max(frameIndex, adapter.frameIndex);
		
		for (i in fromLayerIndex...(toLayerIndex + 1))
		{
			var frameNodes = getFrameNodesByLayerIndex(i);
			for (j in fromFrameIndex...(toFrameIndex + 1))
			{
				frameNodes[j].addClass("selected");
			}
		}
	}
	
	public function insertFrame()
	{
		adapter.beginTransaction();
		
		var changes = new Changes();
		
		var hasSelectedFrames = false;
		iterateSelectedFramesReversed(function(e)
		{
			hasSelectedFrames = true;
			e.layer.insertFrame(e.frameIndex);
			changes.frames = true;
		});
		
		if (!hasSelectedFrames)
		{
			for (layer in adapter.layers)
			{
				layer.insertFrame(adapter.frameIndex);
			}
			changes.frames = true;
		}
		
		updateInvalidated(changes);
		
		adapter.commitTransaction();
	}
	
	public function convertToKeyFrame()
	{
		adapter.beginTransaction();
		
		var changes = new Changes();
		var wasConvert = false;
		
		iterateSelectedFrames(function(e)
		{
			e.layer.convertToKeyFrame(e.frameIndex);
			changes.frames = true;
			wasConvert = true;
		});
		
		updateInvalidated(changes);
		
		if (wasConvert) adapter.onConvertToKeyFrame();
		
		adapter.commitTransaction();
	}
	
	public function addBlankKeyFrame()
	{
		adapter.beginTransaction();
		
		var changes = new Changes();
		
		var wantToChangeFrameIndexTo = null;
		
		iterateSelectedFrames(function(e)
		{
			var frame = e.layer.getFrame(e.frameIndex);
			
			if (frame.subIndex == 0)
			{
				if (e.frameIndex == e.layer.getTotalFrames() - 1)
				{
					adapter.addNewKeyFrameToLayer(e.layer);
					wantToChangeFrameIndexTo = adapter.getTotalFrames() - 1;
					changes.frames = true;
				}
			}
			else
			{
				e.layer.convertToKeyFrame(e.frameIndex, true);
				changes.frames = true;
			}
		});
		
		if (wantToChangeFrameIndexTo != null)
		{
			//adapter.setFrameIndex(wantToChangeFrameIndexTo, changes);
			adapter.frameIndex = wantToChangeFrameIndexTo;
		}
		
		adapter.commitTransaction();
		
		updateInvalidated(changes);
	}
	
	public function removeSelectedFrames()
	{
		adapter.beginTransaction();
		
		var changes = new Changes();
		var wasRemoves = false;
		
		iterateSelectedFramesReversed(function(e)
		{
			e.layer.removeFrame(e.frameIndex);
			changes.frames = true;
			wasRemoves = true;
		});
		
		adapter.commitTransaction();
		
		freezed(function() adapter.frameIndex = Std.min(adapter.frameIndex, adapter.getTotalFrames() - 1));
		
		updateInvalidated(changes);
		
		if (wasRemoves) adapter.onFrameRemoved();
	}
	
	@:profile
	function createLayer(layerIndex:Int)
	{
		var layer = adapter.layers[layerIndex];
		
		var t = layers.create
		({
			  title: htmlEscape(layer.name != "" ? layer.name : " ")
			, iconCssClass: layer.getIcon()
			, layerCssClass: " subLayer" + adapter.getLayerNestLevel(layer) + " layer-type-" + layer.type + (layerIndex == adapter.layerIndex ? " active" : "")
			, layerLockedCssClass: adapter.editable ? (layer.locked ? "icon-lock" : "custom-icon-point") : "custom-icon-empty"
			, layerVisibleCssClass: adapter.editable ? (layer.visible ? "custom-icon-point" : "custom-icon-remove") : "custom-icon-empty"
		});
		
		t.event_iconClick.on(onIconClick.bind(t, _));
		t.event_titleClick.on(onIconClick.bind(t, _));
		t.event_editedClick.on(onIconClick.bind(t, _));
		t.event_visibleClick.on(onVisibleClick.bind(t, _));
		t.event_lockedClick.on(onLockedClick.bind(t, _));
		
		Debug.assert(layers.getByIndex(layerIndex) == t);
		
		if (adapter.editable)
		{
			var title = t.q("#title");
			
			title.editable
			({
				enabled: (jq:JQuery) ->
				{
					return jq.parent().hasClass("selected");
				},
				beginEdit: (jq:JQuery, input:JQuery) ->
				{
					input.width(jq.width());
					jq.hide();
					input.insertAfter(jq);
				},
				endEdit: (jq:JQuery) ->
				{
					jq.css("display", "");
				},
				setData: (jq:JQuery, value:String) ->
				{
					value = StringTools.trim(value);
					adapter.beginTransaction();
					layer.name = value;
					jq.html(htmlEscape(value != "" ? value : " "));
					adapter.commitTransaction();
				},
				cssClass: "inPlaceEdit"
			});
			
			dragAndDrop.ready.then((api:IDragAndDrop) ->
			{
				api.draggable(title, null, "layer", (out:XmlBuilder, e:JqEvent) ->
				{
					out.attr("text", layer.name);
					out.attr("icon", layer.getIcon());
					out.attr("layerIndex", Std.string(layerIndex));
					layer.save(out);
					return AllowedDropEffect.move;
				});
				
				api.droppable
				(
					title,
					[
						"layer" => new LayerToTitleDropper(t.q("#layerRow"))
					]
				);
			});
		}
		
		updateLayerFrames(layerIndex, false);
	}
	
	function addLayer_click(e)
	{
		adapter.beginTransaction();
		
		var layer = adapter.newLayer("Layer " + adapter.layers.length);
		adapter.addNewKeyFrameToLayer(layer);
		
		var prevLayer = adapter.layerIndex != null && adapter.layerIndex >= 0 && adapter.layerIndex < adapter.layers.length
					  ? adapter.layers[adapter.layerIndex]
					  : null;
		adapter.addLayersBlock([ layer ], adapter.layerIndex);
		if (prevLayer != null && prevLayer.parentIndex != null) layer.parentIndex = prevLayer.parentIndex;
		
		update();
		
		freezed(() ->
		{
			adapter.onLayerAdded();
		});
		
		adapter.commitTransaction();
	}
	
	function addFolder_click(e)
	{
		adapter.beginTransaction();
		
		var n = adapter.layerIndex;
		while (n != null && n >= 0 && n < adapter.layers.length && adapter.layers[n].parentIndex != null) n++;
		
		adapter.addLayersBlock([ adapter.newLayer("TLLayer " + adapter.layers.length, LayerType.folder) ], n);
		
		update();
		
		adapter.commitTransaction();
	}
	
	function removeLayer_click(e)
	{
		adapter.beginTransaction();
		
		var layerNodes = getLayerNodes();
		
		var i = layerNodes.length - 1;
		while (i >= 0)
		{
			if (layerNodes[i].hasClass("selected"))
			{
				adapter.removeLayer(i);
			}
			i--;
		}

        if (adapter.layers.length == 0)
        {
            adapter.addLayer(adapter.newLayer("Layer 1"));
        }
		
		if (adapter.layerIndex >= adapter.layers.length)
		{
			adapter.layerIndex = Std.max(0, adapter.layers.length - 1);
		}
		
		update();
		
		freezed(() ->
		{
			adapter.onLayerRemoved();
		});
		
		adapter.commitTransaction();
	}
	
	@:profile
	public function updateHeader()
	{
		var displayFrameCount = adapter.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
		
		if (template().framesHeader.children().length != displayFrameCount)
		{
			var framesHeader = "";
			var framesBorder = "";
			for (i in 0...displayFrameCount)
			{
				var active = i == adapter.frameIndex ? " class='active'" : "";
				framesHeader += "<span" + active + ">" + (i % 5 == 0 ? Std.string(i) : "&nbsp;") + "</span>";
				framesBorder += "<span" + active + ">&nbsp;</span>";
			}
			template().framesHeader.html(framesHeader);
			template().framesBorder.html(framesBorder);
		}
	}
	
	function onIconClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		var layerNode = t.q("#layerRow");
		var type = getLayerByLayerNode(layerNode).type;
		var layerIndex = layerNode.index();
		
		if (e.ctrlKey)
		{
			if (layerNode.hasClass("selected"))
			{
				getFrameNodesByLayer(layerNode).removeClass("selected");
				layerNode.removeClass("selected");
			}
			else
			{
				getFrameNodesByLayer(layerNode, ".frame").addClass("selected");
				if (type != LayerType.folder)
				{
					adapter.layerIndex = layerNode.index();
				}
				else
				{
					layerNode.addClass("selected");
				}
			}
		}
		else
		if (e.shiftKey)
		{
			for (i in Std.min(adapter.layerIndex, layerIndex)...(Std.max(adapter.layerIndex, layerIndex) + 1))
			{
				getFrameNodesByLayerIndex(i, ".frame").addClass("selected");
				getLayerNodeByIndex(i).addClass("selected");
			}
			if (type != LayerType.folder)
			{
				adapter.layerIndex = layerIndex;
			}
		}
		else
		{
			deselectAllLayers();
			deselectAllFrames();
			getFrameNodesByLayer(layerNode, ".frame").addClass("selected");
			if (type != LayerType.folder)
			{
				adapter.layerIndex = layerIndex;
			}
			else
			{
				layerNode.addClass("selected");
			}
		}
		
		freezed(() ->
		{
			adapter.onLayersSelectionChange(getSelectedLayerIndexes());
		});
	}
	
	function onVisibleClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		if (!adapter.editable) return;
		
		var layerData = getLayerByLayerNode(t.q("#layerRow"));
		q(e.currentTarget).find(">i").attr("class", !layerData.visible ? "custom-icon-point" : "custom-icon-remove");
		layerData.visible = !layerData.visible;
		
		adapter.onLayerVisibleChange();
	}
	
	function onLockedClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		if (!adapter.editable) return;
		
		var layerData = getLayerByLayerNode(t.q("#layerRow"));
		q(e.currentTarget).find(">i").attr("class", layerData.locked ? "custom-icon-point" : "icon-lock");
		layerData.locked = !layerData.locked;
		
		adapter.onLayerLockChange();
	}
	
	@:profile
	public function fixActiveFrame()
	{
		if (freeze) return;
		
		for (layerNode in getLayerNodes())
		{
			var frameNodes = getFrameNodesByLayer(layerNode);
			frameNodes.removeClass("active");
			frameNodes[adapter.frameIndex].addClass("active");
		}
		
		var headerFrames = template().framesHeader.children();
		headerFrames.removeClass("active");
		headerFrames[adapter.frameIndex].addClass("active");
		
		var borderFrames = template().framesBorder.children();
		borderFrames.removeClass("active");
		borderFrames[adapter.frameIndex].addClass("active");
	}
	
	@:profile
	public function fixActiveLayer()
	{
		if (freeze) return;
		
		var layerNodes = getLayerNodes();
		layerNodes.removeClass("active");
		if (adapter.layerIndex != null)
		{
			q(layerNodes[adapter.layerIndex]).addClass("selected active");
		}
	}
	
	function updateScrolls()
	{
		var width = 0;
		for (layer in getLayerNodes())
		{
			width = Std.max(width, layer.find(">.frames-content>*").width());
		}
		template().hScrollbar.size = width;
	}
	
	public function resize(maxWidth:Int, maxHeight:Int)
	{
		template().container.find(">*>*>.timeline-frames").width(maxWidth - template().buttons.width());
		template().hscrollContainer.width(maxWidth - SCROLLBAR_SIZE - template().buttons.width());
		template().content.height(maxHeight - template().headers.height() - template().borders.height() - template().controls.height());
	}
	
	function hScrollbar_change(e)
	{
		template().container.find(">*>*>.timeline-frames>*").css("left", - e.position + "px");
	}
	
	@:profile
	public function updateActiveLayerFrames()
	{
		if (freeze) return;
		
		updateLayerFrames(adapter.layerIndex, true);
	}
	
	@:profile
	public function updateActiveFrame()
	{
		if (freeze) return;
		
		for (i in 0...adapter.layers.length)
		{
			var frameNode = getFrameNodesByLayerIndex(i, ":nth-child(" + (adapter.frameIndex + 1) + ")");
			updateFrame(adapter.frameIndex, frameNode[0], getFrameCssClasses(i, adapter.frameIndex), true);
		}
	}
	
	public function updateFrames(isUpdateHeader=true)
	{
		if (isUpdateHeader) updateHeader();
		for (i in 0...adapter.layers.length) updateLayerFrames(i, true);
		updateScrolls();
	}
	
	@:profile
	function updateLayerFrames(layerIndex:Int, keepSelection:Bool)
	{
		if (layerIndex >= adapter.layers.length) return;
		
		var displayedFrameCount = adapter.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
		var container = getLayerFramesContainerByIndex(layerIndex);
		var frames = JQuery.makeArray(container.children());
		
		var newFrames = [];
		for (i in frames.length...displayedFrameCount)
		{
			newFrames.push(Browser.document.createElement("span"));
		}
		frames = frames.concat(newFrames);
		
		var frag = Browser.document.createDocumentFragment();
		for (frame in newFrames) frag.appendChild(frame);
		container.append(cast frag);
		
		while (frames.length > displayedFrameCount) frames.pop().remove();
		
		var cssClasses = getFramesCssClasses(layerIndex);
		for (i in 0...frames.length)
		{
			updateFrame(i, frames[i], cssClasses[i], keepSelection);
		}
	}
	
	function getFramesCssClasses(layerIndex:Int) : Array<String>
	{
		var r = [];
		
		var displayedFrameCount = adapter.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
		
		for (keyFrame in adapter.getLayerKeyFrames(adapter.layers[layerIndex]))
		{
			var base = "frame";
			if (!keyFrame.isEmpty()) base += " frame-notEmpty";
			if (keyFrame.hasMotionTween()) base += keyFrame.hasGoodMotionTween() ? " tween" : " tween-bad";
			r.push(base + " startKeyFrame" + (keyFrame.duration == 1 ? " finishKeyFrame" : "") + (keyFrame.label != "" ? " frame-label" : ""));
			for (i in 1...(keyFrame.duration - 1)) r.push(base);
			if (keyFrame.duration > 1) r.push(base + " finishKeyFrame");
		}
		
		if (layerIndex + 1 < adapter.layers.length)
		{
			for (i in r.length...adapter.layers[layerIndex + 1].getTotalFrames())
			{
				r.push("nextLayerFrame");
			}
		}
		
		while (r.length < displayedFrameCount) r.push("");
		
		return r;
	}
	
	function getFrameCssClasses(layerIndex:Int, frameIndex:Int) : String
	{
		var frame = adapter.layers[layerIndex].getFrame(frameIndex);
		
		if (frame != null)
		{
			var r = "frame";
			if (frame.subIndex == 0) r += " startKeyFrame";
			if (frame.subIndex == frame.keyFrame.duration - 1) r += " finishKeyFrame";
			if (!frame.keyFrame.isEmpty()) r += " frame-notEmpty";
			if (frame.keyFrame.hasMotionTween()) r += frame.keyFrame.hasGoodMotionTween() ? " tween" : " tween-bad";
			if (frame.keyFrame.label != "") r += " frame-label";
			return r;
		}
		
		if (layerIndex < adapter.layers.length - 1)
		{
			var nextLayerFramesCount = adapter.layers[layerIndex + 1].getTotalFrames();
			if (frameIndex < nextLayerFramesCount) return "nextLayerFrame";
		}
		
		return "";
	}
	
	function updateFrame(frameIndex:Int, frameElement:js.html.Element, cssClasses:String, keepSelection:Bool)
	{
		var selected = keepSelection && frameElement.hasClass("selected") ? " selected" : "";
		var active = frameIndex == adapter.frameIndex ? " active" : "";
		frameElement.setAttribute("class", cssClasses + selected + active);
	}
	
	@:profile
	public function selectLayerFrames(layerIndexes:Array<Int>)
	{
		if (freeze) return;
		
		var layerNodes = getLayerNodes();
		
		layerNodes.removeClass("selected");
		fixActiveLayer();
		
		for (i in 0...layerNodes.length)
		{
			var layer = layerNodes[i];
			var frameNodes = getFrameNodesByLayer(q(layer));
			frameNodes.removeClass("selected");
			if (layerIndexes.has(i)) frameNodes[adapter.frameIndex].addClass("selected");
		}
	}
	
	@:profile
	public function getAciveFrame() : KeyFrame
	{
		return adapter != null ? adapter.layers[adapter.layerIndex].getFrame(adapter.frameIndex).keyFrame : null;
	}
	
	function visibleAll_click(e)
	{
		var hasVisible = adapter.layers.exists(layer -> layer.visible);
		getLayerNodes().find(">.timeline-visible>i").attr("class", hasVisible ? "custom-icon-remove" : "custom-icon-point");
		
		for (layer in adapter.layers)
		{
			layer.visible = !hasVisible;
		}
		
		adapter.onLayerVisibleChange();
	}
	
	function lockedAll_click(e)
	{
		var hasUnlocked = adapter.layers.exists(layer -> !layer.locked);
		getLayerNodes().find(">.timeline-locked>i").attr("class", hasUnlocked ? "icon-lock" : "custom-icon-point");
		
		for (layer in adapter.layers)
		{
			layer.locked = hasUnlocked;
		}
		
		adapter.onLayerLockChange();
	}
	
	function onFrameMouseDown(e:JqEvent)
	{
		mouseDownOnFrame = q(e.currentTarget);
		var frameIndex = mouseDownOnFrame.index();
		
		var layerNode = getLayerNodeByFrameNode(mouseDownOnFrame);
		var layerIndex = layerNode.index();
		
		deselectAllLayers();
		
		if (e.ctrlKey)
		{
			mouseDownOnFrame.toggleClass("selected");
		}
		else
		if (e.shiftKey)
		{
			extendSelection(layerIndex, frameIndex);
		}
		else
		{
			deselectAllFrames();
			mouseDownOnFrame.addClass("selected");
		}
		
		setActiveLayerAndFrameThenUpdate(layerIndex, frameIndex);
	}
	
	function onFrameMouseMove(e:JqEvent)
	{
		if (mouseDownOnFrame != null)
		{
			var startFrameIndex = mouseDownOnFrame.index();
			var startLayerIndex = getLayerNodeByFrameNode(mouseDownOnFrame).index();
			
			var frame = q(e.currentTarget);
			var frameIndex = frame.index();
			var layerIndex = getLayerNodeByFrameNode(frame).index();
			
			if (startFrameIndex != frameIndex || startLayerIndex != layerIndex)
			{
				deselectAllFrames();
				
				for (i in Std.min(startLayerIndex, layerIndex)...Std.max(startLayerIndex, layerIndex) + 1)
				{
					var frameNodes = getFrameNodesByLayerIndex(i);
					for (j in Std.min(startFrameIndex, frameIndex)...Std.max(startFrameIndex, frameIndex) + 1)
					{
						frameNodes[j].addClass("selected");
					}
				}
				
				adapter.frameIndex = frameIndex;
				fixActiveFrame();
			}
		}
	}
	
	function onFrameHeaderMouseDown(e:JqEvent)
	{
		mouseDownOnHeader = true;
		deselectAllFrames();
		adapter.frameIndex = q(e.currentTarget).index();
	}
	
	function onFrameHeaderMouseMove(e:JqEvent)
	{
		if (!mouseDownOnHeader) return;
		
		deselectAllFrames();
		adapter.frameIndex = q(e.currentTarget).index();
	}
	
	function freezed(f:Void->Void) : Void
	{
		freeze = true;
		try f() catch (e:Dynamic) { freeze = false; ExceptionTools.rethrow(e); }
		freeze = false;
	}
	
	public function on(event:String, callb:JqEvent->Void)
	{
		template().container.on(event, callb);
	}
	
	public function createTween() 
	{
		iterateSelectedKeyFrames(function(keyFrame)
		{
			if (!keyFrame.hasMotionTween())
			{
				keyFrame.addDefaultMotionTween();
			}
		});
		
		adapter.onTweenCreated();
	}
	
	public function removeTween() 
	{
		iterateSelectedKeyFrames(keyFrame ->
		{
			keyFrame.removeMotionTween();
		});
		
		adapter.onTweenRemoved();
	}
	
	public function hasSelectedFrames()
	{
		return getFrameNodes("selected").length > 0;
	}
	
	public function saveSelectedToXml(out:XmlBuilder) : Array<IIdeLibraryItem>
	{
		var namePaths = [];
		
		out.begin("layers");
		var layerNodes = getLayerNodes();
		for (i in 0...layerNodes.length)
		{
			var rLayer = adapter.duplicateLayerWoFrames(adapter.layers[i]);
			
			var frameNodes = getFrameNodesByLayer(q(layerNodes[i]));
			
			for (keyFrame in adapter.getLayerKeyFrames(adapter.layers[i]))
			{
				if (frameNodes[keyFrame.getIndex()].hasClass("selected"))
				{
					adapter.addKeyFrame(rLayer, keyFrame.clone());
					
					for (namePath in adapter.getNamePaths(keyFrame))
					{
						if (namePaths.indexOf(namePath) < 0) namePaths.push(namePath);
					}
				}
			}
			
			if (adapter.getLayerKeyFrames(rLayer).length > 0)
			{
				rLayer.save(out);
			}
		}
		out.end();
		
		return adapter.getLibraryItems(namePaths);
	}
	
	public function pasteFromXml(xml:XmlNodeElement) : Bool
	{
		var r = false;
		
		if (adapter.editable)
		{
			for (layersNode in xml.find(">" + adapter.xmlLayersTag))
			{
				var layerIndex = adapter.layerIndex;
				for (layerNode in layersNode.find(">layer"))
				{
					var layer = Layer.load(layerNode, Version.document);
					
					if (layerIndex == adapter.layers.length)
					{
						//switch (pathItem.typed)
						{
							//case PathItemTyped.FLAT(pathItem):
								adapter.addLayer(layer);
						}
						r = true;
					}
					else
					{
						for (keyFrame in adapter.getLayerKeyFrames(layer))
						{
							adapter.addKeyFrame(adapter.layers[layerIndex], keyFrame.clone());
							r = true;
						}
					}
					layerIndex++;
				}
			}
		}
		
		return r;
	}
	
	function iterateSelectedKeyFrames(callb:KeyFrame->Void) 
	{
		var layerNodes = getLayerNodes();
		for (i in 0...layerNodes.length)
		{
			var frameNodes = getFrameNodesByLayer(q(layerNodes[i]));
			var j = 0; while (j < frameNodes.length)
			{
				if (frameNodes[j].hasClass("frame") && frameNodes[j].hasClass("selected"))
				{
					var f = adapter.layers[i].getFrame(j);
					callb(f.keyFrame);
					j += f.keyFrame.duration - f.subIndex;
				}
				else
				{
					j++;
				}
			}
		}
	}
	
	public function getSelectedLayerIndexes() : Array<Int>
	{
		var r = [];
		var i = 0; for (layer in getLayerNodes())
		{
			if (q(layer).hasClass("selected")) r.push(i);
			i++;
		}
		return r;
	}
	
	public function gotoPrevFrame()
	{
		if (adapter.frameIndex > 0)
		{
			adapter.frameIndex = adapter.frameIndex - 1;
		}
	}
	
	public function gotoNextFrame()
	{
		if (adapter.frameIndex < adapter.getTotalFrames() - 1)
		{
			adapter.frameIndex = adapter.frameIndex + 1;
		}
	}
	
	public function setSelectedLayerType(humanType:String)
	{
        final layerIndexes = getSelectedLayerIndexes();
		Debug.assert(layerIndexes.length == 1);

        final layer = adapter.layers[layerIndexes[0]];
        if (layer.getHumanType() == humanType) return;
        
        adapter.beginTransaction();

        setLayerType(layer, humanType);
		preserveLayerSelection(() -> update());

        adapter.commitTransaction();
	}
	
	function setLayerType(layer:Layer, humanType:String)
	{
		var index = adapter.layers.indexOf(layer);
		
		switch (humanType)
		{
			case "normal":
				if ([ "masked", "guided" ].has(layer.getHumanType()))
				{
					var parentIndex = layer.parentIndex;
					var newParentIndex = adapter.layers[parentIndex].parentIndex;
					while (index < adapter.layers.length && adapter.layers[index].parentIndex == parentIndex)
					{
						adapter.layers[index].parentIndex = newParentIndex;
						index++;
					}
				}
				layer.type = LayerType.normal;
				
			case "mask":
				layer.type = LayerType.mask;
				
			case "masked":
				layer.parentIndex = getPotentialParentLayerIndex(index);
				
			case "guide":
				layer.type = LayerType.guide;
				
			case "guided":
				layer.parentIndex = getPotentialParentLayerIndex(index);
				
			default:
				throw "Timeline.setLayerType: humanType '" + humanType + "' is not supported.";
		}
	}
	
	function getPotentialParentLayerIndex(layerIndex:Int) : Int
	{
		var i = layerIndex - 1; while (i > 0 && adapter.layers[i].parentIndex != null) i--;
		if (i >= 0)
		{
			switch (adapter.layers[i].type)
			{
				case LayerType.folder
				   , LayerType.mask
				   , LayerType.guide:
						return i;
					
				case LayerType.normal:
					// nothing to do
			}
		}
		return null;
	}
	
	function iterateSelectedFrames(callb:{ layerIndex:Int, frameIndex:Int, layer:Layer, frameNode:js.html.Element }->Void)
	{
		for (i in 0...adapter.layers.length)
		{
			if (adapter.layers[i].type == LayerType.folder) continue;
			
			var frameNodes = getFrameNodesByLayerIndex(i);
			for (j in 0...frameNodes.length)
			{
				if (frameNodes[j].hasClass("selected"))
				{
					callb({ layerIndex:i, frameIndex:j, layer:adapter.layers[i], frameNode:frameNodes[j] });
				}
			}
		}
	}
	
	function iterateSelectedFramesReversed(callb:{ layerIndex:Int, frameIndex:Int, layer:Layer, frameNode:js.html.Element }->Void)
	{
		for (i in 0...adapter.layers.length)
		{
			if (adapter.layers[i].type == LayerType.folder) continue;
			
			var frameNodes = getFrameNodesByLayerIndex(i);
			var j = frameNodes.length - 1;
			while (j >= 0)
			{
				if (frameNodes[j].hasClass("selected"))
				{
					callb({ layerIndex:i, frameIndex:j, layer:adapter.layers[i], frameNode:frameNodes[j] });
				}
				j--;
			}
		}
	}
	
	function preserveLayerSelection(callb:Void->Void)
	{
		var selectedLayerIndexes = getSelectedLayerIndexes();
		callb();
		selectLayersByIndexes(selectedLayerIndexes);
	}
	
	public function selectLayersByIndexes(layerIndexes:Array<Int>, replaceSelection=false)
	{
		var layerNodes = getLayerNodes();
		
		if (replaceSelection) layerNodes.removeClass("selected");
		
		for (index in layerIndexes)
		{
			layerNodes[index].addClass("selected");
		}
	}
	
	public function play()
	{
		if (playTimer != null) { stop(); return; }
		
		playStartFrameIndex = adapter.frameIndex;
		
        var totalFrames = adapter.getTotalFrames();
		
		playTimer = new AsyncTicker(adapter.framerate, () ->
		{
            final nextFrameIndex = (adapter.frameIndex + 1) % totalFrames;

            return adapter.setFrameIndexAndWaitStageUpdating(nextFrameIndex).then(_ ->
			{
                if (adapter.frameIndex == totalFrames - 1) stop();
                ensureActiveFrameVisible();
                return null;
            });
		});
		
		ensureActiveFrameVisible();
	}
	
	public function stop()
	{
		if (playTimer != null)
		{
			playTimer.stop();
			playTimer = null;
		}
	}
	
	public function renameSelectedLayerByUser()
	{
		for (layerComp in layers)
		{
			if (layerComp.selected)
			{
				layerComp.beginEditTitle();
				break;
			}
		}
	}
	
	public function getActiveKeyFrame() : KeyFrame
	{
		return adapter.layers[adapter.layerIndex].getFrame(adapter.frameIndex)?.keyFrame;
	}
	
	function ensureActiveFrameVisible()
	{
		var posX = adapter.frameIndex * FRAME_WIDTH;
		if (posX < template().hScrollbar.position)
		{
			template().hScrollbar.position = posX;
		}
		else
		{
			if (posX > template().hScrollbar.position + getVisibleFramesWidth() - FRAME_WIDTH)
			{
				template().hScrollbar.position = posX - (getVisibleFramesWidth() - FRAME_WIDTH);
			}
		}
	}
	
	function getVisibleFramesWidth() : Int
	{
		return template().headers.find(">div>.frames-headers").width() - SCROLLBAR_SIZE;
	}
	
	function onDoubleClickOnFrame(e:JqEvent)
	{
		var frameNode = q(e.currentTarget);
		
		var frameIndex = frameNode.index();
		var layerNode = getLayerNodeByFrameNode(frameNode);
		var layerIndex = layerNode.index();
		
		deselectAllFrames();
		
		var layer = adapter.layers[layerIndex];
		if (layer.type != LayerType.folder)
		{
			var frame = layer.getFrame(frameIndex);
			
			var frameNodes = getFrameNodesByLayer(layerNode);
			var start = frame.keyFrame.getIndex();
			for (i in start...start + frame.keyFrame.duration)
			{
				frameNodes[i].addClass("selected");
			}
		}
		
		setActiveLayerAndFrameThenUpdate(layerIndex, frameIndex);
	}
	
	function setActiveLayerAndFrameThenUpdate(layerIndex:Int, frameIndex:Int)
	{
		freezed(() ->
		{
			adapter.layerIndex = layerIndex;
			adapter.frameIndex = frameIndex;
			adapter.onLayersSelectionChange([ layerIndex ]);
		});
		
		fixActiveFrame();
		fixActiveLayer();
	}
	
	function deselectAllLayers() getLayerNodes().removeClass("selected");
	
	function deselectAllFrames() getFrameNodes().removeClass("selected");
	
	function htmlEscape(s:String) : String
	{
		return StringTools.htmlEscape(s)
			.replace(" ", "&nbsp;");
	}
	
	function updateInvalidated(changes:Changes)
	{
		if      (changes.frames) updateFrames();
		else if (changes.header) updateHeader();
		
		if (changes.activeFrame) updateActiveFrame();
	}
}