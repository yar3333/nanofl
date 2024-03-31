package components.nanofl.movie.timeline;

import nanofl.ide.draganddrop.DragDataType;
import js.JQuery;
import js.Browser;
import stdlib.ExceptionTools;
import wquery.ComponentList;
import htmlparser.XmlBuilder;
import htmlparser.XmlNodeElement;
import nanofl.engine.Log.console;
import nanofl.engine.ElementType;
import nanofl.engine.LayerType;
import nanofl.engine.Version;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Elements;
import nanofl.ide.Application;
import nanofl.ide.Globals;
import nanofl.ide.AsyncTicker;
import nanofl.ide.Document;
import nanofl.ide.ActiveView;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.ui.View;
import nanofl.ide.editor.Editor;
import nanofl.ide.keyboard.Keyboard;
import nanofl.ide.keyboard.ShortcutTools;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.draganddrop.AllowedDropEffect;
import nanofl.ide.timeline.ITimelineView;
import nanofl.ide.timeline.droppers.LayerToHeaderTitleDropProcessor;
import nanofl.ide.timeline.droppers.LayerToLayerDropProcessor;
import nanofl.ide.timeline.droppers.LayerToTitleDropProcessor;
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

    static final XML_LAYERS_TAG = "layers";
	
	@inject var dragAndDrop : DragAndDrop;
	@inject var keyboard : Keyboard;
	@inject var app : Application;
	@inject var view : View;
	@inject var preferences : Preferences;

    var document(get, never) : Document; @:noCompletion function get_document() return app.document;
    var editor(get, never) : Editor; @:noCompletion function get_editor() return document?.editor;
    var navigator(get, never) : Navigator; @:noCompletion function get_navigator() return document?.navigator;
    var pathItem(get, never) : PathItem; @:noCompletion function get_pathItem() return navigator?.pathItem;
	
	var layerComponents : ComponentList<components.nanofl.movie.timelinelayer.Code>;
	
	var editable(get, never) : Bool; @:noCompletion function get_editable() return !pathItem.mcItem.isGroup();
    
	function getLayerNodes() : JQuery return template().content.find(">div");
	function getLayerNodeByIndex(n:Int) : JQuery return template().content.find(">div:nth-child(" + (n + 1) + ")");
	function getLayerNodeByFrameNode(elem:JQuery) : JQuery return elem.parent().parent().parent();
	function getLayerFramesContainerByIndex(n:Int) : JQuery return layerComponents.getByIndex(n).q("#framesContent");
	
	function getFrameNodes(filter="") : JQuery return template().content.find(">div>.frames-content>*>*" + filter);
	function getFrameNodesByLayerIndex(n:Int, filter="") : JQuery return template().content.find(">div:nth-child(" + (n + 1) + ")>.frames-content>*>*" + filter);
	function getFrameNodesByLayer(elem:JQuery, filter="") : JQuery return elem.find(">.frames-content>*>*" + filter);
	
	function getLayerByLayerNode(elem:JQuery) : Layer return pathItem.mcItem.layers[elem.index()];
	
	var mouseDownOnHeader : Bool;
	var mouseDownOnFrame : JQuery;
	
	var playTimer : AsyncTicker;
	var playStartFrameIndex : Int;
	
	var freeze = false;
	
	public function init()
	{
		Globals.injector.injectInto(this);
		
		layerComponents = new ComponentList<components.nanofl.movie.timelinelayer.Code>(components.nanofl.movie.timelinelayer.Code, this, template().content);
		
		template().layerContextMenu.build
        (
            template().container,
            "#" + template().content[0].id + ">*",
            preferences.storage.getMenu("layerContextMenu"),
            beforeShowLayerContextMenu
        );
		
        template().frameContextMenu.build
        (
            template().content,
            ">*>.frames-content>*>*",
            preferences.storage.getMenu("frameContextMenu"),
            beforeShowFrameContextMenu
        );
		
        q(js.Browser.document).mouseup(e ->
		{
			if (e.which == 1)
			{
				mouseDownOnHeader = false;
				mouseDownOnFrame = null;
			}
		});
		
		q(js.Browser.document).on("mousedown", _ ->
		{
			if (pathItem != null && pathItem.frameIndex != playStartFrameIndex) stop();
		});

		q(js.Browser.document).on("keydown", (e:JqEvent) ->
		{
            final playShortcut = keyboard.keymap.find(x -> x.command == "timeline.play")?.shortcut;
            if (ShortcutTools.toString(e) == playShortcut) return;
			
            if (pathItem != null && pathItem.frameIndex != playStartFrameIndex) stop();
		});

		template().content .on("mousedown", e -> app.setActiveView(ActiveView.TIMELINE, e));
		template().controls.on("mousedown", e -> app.setActiveView(ActiveView.TIMELINE, e));

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
			api.droppable(template().headerTitle, new LayerToHeaderTitleDropProcessor());
			api.droppable(template().content, new LayerToLayerDropProcessor(template().content));
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
			navigator.setFrameIndex(Math.ceil(template().hScrollbar.position / FRAME_WIDTH));
		}
		else
		if (dx > 0)
		{
			navigator.setFrameIndex(Math.floor((template().hScrollbar.position + getVisibleFramesWidth()) / FRAME_WIDTH) - 1);
		}
	}
	
	function beforeShowLayerContextMenu(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, layerElem:JQuery)
	{
		if (!editable) return false;
		
		deselectAllFrames();
		deselectAllLayers();
		layerElem.addClass("selected");
		
		final indexes = getSelectedLayerIndexes();
		Debug.assert(indexes.length == 1);
		
		final index = indexes[0];
		final layer = pathItem.mcItem.layers[index];
		
		if (layer.type == LayerType.folder)
		{
			e.preventDefault();
			return false;
		}
		
		freezed(() -> navigator.setLayerIndex(index));
		
		final parentIndex = getPotentialParentLayerIndex(index);
		final parentLayerType = parentIndex != null ? pathItem.mcItem.layers[parentIndex].type : null;
		final humanType = layer.getHumanType();
		
		menu.toggleItem("timeline.switchLayerTypeToMask",	humanType != "masked" && humanType != "guided");
		menu.toggleItem("timeline.switchLayerTypeToGuide",	humanType != "masked" && humanType != "guided");
		menu.toggleItem("timeline.switchLayerTypeToMasked",	parentLayerType == LayerType.mask);
		menu.toggleItem("timeline.switchLayerTypeToGuided",	parentLayerType == LayerType.guide);
		
		menu.getAllItems().removeClass("checked");
		menu.getItem("timeline.switchLayerTypeTo" + layer.getHumanType().capitalize()).addClass("checked");
		
		return true;
	}
	
	function beforeShowFrameContextMenu(menu:nanofl.ide.ui.menu.ContextMenu, e:JqEvent, frameNode:JQuery)
	{
		if (!editable) return false;
		
		if (!frameNode.hasClass("selected"))
		{
			var layerNode = getLayerNodeByFrameNode(frameNode);
			freezed(() ->
			{
				navigator.setLayerIndex(layerNode.index());
				navigator.setFrameIndex(frameNode.index());
			});
			deselectAllFrames();
			deselectAllLayers();
			frameNode.addClass("selected");
			layerNode.addClass("selected");
			fixActiveFrame();
		}
	
		return true;
	}

    public function hasSelectedFramesWithTween()
    {
		for (frameNode in getFrameNodes(".selected"))
		{
			if  (frameNode.hasClass("tween") || frameNode.hasClass("tween-bad")) return true;
        }
        return false;
    }

    public function hasSelectedFramesWithoutTween()
    {
		for (frameNode in getFrameNodes(".selected"))
		{
			if  (!frameNode.hasClass("tween") && !frameNode.hasClass("tween-bad")) return true;
        }
        return false;
    }
	
	@:profile
	public function update()
	{
		if (freeze) return;
		
		template().controls.find("button").prop("disabled", !editable);
		template().visibleAll.add(template().lockedAll).css("visibility", editable ? "" : "hidden");
		
		layerComponents.clear();
		template().content.html("");
		
		for (i in 0...pathItem.mcItem.layers.length)
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
		var fromLayerIndex = Std.min(layerIndex, pathItem.layerIndex);
		var fromFrameIndex = Std.min(frameIndex, pathItem.frameIndex);
		var toLayerIndex = Std.max(layerIndex, pathItem.layerIndex);
		var toFrameIndex = Std.max(frameIndex, pathItem.frameIndex);
		
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
		beginTransaction();
		
		var hasSelectedFrames = false;
		iterateSelectedFramesReversed(function(e)
		{
			hasSelectedFrames = true;
			e.layer.insertFrame(e.frameIndex);
		});
		
		if (!hasSelectedFrames)
		{
			for (layer in pathItem.mcItem.layers)
			{
				layer.insertFrame(pathItem.frameIndex);
			}
		}
		
		updateFrames();
		updateActiveFrame();
        freezed(() -> editor.rebind());
		
		commitTransaction();
	}
	
	public function convertToKeyFrame()
	{
		beginTransaction();
		
		iterateSelectedFrames(e ->
		{
			e.layer.convertToKeyFrame(e.frameIndex);
		});
		
		updateFrames();
		updateActiveFrame();
        freezed(() -> editor.rebind());
		
		commitTransaction();
	}
	
	public function addBlankKeyFrame()
	{
		beginTransaction();
		
		var wantToChangeFrameIndexTo = null;
		
		iterateSelectedFrames(function(e)
		{
			var frame = e.layer.getFrame(e.frameIndex);
			
			if (frame.subIndex == 0)
			{
				if (e.frameIndex == e.layer.getTotalFrames() - 1)
				{
                    e.layer.addKeyFrame(new KeyFrame());
					wantToChangeFrameIndexTo = pathItem.getTotalFrames() - 1;
				}
			}
			else
			{
				e.layer.convertToKeyFrame(e.frameIndex, true);
			}
		});
		
		if (wantToChangeFrameIndexTo != null)
		{
			navigator.setFrameIndex(wantToChangeFrameIndexTo);
		}
		
		updateFrames();
		updateActiveFrame();
        freezed(() -> editor.rebind());
		
        commitTransaction();
	}
	
	public function removeSelectedFrames()
	{
		beginTransaction();
		
		var wasRemoves = false;
		
		iterateSelectedFramesReversed(e ->
		{
			e.layer.removeFrame(e.frameIndex);
			wasRemoves = true;
		});
		
		freezed(() -> navigator.setFrameIndex(Std.min(pathItem.frameIndex, pathItem.getTotalFrames() - 1)));
		
		updateFrames();
		updateActiveFrame();
        freezed(() -> editor.rebind());
		
        commitTransaction();
	}
	
	@:profile
	function createLayer(layerIndex:Int)
	{
		final layer = pathItem.mcItem.layers[layerIndex];
		
		final t = layerComponents.create
		({
			  title: htmlEscape(layer.name != "" ? layer.name : " ")
			, iconCssClass: layer.getIcon()
			, layerCssClass: " subLayer" + layer.getNestLevel() + " layer-type-" + layer.type + (layerIndex == pathItem.layerIndex ? " active" : "")
			, layerLockedCssClass: editable ? (layer.locked ? "icon-lock" : "custom-icon-point") : "custom-icon-empty"
			, layerVisibleCssClass: editable ? (layer.visible ? "custom-icon-point" : "custom-icon-remove") : "custom-icon-empty"
		});
		
		t.event_iconClick.on(onIconClick.bind(t, _));
		t.event_titleClick.on(onIconClick.bind(t, _));
		t.event_editedClick.on(onIconClick.bind(t, _));
		t.event_visibleClick.on(onVisibleClick.bind(t, _));
		t.event_lockedClick.on(onLockedClick.bind(t, _));
		
		Debug.assert(layerComponents.getByIndex(layerIndex) == t);
		
		if (editable)
		{
			final title = t.q("#title");
			
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
					beginTransaction();
					layer.name = value;
					jq.html(htmlEscape(value != "" ? value : " "));
					commitTransaction();
				},
				cssClass: "inPlaceEdit"
			});
			
			dragAndDrop.ready.then(api ->
			{
				api.draggable(title, null, (e:JqEvent) ->
				{
                    final xml = new XmlBuilder();
					layer.save(xml);
                    return
                    { 
                        effect: AllowedDropEffect.move,
                        type: DragDataType.LAYER,
                        params: { text:layer.name, icon:layer.getIcon(), layerIndex:layerIndex },
                        data: xml.toString(),
                    };
				});
				
				api.droppable(title, new LayerToTitleDropProcessor(t.q("#layerRow")));
			});
		}
		
		updateLayerFrames(layerIndex, false);
	}
	
	function addLayer_click(_)
	{
		beginTransaction();
		
		final layer = new Layer("Layer " + pathItem.mcItem.layers.length);
		layer.addKeyFrame(new KeyFrame());
		
		final prevLayer = pathItem.layerIndex != null && pathItem.layerIndex >= 0 && pathItem.layerIndex < pathItem.mcItem.layers.length
					  ? pathItem.mcItem.layers[pathItem.layerIndex]
					  : null;
		pathItem.mcItem.addLayersBlock([ layer ], pathItem.layerIndex);
		if (prevLayer?.parentIndex != null) layer.parentIndex = prevLayer.parentIndex;
		
        update();
		
		freezed(() -> editor.rebind());
		
		commitTransaction();
	}
	
	function addFolder_click(e)
	{
		beginTransaction();
		
		var n = pathItem.layerIndex;
		while (n != null && n >= 0 && n < pathItem.mcItem.layers.length && pathItem.mcItem.layers[n].parentIndex != null) n++;
		
		pathItem.mcItem.addLayersBlock([ new Layer("TLLayer " + pathItem.mcItem.layers.length, LayerType.folder) ], n);
		
		update();
		
		commitTransaction();
	}
	
	function removeLayer_click(e)
	{
		beginTransaction();
		
		final layerNodes = getLayerNodes();
		
		var i = layerNodes.length - 1;
		while (i >= 0)
		{
			if (layerNodes[i].hasClass("selected"))
			{
				pathItem.mcItem.removeLayer(i);
			}
			i--;
		}

        if (pathItem.mcItem.layers.length == 0)
        {
            pathItem.mcItem.addLayer(new Layer("Layer 1"));
        }
		
		if (pathItem.layerIndex >= pathItem.mcItem.layers.length)
		{
			navigator.setLayerIndex(Std.max(0, pathItem.mcItem.layers.length - 1));
		}
		
		update();
		
		freezed(() -> editor.rebind());
		
		commitTransaction();
	}
	
	@:profile
	public function updateHeader()
	{
		final displayFrameCount = pathItem.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
		
		if (template().framesHeader.children().length != displayFrameCount)
		{
			var framesHeader = "";
			var framesBorder = "";
			for (i in 0...displayFrameCount)
			{
				final active = i == pathItem.frameIndex ? " class='active'" : "";
				framesHeader += "<span" + active + ">" + (i % 5 == 0 ? Std.string(i) : "&nbsp;") + "</span>";
				framesBorder += "<span" + active + ">&nbsp;</span>";
			}
			template().framesHeader.html(framesHeader);
			template().framesBorder.html(framesBorder);
		}
	}
	
	function onIconClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		final layerNode = t.q("#layerRow");
		final type = getLayerByLayerNode(layerNode).type;
		final layerIndex = layerNode.index();
		
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
					navigator.setLayerIndex(layerNode.index());
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
			for (i in Std.min(pathItem.layerIndex, layerIndex)...(Std.max(pathItem.layerIndex, layerIndex) + 1))
			{
				getFrameNodesByLayerIndex(i, ".frame").addClass("selected");
				getLayerNodeByIndex(i).addClass("selected");
			}
			if (type != LayerType.folder)
			{
				navigator.setLayerIndex(layerIndex);
			}
		}
		else
		{
			deselectAllLayers();
			deselectAllFrames();
			getFrameNodesByLayer(layerNode, ".frame").addClass("selected");
			if (type != LayerType.folder)
			{
				navigator.setLayerIndex(layerIndex);
			}
			else
			{
				layerNode.addClass("selected");
			}
		}
		
		freezed(() -> editor.selectLayers(getSelectedLayerIndexes()));
	}
	
	function onVisibleClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		if (!editable) return;
		
		final layerData = getLayerByLayerNode(t.q("#layerRow"));
		q(e.currentTarget).find(">i").attr("class", !layerData.visible ? "custom-icon-point" : "custom-icon-remove");
		layerData.visible = !layerData.visible;
		
		editor.rebind();
	}
	
	function onLockedClick(t:components.nanofl.movie.timelinelayer.Code, e:JqEvent)
	{
		if (!editable) return;
		
		final layerData = getLayerByLayerNode(t.q("#layerRow"));
		q(e.currentTarget).find(">i").attr("class", layerData.locked ? "custom-icon-point" : "icon-lock");
		layerData.locked = !layerData.locked;
		
		editor.rebind();
	}
	
	@:profile
	public function fixActiveFrame()
	{
		if (freeze) return;
		
		for (layerNode in getLayerNodes())
		{
			final frameNodes = getFrameNodesByLayer(layerNode);
			frameNodes.removeClass("active");
			frameNodes[pathItem.frameIndex].addClass("active");
		}
		
		final headerFrames = template().framesHeader.children();
		headerFrames.removeClass("active");
		headerFrames[pathItem.frameIndex].addClass("active");
		
		final borderFrames = template().framesBorder.children();
		borderFrames.removeClass("active");
		borderFrames[pathItem.frameIndex].addClass("active");
	}
	
	@:profile
	public function fixActiveLayer()
	{
		if (freeze) return;
		
		final layerNodes = getLayerNodes();
		layerNodes.removeClass("active");
		if (pathItem.layerIndex != null)
		{
			q(layerNodes[pathItem.layerIndex]).addClass("selected active");
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
		
		updateLayerFrames(pathItem.layerIndex, true);
	}
	
	@:profile
	public function updateActiveFrame()
	{
		if (freeze) return;
		
		for (i in 0...pathItem.mcItem.layers.length)
		{
			var frameNode = getFrameNodesByLayerIndex(i, ":nth-child(" + (pathItem.frameIndex + 1) + ")");
			updateFrame(pathItem.frameIndex, frameNode[0], getFrameCssClasses(i, pathItem.frameIndex), true);
		}
	}
	
	public function updateFrames(isUpdateHeader=true)
	{
		if (isUpdateHeader) updateHeader();
		for (i in 0...pathItem.mcItem.layers.length) updateLayerFrames(i, true);
		updateScrolls();
	}
	
	@:profile
	function updateLayerFrames(layerIndex:Int, keepSelection:Bool)
	{
		if (layerIndex >= pathItem.mcItem.layers.length) return;
		
		var displayedFrameCount = pathItem.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
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
		
		var displayedFrameCount = pathItem.getTotalFrames() + ADDITIONAL_FRAMES_TO_DISPLAY;
		
		for (keyFrame in pathItem.mcItem.layers[layerIndex].keyFrames)
		{
			var base = "frame";
			if (!keyFrame.isEmpty()) base += " frame-notEmpty";
			if (keyFrame.hasMotionTween()) base += keyFrame.hasGoodMotionTween() ? " tween" : " tween-bad";
			r.push(base + " startKeyFrame" + (keyFrame.duration == 1 ? " finishKeyFrame" : "") + (keyFrame.label != "" ? " frame-label" : ""));
			for (i in 1...(keyFrame.duration - 1)) r.push(base);
			if (keyFrame.duration > 1) r.push(base + " finishKeyFrame");
		}
		
		if (layerIndex + 1 < pathItem.mcItem.layers.length)
		{
			for (i in r.length...pathItem.mcItem.layers[layerIndex + 1].getTotalFrames())
			{
				r.push("nextLayerFrame");
			}
		}
		
		while (r.length < displayedFrameCount) r.push("");
		
		return r;
	}
	
	function getFrameCssClasses(layerIndex:Int, frameIndex:Int) : String
	{
		var frame = pathItem.mcItem.layers[layerIndex].getFrame(frameIndex);
		
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
		
		if (layerIndex < pathItem.mcItem.layers.length - 1)
		{
			final nextLayerFramesCount = pathItem.mcItem.layers[layerIndex + 1].getTotalFrames();
			if (frameIndex < nextLayerFramesCount) return "nextLayerFrame";
		}
		
		return "";
	}
	
	function updateFrame(frameIndex:Int, frameElement:js.html.Element, cssClasses:String, keepSelection:Bool)
	{
		final selected = keepSelection && frameElement.hasClass("selected") ? " selected" : "";
		final active = frameIndex == pathItem.frameIndex ? " active" : "";
		frameElement.setAttribute("class", cssClasses + selected + active);
	}
	
	@:profile
	public function selectLayerFrames(layerIndexes:Array<Int>)
	{
		if (freeze) return;
		
		final layerNodes = getLayerNodes();
		
		layerNodes.removeClass("selected");
		fixActiveLayer();
		
		for (i in 0...layerNodes.length)
		{
			final layer = layerNodes[i];
			final frameNodes = getFrameNodesByLayer(q(layer));
			frameNodes.removeClass("selected");
			if (layerIndexes.has(i)) frameNodes[pathItem.frameIndex].addClass("selected");
		}
	}
	
	public function getAciveFrame() : KeyFrame
	{
		return pathItem?.frame?.keyFrame;
	}
	
	function visibleAll_click(e)
	{
		final hasVisible = pathItem.mcItem.layers.exists(layer -> layer.visible);
		getLayerNodes().find(">.timeline-visible>i").attr("class", hasVisible ? "custom-icon-remove" : "custom-icon-point");
		
		for (layer in pathItem.mcItem.layers)
		{
			layer.visible = !hasVisible;
		}
		
		editor.rebind();
	}
	
	function lockedAll_click(e)
	{
		final hasUnlocked = pathItem.mcItem.layers.exists(layer -> !layer.locked);
		getLayerNodes().find(">.timeline-locked>i").attr("class", hasUnlocked ? "icon-lock" : "custom-icon-point");
		
		for (layer in pathItem.mcItem.layers)
		{
			layer.locked = hasUnlocked;
		}
		
		editor.rebind();
	}
	
	function onFrameMouseDown(e:JqEvent)
	{
		mouseDownOnFrame = q(e.currentTarget);
		final frameIndex = mouseDownOnFrame.index();
		
		final layerNode = getLayerNodeByFrameNode(mouseDownOnFrame);
		final layerIndex = layerNode.index();
		
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
			final startFrameIndex = mouseDownOnFrame.index();
			final startLayerIndex = getLayerNodeByFrameNode(mouseDownOnFrame).index();
			
			final frame = q(e.currentTarget);
			final frameIndex = frame.index();
			final layerIndex = getLayerNodeByFrameNode(frame).index();
			
			if (startFrameIndex != frameIndex || startLayerIndex != layerIndex)
			{
				deselectAllFrames();
				
				for (i in Std.min(startLayerIndex, layerIndex)...Std.max(startLayerIndex, layerIndex) + 1)
				{
					final frameNodes = getFrameNodesByLayerIndex(i);
					for (j in Std.min(startFrameIndex, frameIndex)...Std.max(startFrameIndex, frameIndex) + 1)
					{
						frameNodes[j].addClass("selected");
					}
				}
				
				navigator.setFrameIndex(frameIndex);
				fixActiveFrame();
			}
		}
	}
	
	function onFrameHeaderMouseDown(e:JqEvent)
	{
		mouseDownOnHeader = true;
		deselectAllFrames();

        final oldElements = editor.getElements(false);
		navigator.setFrameIndex(q(e.currentTarget).index());
        final newElements = editor.getElements(false);

        final elementsToSelect = [];
        var i = 0; while (i < oldElements.length && i < newElements.length)
        {
            if (!isElementMatch(oldElements[i].originalElement, newElements[i].originalElement)) break;
            if (oldElements[i].selected) elementsToSelect.push(newElements[i]);
            i++;
        }

        editor.deselectAll();
        for (element in elementsToSelect)
        {
            editor.select(element, false);
        }
	}
	
	function onFrameHeaderMouseMove(e:JqEvent)
	{
		if (!mouseDownOnHeader) return;
		
		deselectAllFrames();
		navigator.setFrameIndex(q(e.currentTarget).index());
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
		iterateSelectedKeyFrames(keyFrame ->
		{
			if (!keyFrame.hasMotionTween())
			{
				keyFrame.addDefaultMotionTween();
			}
		});
		
		editor.rebind();
	}
	
	public function removeTween() 
	{
		iterateSelectedKeyFrames(keyFrame ->
		{
			keyFrame.removeMotionTween();
		});
		
		editor.rebind();
	}
	
	public function hasSelectedFrames()
	{
		return getFrameNodes("selected").length > 0;
	}
	
	public function saveSelectedToXml(out:XmlBuilder) : Array<IIdeLibraryItem>
	{
		final namePaths = [];
		
		out.begin("layers");
		final layerNodes = getLayerNodes();
		for (i in 0...layerNodes.length)
		{
			final rLayer = pathItem.mcItem.layers[i].duplicate([], null);
			
			final frameNodes = getFrameNodesByLayer(q(layerNodes[i]));
			
			for (keyFrame in pathItem.mcItem.layers[i].keyFrames)
			{
				if (frameNodes[keyFrame.getIndex()].hasClass("selected"))
				{
					rLayer.addKeyFrame(keyFrame.clone());
					
					for (namePath in Elements.getUsedSymbolNamePaths(keyFrame.elements))
					{
						if (namePaths.indexOf(namePath) < 0) namePaths.push(namePath);
					}
				}
			}
			
			if (rLayer.keyFrames.length > 0)
			{
				rLayer.save(out);
			}
		}
		out.end();
		
		return namePaths.map(x -> document.library.getItem(x));
	}
	
	public function pasteFromXml(xml:XmlNodeElement) : Bool
	{
		var r = false;
		
		if (editable)
		{
			for (layersNode in xml.find(">" + XML_LAYERS_TAG))
			{
				var layerIndex = pathItem.layerIndex;
				for (layerNode in layersNode.find(">layer"))
				{
					final layer = Layer.load(layerNode, Version.document);
					
					if (layerIndex == pathItem.mcItem.layers.length)
					{
                        pathItem.mcItem.addLayer(layer);
						r = true;
					}
					else
					{
						for (keyFrame in layer.keyFrames)
						{
							pathItem.mcItem.layers[layerIndex].addKeyFrame(keyFrame.clone());
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
		final layerNodes = getLayerNodes();
		for (i in 0...layerNodes.length)
		{
			final frameNodes = getFrameNodesByLayer(q(layerNodes[i]));
			var j = 0; while (j < frameNodes.length)
			{
				if (frameNodes[j].hasClass("frame") && frameNodes[j].hasClass("selected"))
				{
					final f = pathItem.mcItem.layers[i].getFrame(j);
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
		final r = [];
		var i = 0; for (layer in getLayerNodes())
		{
			if (q(layer).hasClass("selected")) r.push(i);
			i++;
		}
		return r;
	}
	
	public function gotoPrevFrame()
	{
		if (pathItem.frameIndex > 0)
		{
			navigator.setFrameIndex(pathItem.frameIndex - 1);
		}
	}
	
	public function gotoNextFrame()
	{
		if (pathItem.frameIndex < pathItem.getTotalFrames() - 1)
		{
			navigator.setFrameIndex(pathItem.frameIndex + 1);
		}
	}
	
	public function setSelectedLayerType(humanType:String)
	{
        final layerIndexes = getSelectedLayerIndexes();
		Debug.assert(layerIndexes.length == 1);

        final layer = pathItem.mcItem.layers[layerIndexes[0]];
        if (layer.getHumanType() == humanType) return;
        
        beginTransaction();

        setLayerType(layer, humanType);
		preserveLayerSelection(() -> update());

        commitTransaction();
	}
	
	function setLayerType(layer:Layer, humanType:String)
	{
		var index = pathItem.mcItem.layers.indexOf(layer);
		
		switch (humanType)
		{
			case "normal":
				if ([ "masked", "guided" ].has(layer.getHumanType()))
				{
					var parentIndex = layer.parentIndex;
					var newParentIndex = pathItem.mcItem.layers[parentIndex].parentIndex;
					while (index < pathItem.mcItem.layers.length && pathItem.mcItem.layers[index].parentIndex == parentIndex)
					{
						pathItem.mcItem.layers[index].parentIndex = newParentIndex;
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
		var i = layerIndex - 1; while (i > 0 && pathItem.mcItem.layers[i].parentIndex != null) i--;
		if (i >= 0)
		{
			switch (pathItem.mcItem.layers[i].type)
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
		for (i in 0...pathItem.mcItem.layers.length)
		{
			if (pathItem.mcItem.layers[i].type == LayerType.folder) continue;
			
			final frameNodes = getFrameNodesByLayerIndex(i);
			for (j in 0...frameNodes.length)
			{
				if (frameNodes[j].hasClass("selected"))
				{
					callb({ layerIndex:i, frameIndex:j, layer:pathItem.mcItem.layers[i], frameNode:frameNodes[j] });
				}
			}
		}
	}
	
	function iterateSelectedFramesReversed(callb:{ layerIndex:Int, frameIndex:Int, layer:Layer, frameNode:js.html.Element }->Void)
	{
		for (i in 0...pathItem.mcItem.layers.length)
		{
			if (pathItem.mcItem.layers[i].type == LayerType.folder) continue;
			
			final frameNodes = getFrameNodesByLayerIndex(i);
			var j = frameNodes.length - 1;
			while (j >= 0)
			{
				if (frameNodes[j].hasClass("selected"))
				{
					callb({ layerIndex:i, frameIndex:j, layer:pathItem.mcItem.layers[i], frameNode:frameNodes[j] });
				}
				j--;
			}
		}
	}
	
	function preserveLayerSelection(callb:Void->Void)
	{
		final selectedLayerIndexes = getSelectedLayerIndexes();
		callb();
		selectLayersByIndexes(selectedLayerIndexes);
	}
	
	public function selectLayersByIndexes(layerIndexes:Array<Int>, replaceSelection=false)
	{
		final layerNodes = getLayerNodes();
		
		if (replaceSelection) layerNodes.removeClass("selected");
		
		for (index in layerIndexes)
		{
			layerNodes[index].addClass("selected");
		}
	}
	
	public function play()
	{
		if (playTimer != null) { stop(); return; }
		
		playStartFrameIndex = pathItem.frameIndex;
		
        var totalFrames = pathItem.getTotalFrames();
		
		playTimer = new AsyncTicker(document.properties.framerate, () ->
		{
            final nextFrameIndex = (pathItem.frameIndex + 1) % totalFrames;

            return navigator.setFrameIndex(nextFrameIndex).then(_ ->
			{
                if (pathItem.frameIndex == totalFrames - 1) stop();
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
	
	public function renameActiveLayerByUser()
	{
		if (!editable) return;
        
        if (pathItem.layerIndex < 0 || pathItem.layerIndex > layerComponents.length - 1)
        {
            console.warn("renameActiveLayerByUser: pathItem.layerIndex = " + pathItem.layerIndex + "; layerComponents.length = " + layerComponents.length);
            return;
        }

        layerComponents.getByIndex(pathItem.layerIndex).beginEditTitle();
	}
	
	function ensureActiveFrameVisible()
	{
		var posX = pathItem.frameIndex * FRAME_WIDTH;
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
		final frameNode = q(e.currentTarget);
		
		final frameIndex = frameNode.index();
		final layerNode = getLayerNodeByFrameNode(frameNode);
		final layerIndex = layerNode.index();
		
		deselectAllFrames();
		
		final layer = pathItem.mcItem.layers[layerIndex];
		if (layer.type != LayerType.folder)
		{
			final frame = layer.getFrame(frameIndex);
			
			final frameNodes = getFrameNodesByLayer(layerNode);
			final start = frame.keyFrame.getIndex();
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
			navigator.setLayerIndex(layerIndex);
			navigator.setFrameIndex(frameIndex);
			editor.selectLayers([ layerIndex ]);
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

    function isElementMatch(elemA:Element, elemB:Element)
    {
        if (elemA.type != elemB.type) return false;

        if (elemA.type == ElementType.instance)
        {
            if ((cast elemA:Instance).namePath != (cast elemB:Instance).namePath) return false;
        }

        return true;
    }

	function beginTransaction()
    {
        app.document.undoQueue.beginTransaction({ timeline:true });
    }
	
    function commitTransaction()
    {
        app.document.undoQueue.commitTransaction();
    }
}