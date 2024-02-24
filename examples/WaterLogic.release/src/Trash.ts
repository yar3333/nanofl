import { base } from './autogenerated';
import { IWaterContainer } from './IWaterContainer';

export class Trash extends base.Trash
    implements IWaterContainer
{
    readonly total = 100000;

    getFill() { return 0 }
    setFill(v:number) {}

    getNeckPos() : createjs.Point { return new createjs.Point(this.x, this.y); }
}