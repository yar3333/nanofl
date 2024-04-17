package nanofl.ide.navigator;

import haxe.io.Path;
import stdlib.Debug;
import nanofl.engine.Library;
import nanofl.engine.elements.Instance;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.libraryitems.MovieClipItem;

class PathItem
{
	public final instance : Instance;
    public final mcItem : MovieClipItem;
	
	public var layerIndex(default, null) : Int;
	public var frameIndex(default, null) : Int;
	
	public var layer(get, never) : Layer;
	function get_layer() : Layer return mcItem.layers[layerIndex];
	
	public var frame(get, never) : Frame;
	function get_frame() : Frame return layerIndex < mcItem.layers.length ? mcItem.layers[layerIndex].getFrame(frameIndex) : null;

    public function new(instance:Instance, layerIndex=0, frameIndex=0)
	{
        Debug.assert(Std.isOfType(instance.symbol, MovieClipItem));

		this.instance = instance;
        this.mcItem = cast instance.symbol;
		this.layerIndex = layerIndex;
		this.frameIndex = frameIndex;
	}

	public function setLayerIndex(n:Int)
    {
        Debug.assert(n != null);
        Debug.assert(n >= 0);
        Debug.assert(n < mcItem.layers.length);
        
        layerIndex = n;
    }
    
    public function setFrameIndex(n:Int)
    {
        Debug.assert(n != null);
        Debug.assert(n >= 0);
        Debug.assert(n < getTotalFrames());
        
        frameIndex = n;
    }
    
	public function getNavigatorIcon() return mcItem.getIcon();    
	public function getNavigatorName() return mcItem.isGroup() ? "group" : Path.withoutDirectory(mcItem.namePath);
    public function isScene() return mcItem.namePath == Library.SCENE_NAME_PATH;
    
    public function equ(p:PathItem) : Bool
    {
        return p.instance == instance
            && p.layerIndex == layerIndex
            && p.frameIndex == frameIndex;
    }
    
    public function getTotalFrames() return mcItem.getTotalFrames();
	
	public function clone() : PathItem
	{
		return new PathItem(instance, layerIndex, frameIndex);
	}
}
