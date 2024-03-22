package nanofl.ide.undo.states;

import nanofl.engine.MeshParams;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.geom.Matrix;

class TransformationState
{
	var matrix : Matrix;
    var meshParams : MeshParams;
    var videoCurrentTime : Float;
	
	public function new(matrix:Matrix, meshParams:MeshParams, videoCurrentTime:Float)
	{
		this.matrix = matrix;
		this.meshParams = meshParams;
		this.videoCurrentTime = videoCurrentTime;
	}
	
	public function equ(state:TransformationState) : Bool
	{
		return state.matrix.equ(matrix) 
            && MeshParamsTools.equ(state.meshParams, meshParams)
            && state.videoCurrentTime == videoCurrentTime;
	}
	
	public static function fromElement(element:Element) : TransformationState
	{
		return new TransformationState
        (
            element.matrix.clone(),
            Std.isOfType(element, Instance) ? MeshParamsTools.clone((cast element:Instance).meshParams) : null,
            Std.isOfType(element, Instance) ? (cast element:Instance).videoCurrentTime : null,
        );
	}
	
	public function toElement(element:Element) : Void
	{
		element.matrix = matrix.clone();
		if (Std.is(element, Instance))
        {
            (cast element:Instance).meshParams = MeshParamsTools.clone(meshParams);
            (cast element:Instance).videoCurrentTime = videoCurrentTime;
        }
    }
}