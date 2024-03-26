package nanofl.engine.movieclip;

import datatools.ArrayRO;
import datatools.ArrayTools;
import nanofl.engine.Library;
import nanofl.engine.LayerType;
import nanofl.engine.elements.Element;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.movieclip.KeyFrame;
using stdlib.Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.engine.elements.Instance;
using htmlparser.HtmlParserTools;
#end

class Layer
{
	public var layersContainer : MovieClipItem;
	
	public var name : String;
	public var type : LayerType;
	public var visible : Bool;
	public var locked : Bool;
	public var parentIndex : Int;
	
	public var parentLayer(get, never) : Layer;
	@:noCompletion function get_parentLayer() return parentIndex != null ? layersContainer.layers[parentIndex] : null;
	
	var _keyFrames : Array<KeyFrame>;
	public var keyFrames(get, never) : ArrayRO<KeyFrame>;
	inline function get_keyFrames() return _keyFrames;

    public function new(name:String, ?type:LayerType, visible=true, locked=false, ?parentIndex:Int)
	{
		this.name = name;
		this.type = type != null ? type : LayerType.normal;
		this.visible = visible;
		this.locked = locked;
		this.parentIndex = parentIndex;
		this._keyFrames = [];
	}

	public function getTotalFrames() : Int
    {
        var r = 0;
        for (frame in keyFrames)
        {
            r += frame.duration;
        }
        return r;
    }
    
    public function getFrame(frameIndex:Int) : Frame
    {
        var indexes = getFrameIndexes(frameIndex);
        return indexes != null
            ? { keyFrame:keyFrames[indexes.keyIndex], subIndex:indexes.subIndex }
            : null;
    }
    
    function getFrameIndexes(frameIndex:Int) : { keyIndex:Int, subIndex:Int }
    {
        var start = 0;
        for (i in 0...keyFrames.length)
        {
            if (frameIndex >= start && frameIndex < start + keyFrames[i].duration)
            {
                return { keyIndex:i, subIndex:frameIndex - start };
            }
            start += keyFrames[i].duration;
        }
        return null;
    }
    
    public function addKeyFrame(keyFrame:KeyFrame)
    {
        _keyFrames.push(keyFrame);
        keyFrame.layer = (cast this:Layer);
        if (layersContainer?.library != null) keyFrame.setLibrary(layersContainer.library);
    }
    
    function insertKeyFrame(keyIndex:Int, keyFrame:KeyFrame)
    {
        _keyFrames.insert(keyIndex, keyFrame);
        keyFrame.layer = (cast this:Layer);
        if (layersContainer?.library != null) keyFrame.setLibrary(layersContainer.library);
    }
    
    public function insertFrame(frameIndex:Int)
    {
        if (keyFrames.length > 0)
        {
            var indexes = getFrameIndexes(frameIndex);
            if (indexes != null)
            {
                keyFrames[indexes.keyIndex].duration++;
            }
            else
            {
                keyFrames[keyFrames.length - 1].duration += frameIndex - getTotalFrames() + 1;
            }
        }
        else
        {
            addKeyFrame(new KeyFrame(frameIndex + 1));
        }
    }
    
    #if ide
    public function convertToKeyFrame(frameIndex:Int, blank=false) : Bool
    {
        if (keyFrames.length == 0) { addKeyFrame(new KeyFrame(frameIndex + 1)); return true; }
        
        var curFrameIndex = 0;
        for (i in 0...keyFrames.length)
        {
            var keyFrame = keyFrames[i];
            
            if (frameIndex >= curFrameIndex && frameIndex < curFrameIndex + keyFrame.duration)
            {
                if (curFrameIndex == frameIndex) return false;
                
                insertKeyFrame
                (
                    i + 1,
                    keyFrame.duplicate
                    (
                        "",
                        keyFrame.duration - (frameIndex - curFrameIndex),
                        blank ? [] : getElementsForNewKeyFrame(keyFrame, frameIndex - curFrameIndex)
                    )
                );
                
                keyFrame.duration = frameIndex - curFrameIndex;
                return true;
            }
            
            curFrameIndex += keyFrame.duration;
        }
        
        var lastKeyFrame = keyFrames[keyFrames.length - 1];
        lastKeyFrame.duration = frameIndex - curFrameIndex + lastKeyFrame.duration;
        addKeyFrame(lastKeyFrame.duplicate("", 1));
        return true;
    }

    function getElementsForNewKeyFrame(keyFrame:KeyFrame, frameSubIndex:Int)
    {
        final elements = keyFrame.getTweenedElements(frameSubIndex).map(x -> x.current);

        for (i in 0...elements.length) 
        {
            final element = elements[i];
            if (element.type.match(ElementType.instance) && (cast element : Instance).symbol.type.match(LibraryItemType.video))
            {
                elements[i] = element.clone();
                (cast elements[i] : Instance).videoCurrentTime = null;
            }
        }

        return elements;
    }
    #end
    
