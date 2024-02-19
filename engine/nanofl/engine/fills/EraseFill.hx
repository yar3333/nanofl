package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;
import stdlib.Debug;

class EraseFill extends BaseFill implements IFill
{
	public function new() {}

    public function save(out:htmlparser.XmlBuilder) Debug.methodNotSupported(this);
	public function saveJson() return Debug.methodNotSupported(this);
    public function clone() : EraseFill return new EraseFill();
	public function applyAlpha(alpha:Float) Debug.methodNotSupported(this);
	public function getTyped() : TypedFill return Debug.methodNotSupported(this);
	public function begin(g:ShapeRender) Debug.methodNotSupported(this);
	public function equ(e:IFill) return Std.isOfType(e, EraseFill);
	public function swapInstance(oldNamePath:String, newNamePath:String) Debug.methodNotSupported(this);
	public function setLibrary(library:Library) {}
	public function getTransformed(m:Matrix) : IFill return clone();
	public function toString() return "new EraseFill";
}
