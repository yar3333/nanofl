package nanofl.ide.navigator;

import nanofl.engine.IPathElement;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.IIdeTimeline;
import stdlib.Debug;
using nanofl.engine.LayersTools;

class PathItem
{
	public var element : IPathElement;
	
	public var layerIndex(default, null) : Int;
	public var frameIndex(default, null) : Int;
	
	public var layer(get, never) : Layer;
	function get_layer() : Layer return element.layers[layerIndex];
	
	public var frame(get, never) : Frame;
	function get_frame() : Frame return layerIndex < element.layers.length ? element.layers[layerIndex].getFrame(frameIndex) : null;
	
    public function new(element:IPathElement, layerIndex=0, frameIndex=0)
	{
		this.element = element;
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
    public function isScene() return element.isScene();
    
    public function equ(p:PathItem) : Bool
    {
        return p.element == element
            && p.layerIndex == layerIndex
            && p.frameIndex == frameIndex;
    }
    
    public function getTimeline() : IIdeTimeline return cast element.getTimeline();
	
	public function clone() : PathItem
	{
		return new PathItem(element, layerIndex, frameIndex);
	}
}
