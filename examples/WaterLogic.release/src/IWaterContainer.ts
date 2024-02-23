export interface IWaterContainer
{
	readonly total : number;
	
    getFill() : number;
    setFill(v:number) : void;
	
	getNeckPos() : createjs.Point;
}