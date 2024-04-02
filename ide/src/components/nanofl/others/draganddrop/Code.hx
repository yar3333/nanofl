package components.nanofl.others.draganddrop;

import haxe.Json;
import js.JQuery;
import js.html.DragEvent;
import js.html.File;
import haxe.crypto.BaseCode;
import nanofl.ide.draganddrop.DragDataType;
import nanofl.ide.draganddrop.DragInfoParams;
import nanofl.ide.draganddrop.DragInfo;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDragAndDrop;
using stdlib.Lambda;
using stdlib.StringTools;

class Code extends wquery.Component
	implements IDragAndDrop
{
    static final safeEncoder = new BaseCode(haxe.io.Bytes.ofString("abcdefghijklmnopqrstuvwxyz012345"));

	var lastDragEnter : js.html.Element;
	
	/**
	 * Specify selector if you want to delegate from parent element specified by `elem`. In other case, set `selector` to null.
	 * If you use selector, then you must manualy add `draggable="true"` attribute to the draggable elements.
	 */
    public function draggable(elem:JQuery, selector:String, getInfo:(e:JqEvent)->DragInfo, ?removeMoved:DragInfo->Void) : Void
	{
		if (selector == null || selector == "") elem.attr("draggable", "true");

        var info : DragInfo = null;
		
		elem.on("dragstart", selector, (jqEvent:JqEvent) ->
		{
			log("dragstart\t" +  elemToStr(elem[0]));
			
			final e : DragEvent = jqEvent.originalEvent;

            info = getInfo(jqEvent);
            if (info?.effect == null) { e.preventDefault(); return; }

            e.dataTransfer.effectAllowed = info.effect;
            e.dataTransfer.setData(info.type + "|" + safeEncoder.encodeString(Json.stringify(info.params)), info.data);
            e.dataTransfer.setDragImage(new JQuery("<div/>")[0], 0, 0);
		});
		
		elem.on("dragend", selector, (jqEvent:JqEvent) ->
		{
            final e : DragEvent = jqEvent.originalEvent;

			if (e.dataTransfer.dropEffect == DropEffect.move)
			{
				if (removeMoved != null && info != null) removeMoved(info);
			}
		});
	}
	
	public function droppable(elem:JQuery, ?selector:String, getDragImageType:(type:DragDataType, params:DragInfoParams)->DragImageType, processDropData:(type:DragDataType, params:DragInfoParams, data:String, e:JqEvent)->Bool, ?processDropFiles:Array<File>->JqEvent->Void) : Void
	{
		function onDragEnter(e:JqEvent)
		{
			if (lastDragEnter == e.currentTarget) return;
			lastDragEnter = e.currentTarget;
			
			log("dragenter\t" + StringTools.rpad(elemToStr(e.target), " ", 35) + elemToStr(e.currentTarget));
			
			template().container.find(">*").hide();

            for (type in getTypesFromEvent(e))
            {
                final dragImageType = getDragImageType(type, getParamsFromEvent(e, type));
                if (dragImageType == null) continue;
                
                log("dragenter dragImageType = " + dragImageType);

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
                
                break;
            }
		}
		
		elem.on("dragenter", selector, e ->
		{
			log("dragenter");
			
			e.preventDefault();
			e.stopPropagation();
			onDragEnter(e);
		});
		
		elem.on("dragover", selector, e ->
		{
			log("dragover");
			
			e.preventDefault();
			e.stopPropagation();
			onDragEnter(e);
			
			template().container
				.css("left", e.originalEvent.pageX + "px")
				.css("top",  e.originalEvent.pageY + "px");
		});
		
		elem.on("dragleave", selector, e ->
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
			
			log("dragleave\t" + StringTools.rpad(elemToStr(e.target), " ", 35) + elemToStr(e.currentTarget));
			template().container.find(">*").hide();
		});
		
		elem.on("dragend", selector, e ->
		{
			log("dragend");
			
			lastDragEnter = null;
		});
		
		elem.on("drop", selector, e ->
		{
			log("drop");
			
			e.preventDefault();
			e.stopPropagation();
			
			template().container.find(">*").hide();

            for (type in getTypesFromEvent(e))
            {
                if (processDropData(type, getParamsFromEvent(e, type), getDataFromEvent(e, type), e)) break;
            }
			
			if (processDropFiles != null && (cast e.originalEvent:DragEvent).dataTransfer.files.length > 0)
			{
				processDropFiles(cast JQuery.makeArray((cast e.originalEvent:DragEvent).dataTransfer.files), e);
			}
		});
	}
	
	static function getTypesFromEvent(jqEvent:JqEvent) : Array<String>
	{
		final e : DragEvent = jqEvent.originalEvent;
        return e.dataTransfer.types.map(x ->
        {
            final n = x.indexOf("|");
            if (n < 0) return x;
            return x.substr(0, n);
        });
	}

    static function getParamsFromEvent(jqEvent:JqEvent, type:String) : DragInfoParams
    {
        final e : DragEvent = jqEvent.originalEvent;
        final key = e.dataTransfer.types.find(x -> x == type || x.startsWith(type + "|"));
        final n = key.indexOf("|");
        if (n < 0) return null;
        return Json.parse(safeEncoder.decodeString(key.substr(n + 1)));
    }

    static function getDataFromEvent(jqEvent:JqEvent, type:String) : String
    {
        final e : DragEvent = jqEvent.originalEvent;
        final key = e.dataTransfer.types.find(x -> x == type || x.startsWith(type + "|"));
        return e.dataTransfer.getData(key);        
    }
	
	static function elemToStr(elem:js.html.Element) : String
	{
		return elem.tagName + (elem.id != null ? "#" + elem.id : "");
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}