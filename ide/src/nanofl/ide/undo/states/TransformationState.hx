package nanofl.ide.undo.states;

import datatools.NullTools;
import nanofl.engine.elements.Instance;
import nanofl.engine.MeshParams;
import nanofl.engine.elements.Element;
import nanofl.engine.geom.Matrix;

class TransformationState
{
	var matrix : Matrix;
    var meshParams : MeshParams;
	
	public function new(matrix:Matrix, meshParams:MeshParams)
	{
		this.matrix = matrix;
		this.meshParams = meshParams;
	}
	
	public function equ(state:TransformationState) : Bool
	{
		return state.matrix.equ(matrix) && MeshParamsTools.equ(state.meshParams, meshParams);
	}
	
	public static function fromElement(element:Element) : TransformationState
	{
		return new TransformationState
        (
            element.matrix.clone(),
            Std.isOfType(element, Instance) ? MeshParamsTools.clone((cast element:Instance).meshParams) : null
        );
	}
	
	public function toElement(element:Element) : Void
	{
		element.matrix = matrix.clone();
		if (Std.is(element, Instance))
        {
            (cast element:Instance).meshParams = MeshParamsTools.clone(meshParams);
        }
    }
}