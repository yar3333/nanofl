package flashimport;

import nanofl.engine.geom.Matrix;

class MatrixMap<T>
{
	var kk = new Array<Matrix>();
	var values = new Array<T>();
	
	public function new() {}
	
	public function exists(key:Matrix) : Bool
	{
		for (k in kk)
		{
			if (k.equ(key)) return true;
		}
		return false;
	}
	
	public function set(key:Matrix, value:T) : Void
	{
		for (i in 0...kk.length)
		{
			if (kk[i].equ(key))
			{
				values[i] = value;
				return;
			}
		}
		
		kk.push(key);
		values.push(value);
	}
	
	public function get(key:Matrix) : T
	{
		for (i in 0...kk.length)
		{
			if (kk[i].equ(key))
			{
				return values[i];
			}
		}
		
		return null;
	}
	
	public function keys() : Iterator<Matrix>
	{
		return kk.iterator();
	}
}