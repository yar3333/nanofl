export class WaterContainer
{
	readonly total : number;
	readonly mc : nanofl.MovieClip;
    
    fill = 0;
	
	constructor(total:number, mc:nanofl.MovieClip) 
	{
		this.total = total;
		this.mc = mc;
	}
	
	setFill(v:number) : void {}
	
	getNeckPos() : createjs.Point { return new createjs.Point(this.mc.x, this.mc.y); }
}