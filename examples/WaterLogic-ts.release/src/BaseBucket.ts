export class BaseBucket
{
	total : number;
	fill = 0;
	mc : nanofl.MovieClip;
	
	public constructor(total:number, mc:nanofl.MovieClip) 
	{
		this.total = total;
		this.mc = mc;
	}
	
	public setFill(v:number) : void {}
	
	public getNeckPos() : createjs.Point { return new createjs.Point(this.mc.x, this.mc.y); }
}