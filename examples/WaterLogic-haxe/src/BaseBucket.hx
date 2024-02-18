import nanofl.MovieClip;

class BaseBucket
{
	public var total(default, null) : Int;
	public var fill(default, null) = 0;
	public var mc(default, null) : MovieClip;
	
	public function new(total:Int, mc:MovieClip) 
	{
		this.total = total;
		this.mc = mc;
	}
	
	public function setFill(v:Int) : Void { }
	
	public function getNeckPos() : createjs.Point return new createjs.Point(mc.x, mc.y);
}