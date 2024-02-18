package components.nanofl.others.draganddrop;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import htmlparser.XmlDocument;
import js.html.DragEvent;
import js.html.File;
import nanofl.ide.draganddrop.AllowedDropEffect;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDragAndDrop;
import nanofl.ide.draganddrop.IDropArea;
import js.JQuery;

class Code
	extends wquery.Component
	implements IDragAndDrop
{
	var lastDragEnter : js.html.Element;
	
	/**
	 * Specify selector if you want to delegate from parent element specified by `elem`. In other case, set `selector` to null.
	 * If you use selector, then you must manualy add `draggable="true"` attribute to the draggable elements.
	 */
	public function draggable(elem:JQuery, selector:String, dragType:String, getData:XmlBuilder->JqEvent->AllowedDropEffect, ?removeMoved:HtmlNodeElement->Void)
	{
		if (selector == null || selector == "") elem.attr("draggable", "true");
		
		var dataXml : XmlDocument;
		
		elem.on("dragstart", selector, function(_e:JqEvent)
		{
			//log("dragstart\t" +  elemToStr(elem[0]));
			
			var e : DragEvent = _e.originalEvent;
			
			var data = new XmlBuilder();
			data.begin("drag").attr("dragType", dragType);
			e.dataTransfer.effectAllowed = getData(data, _e);
			if (e.dataTransfer.effectAllowed == null) { e.preventDefault(); return; }
			data.end();
			
			e.dataTransfer.setData("text/plain", data.toString());
			e.dataTransfer.setDragImage(new JQuery("<div/>")[0], 0, 0);
			
			dataXml = e.dataTransfer.effectAllowed == AllowedDropEffect.move 
			       || e.dataTransfer.effectAllowed == AllowedDropEffect.copyMove
					? data.xml
					: null;
		});
		
		elem.on("dragend", selector, function(e:JqEvent)
		{
			if ((cast e.originalEvent:DragEvent).dataTransfer.dropEffect == DropEffect.move)
			{
				if (removeMoved != null) removeMoved(dataXml);
			}
		});
	}
	
	public function droppable(elem:JQuery, ?selector:String, drops:Map<String, IDropArea>, ?filesDrop:Array<File>->JqEvent->Void) : Void
	{
		function onDragEnter(e:JqEvent)
		{
			if (lastDragEnter == e.currentTarget) return;
			lastDragEnter = e.currentTarget;
			
			//log("dragenter\t" + StringTools.rpad(elemToStr(e.target), " ", 35) + elemToStr(e.currentTarget));
			
			template().container.find(">*").hide();
			var xml = getDraggedXml(e);
			if (xml != null)
			{
				var dragType = xml.getAttribute("dragType");
				if (drops.exists(dragType))
				{
					//log("dragType = " + dragType);
					var drop = drops.get(dragType);
					var dragImageType = drop.getDragImageType(xml);
					if (dragImageType != null)
					{
						switch (dragImageType)
						{
							case DragImageType.ICON_TEXT(icon, text):
								template().iconText.show();
								template().icon.attr("class", icon);
								template().text.html(text);
								
							case DragImageType.RECTANGLE(width, height):
								template().rectangle
									.width(width)
									.height(height)
									.css("left", -Math.round(width  / 2) + "px")
									.css("top",  -Math.round(height / 2) + "px")
									.show();
						}
					}
				}
			}
		}
		
		elem.on("dragenter", selector, function(e:JqEvent)
		{
			log("dragenter");
			
			e.preventDefault();
			e.stopPropagation();
			onDragEnter(e);
		});
		
		elem.on("dragover", selector, function(e:JqEvent)
		{
			log("dragover");
			
			e.preventDefault();
			e.stopPropagation();
			onDragEnter(e);
			
			template().container
				.css("left", e.originalEvent.pageX + "px")
				.css("top",  e.originalEvent.pageY + "px");
		});
		
		elem.on("dragleave", selector, function(e:JqEvent)
		{
			log("dragleave");
			
			e.preventDefault();
			e.stopPropagation();
			
			if (e.relatedTarget != null)
			{
				if (JQuery.contains(e.relatedTarget, e.target)) return;
				if (JQuery.contains(e.currentTarget, e.relatedTarget)) return;
			}
			
			lastDragEnter = null;
			
			//log("dragleave\t" + StringTools.rpad(elemToStr(e.target), " ", 35) + elemToStr(e.currentTarget));
			template().container.find(">*").hide();
		});
		
		elem.on("dragend", selector, function(e:JqEvent)
		{
			log("dragend");
			
			lastDragEnter = null;
		});
		
		elem.on("drop", selector, function(e:JqEvent)
		{
			log("drop");
			
			e.preventDefault();
			e.stopPropagation();
			
			template().container.find(">*").hide();
			
			var xml = getDraggedXml(e);
			if (xml != null)
			{
				var dragType = xml.getAttribute("dragType");
				if (drops.exists(dragType))
				{
					var drop = drops.get(dragType);
					drop.drop((cast e.originalEvent:DragEvent).dataTransfer.dropEffect, xml, e);
				}
			}
			
			if (filesDrop != null && (cast e.originalEvent:DragEvent).dataTransfer.files.length > 0)
			{
				filesDrop(cast JQuery.makeArray((cast e.originalEvent:DragEvent).dataTransfer.files), e);
			}
		});
	}
	
	function getDraggedXml(e:JqEvent) : HtmlNodeElement
	{
		var e : DragEvent = e.originalEvent;
		var doc = new XmlDocument(e.dataTransfer.getData("text/plain"));
		return doc.children[0];
	}
	
	function elemToStr(elem:js.html.Element) : String
	{
		return elem.tagName + (elem.id != null ? "#" + elem.id : "");
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}