    public function removeFrame(frameIndex:Int) : Bool
    {
        var indexes = getFrameIndexes(frameIndex);
        if (indexes != null)
        {
            keyFrames[indexes.keyIndex].duration--;
            if (keyFrames[indexes.keyIndex].duration == 0)
            {
                _keyFrames.splice(indexes.keyIndex, 1);
            }
            return true;
        }
        return false;
    }
    
    public function getHumanType() : String
    {
        if (parentIndex != null && type == LayerType.normal)
        {
            var parent = layersContainer.layers[parentIndex];
            if (parent.type == LayerType.mask) return "masked";
            if (parent.type == LayerType.guide) return "guided";
        }
        return type.getName();
    }
    
    public function getIcon()
    {
        return switch (type)
        {
            case LayerType.normal: "custom-icon-page-blank";
            case LayerType.mask: "custom-icon-mask";
            case LayerType.folder: "custom-icon-folder-close";
            case LayerType.guide: "custom-icon-layer-guide";
        };
    }
    
    #if ide
    public function getNestLevel() : Int
    {
        var r = 0;
        var layer = this;
        while (layer.parentIndex != null)
        {
            r++;
            layer = layersContainer.layers[layer.parentIndex];
        }
        return r;
    }
    #end
    
    public function getChildLayers() : Array<Layer>
    {
        var index = getIndex();
        return layersContainer.layers.filter(layer -> layer.parentIndex == index);
    }
    
    public function getTweenedElements(frameIndex:Int) : Array<TweenedElement>
    {
        #if ide
        if (!visible) return [];
        #end
            
        final frame = getFrame(frameIndex);
        return frame?.keyFrame.getTweenedElements(frame.subIndex) ?? [];
    }
    
    #if ide
    public static function load(xml:HtmlNodeElement, version:String) : Layer
    {
        final r = new Layer("");
        r.loadProperties(xml, version);
        return r;
    }

    function loadProperties(node:HtmlNodeElement, version:String) : Void
    {
        name = node.getAttr("name", "");
        type = Type.createEnum(LayerType, node.getAttr("type", "normal"));
        visible = node.getAttr("visible", true);
        locked = node.getAttr("locked", false);
        parentIndex = node.getAttrInt("parentIndex");
        
        for (frameNode in node.children)
        {
            if (frameNode.name == "frame")
            {
                addKeyFrame(KeyFrame.parse(frameNode, version));
            }
        }
    }
    #end

    public static function loadJson(obj:Dynamic, version:String) : Layer
    {
        final r = new Layer("");
        r.loadPropertiesJson(obj, version);
        return r;
    }
    
    function loadPropertiesJson(obj:Dynamic, version:String) : Void
    {
        name = obj.name ?? "";
        type = LayerType.createByName(obj.type ?? "normal");
        visible = obj.visible ?? true;
        locked = obj.locked ?? false;
        parentIndex = obj.parentIndex;

        for (kf in (cast obj.keyFrames : Array<Dynamic>))
        {
            addKeyFrame(KeyFrame.parseJson(kf, version));
        }
    }
        
    #if ide
    public function save(out:XmlBuilder)
    {
        out.begin("layer")
            .attr("name", name, "")
            .attr("type", type.getName(), "normal")
            .attr("visible", visible, true)
            .attr("locked", locked, false)
            .attr("parentIndex", parentIndex);
        for (keyFrame in keyFrames)
        {
            keyFrame.save(out);
        }
        out.end();
    }
        
    public function saveJson() : Dynamic
    {
        return 
        {
            name: name ?? "",
            type: (type ?? normal).getName(),
            visible: visible ?? true,
            locked: locked ?? false,
            parentIndex: parentIndex,
            keyFrames: keyFrames.map(x -> x.saveJson()),
        };
    }
    #end
    
    public function clone() : Layer
    {
        return duplicate(keyFrames, parentIndex);
    }
    
    public function duplicate(keyFrames:ArrayRO<KeyFrame>, parentIndex:Int) : Layer
    {
        var r = new Layer(name, type, visible, locked, parentIndex);
        for (keyFrame in keyFrames) r.addKeyFrame(keyFrame.clone());
        return r;
    }
    
    public function getIndex() : Int return layersContainer.layers.indexOf((cast this:Layer));
    
    public function setLibrary(library:Library)
    {
        for (keyFrame in keyFrames) keyFrame.setLibrary(library);
    }
    
    public function equ(layer:Layer) : Bool
    {
        if (layer.name != name) return false;
        if (layer.type != type) return false;
        if (layer.visible != visible) return false;
        if (layer.locked != locked) return false;
        if (!ArrayTools.equ(layer._keyFrames, _keyFrames)) return false;
        return true;
    }

    public static function createWithOneFrame(elements:Array<Element>) : Layer
    {
        final r = new Layer("");
        r.addKeyFrame(new KeyFrame("", 1, null, elements));
        return r;
    }
    
    public function toString() return (layersContainer != null ? layersContainer.toString() + " / " : "") + "layer";
}