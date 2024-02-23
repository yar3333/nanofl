import { base } from './autogen';
import { IWaterContainer } from './IWaterContainer';
import { Sounds } from './autogen';


export class McBucket extends base.McBucket
    implements IWaterContainer
{

	private fallProcessPhase = 0;	// 0 - nothing to do
			    				    // 1 - moving to preffered position
				    			    // 2 - rotation forward
					    		    // 3 - waiting water to fall out
						        	// 4 - rotation backward
							        // 5 - moving to mouse position
	
    private fillProcessDest : IWaterContainer = null;
	
    private fillProcessFallFrame = 0;

    private fill = 0;
    
    readonly total : number;
	
	public constructor(total:number, x:number)
	{
		super();

        this.total = total;
		
		this.x = x;
		this.y = 345;
		
		this.scaleX = this.scaleY = Math.sqrt(total) * 40 / 100;
		
		this.setFill(0);
		
		this.activate(false);
	}
	
    public getFill() { return this.fill }
	
    public setFill(v:number)
	{
		this.fill = v;
		this.tfLabel.text = this.fill + "/" + this.total;
		this.gotoAndStop(Math.round(this.fill / this.total * 100));
	}
	
	public getNeckPos() : createjs.Point
	{
		return new createjs.Point(this.x + this.mcNeck.x * this.scaleX, this.y + this.mcNeck.y * this.scaleY);
	}
	
	public activate(act:boolean)
	{
		this.mcForeColor.visible = act;
	}
	
	fallToBucket(dest:McBucket)
	{
		var freeDest = dest.total - dest.fill;
		if (freeDest > this.fill)
		{
			dest.setFill(dest.fill + this.fill);
			this.setFill(0);
		}
		else
		{
			dest.setFill(dest.total);
			this.setFill(this.fill - freeDest);
		}
	}
	
	// начинает анимированный процесс переливание из текущей бутыли в заданную
	public startFallToBucketProcess(dest:IWaterContainer)
	{
		if (this.fallProcessPhase != 0) { console.log("StartFallProcess error 1"); return; }

		this.fallProcessPhase = 1;
		this.fillProcessDest = dest;
		this.fillProcessFallFrame = 0;
	}
	
	// должна вызываться на каждом кадре, пока процесс переливания идёт
	// (если будет вызвана когда процесс уже закончен - ничего страшного)
	// возвращает - закончен ли процесс переливания
	// mouseDX, mouseDY - смещение для последней фазы
	public fallProcessStep(mouseDX:number, mouseDY:number) : boolean
	{
		if (this.fallProcessPhase == 0) return true;
		if (this.fallProcessPhase == 1)
		{
			var destNeck = this.fillProcessDest.getNeckPos();
			var b = this.mcBox.getBounds();
			var mustPos = new createjs.Point(destNeck.x + b.height * this.scaleY, destNeck.y);
			if (this.moveStepTo(mustPos, 6)) this.fallProcessPhase++;
		}
		else
		if (this.fallProcessPhase == 2)
		{
			if (this.fill == 0 || this.fillProcessDest.getFill() == this.fillProcessDest.total) this.fallProcessPhase++;
			else
			{
				if (this.rotation > -90) this.rotation -= 4;
				else this.fallProcessPhase++;
			}
		}
		else
		if (this.fallProcessPhase == 3)
		{
			if (this.fill == 0 || this.fillProcessDest.getFill() == this.fillProcessDest.total) this.fallProcessPhase++;
		}
		else
		if (this.fallProcessPhase == 4)
		{
			if (this.rotation < 0) this.rotation += 4;
			else this.fallProcessPhase++;
		}
		else
		if (this.fallProcessPhase == 5)
		{
			var r = this.moveStepTo(new createjs.Point(this.stage.mouseX + mouseDX, this.stage.mouseY + mouseDY), 10);
			if (r == true) this.fallProcessPhase = 0;
			return r;
		}
		
		if ((this.fallProcessPhase == 2 && this.rotation<-40) || this.fallProcessPhase == 3)
		{
			this.fillProcessFallFrame++;
			if (this.fillProcessFallFrame % 7 == 6)
			{
				if (this.fill > 0 && this.fillProcessDest.getFill() < this.fillProcessDest.total)
				{
					this.setFill(this.fill - 1);
					this.fillProcessDest.setFill(this.fillProcessDest.getFill() + 1);
					Sounds.water();
				}
			}
		}
		
		return false;
	}
	
	public moveStepTo(dest:createjs.Point, step:number) : boolean
	{
		var dx = dest.x - this.x;
		var dy = dest.y - this.y;
		var len = Math.sqrt(dx * dx + dy * dy);
		if (len < step)
		{
			this.x = dest.x;
			this.y = dest.y;
			return true;
		}
		else
		{
			this.x += dx / len * step;
			this.y += dy / len * step;
			return false;
		}
	}
}