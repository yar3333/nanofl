package nanofl.ide.navigator;

import nanofl.engine.Library;
import nanofl.engine.elements.Instance;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.libraryitems.MovieClipItem;
import stdlib.Debug;
using nanofl.engine.LayersTools;

class PathItem
{
	public final element : Instance;
    public final mcItem : MovieClipItem;
	
	public var layerIndex(default, null) : Int;
	public var frameIndex(default, null) : Int;
	
	public var layer(get, never) : Layer;
	function get_layer() : Layer return element.layers[layerIndex];
	
	public var frame(get, never) : Frame;
	function get_frame() : Frame return layerIndex < element.layers.length ? element.layers[layerIndex].getFrame(frameIndex) : null;
	
    public function new(element:Instance, layerIndex=0, frameIndex=0)
	{
        Debug.assert(Std.isOfType(element.symbol, MovieClipItem));

		this.element = element;
        this.mcItem = cast element.symbol;
		this.layerIndex = layerIndex;
		this.frameIndex = frameIndex;
	}

	public function setLayerIndex(n:Int)
    {
        Debug.assert(n != null);
        Debug.assert(n >= 0);
        Debug.assert(n < element.layers.length);
        
        layerIndex = n;
    }
    
    @:allow(nanofl.ide.navigator.Navigator2D.setFrameIndex)
    public function setFrameIndex(n:Int)
    {
        Debug.assert(n != null);
        Debug.assert(n >= 0);
        Debug.assert(n < element.getTotalFrames());
        
        frameIndex = n;
    }
    
    public function getNavigatorIcon() return element.getNavigatorIcon();
    public function getNavigatorName() return element.getNavigatorName();
    public function isScene() return element.namePath == Library.SCENE_NAME_PATH;
    
    public function equ(p:PathItem) : Bool
    {
        return p.element == element
            && p.layerIndex == layerIndex
            && p.frameIndex == frameIndex;
    }
    
    public function getTimeline() : MovieClipItem return cast element.getTimeline();
	
	public function clone() : PathItem
	{
		return new PathItem(element, layerIndex, frameIndex);
	}
}
