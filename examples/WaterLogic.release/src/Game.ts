import { base, Sounds } from './autogen';
//import { WaterContainer } from './IWaterContainer';
import { McBucket } from './McBucket';
import { McTrash } from './McTrash';
import { Scene } from './Scene';

export class Game extends base.Game
{
    parent: Scene; // for type cast only: createjs.Container => Scene

	level = 0;

	buckets = new Array<McBucket>();

	carry : McBucket = null;
	carryDX : number;
	carryDY : number;

	action = 0;		// what to do with "carry" if user release it
					// 0 - nothing
					// 1-4 - see gameMode
	
	fallTo : McBucket = null;
	
	gameMode = 0;	// 0 - waiting to user
					// 1 - tansfuse water from "carry" into "fallTo"
					// 2 - filling "carry" from tap
					// 3 - falling out from carry to trash
					// 4 - moving bucket to floor
	
	tapWaiting = 0;	// tick counter
	
	fillBeforeTrash = 0;
	
	init()
	{
		this.parent.stop();
		
		this.level = this.parent.level;
		
		this.parent.tfLevel.text = this.level + "";
		
		switch (this.level)
		{
			case 1:
				this.parent.tfTask.text = "You need to measure 4 litres of water,\nusing two buckets of 5 and 7 litres.\nUse barrel (at the right) for filling buckets.\nTo make buckets empty, use trash (at the left).";
				this.buckets.push(this.addChild(new McBucket(5, 220)));
				this.buckets.push(this.addChild(new McBucket(7, 320)));
                break;
			
			case 2:
				this.parent.tfTask.text = "You need to measure 1 liter of water.";
				this.buckets.push(this.addChild(new McBucket(3, 180)));
				this.buckets.push(this.addChild(new McBucket(6, 280)));
				this.buckets.push(this.addChild(new McBucket(8, 380)));
                break;
			
			case 3:
				this.parent.tfTask.text = "You need to measure 1 liter of water.";
				this.buckets.push(this.addChild(new McBucket(3, 220)));
				this.buckets.push(this.addChild(new McBucket(5, 320)));
                break;
			
			case 4:
				this.parent.tfTask.text = "You need to got 1 liter of water in any two buckets.";
				this.buckets.push(this.addChild(new McBucket(3, 180)));
				this.buckets.push(this.addChild(new McBucket(4, 280)));
				this.buckets.push(this.addChild(new McBucket(6, 380)));
                break;
			
			case 5:
				this.parent.tfTask.text = "You need to got 6 litres of water in bigger bucket,\n4 liters in 5-bucket and 4 litres in 8-bucket.";
				this.buckets.push(this.addChild(new McBucket(3, 180)));
				this.buckets.push(this.addChild(new McBucket(5, 250)));
				this.buckets.push(this.addChild(new McBucket(8, 320)));
				this.buckets.push(this.addChild(new McBucket(12, 400)));
                break;
			
			case 6:
				this.parent.tfTask.text = "You need to got 2 liter of water in any three buckets.";
				this.buckets.push(this.addChild(new McBucket(3, 180)));
				this.buckets.push(this.addChild(new McBucket(3, 250)));
				this.buckets.push(this.addChild(new McBucket(8, 320)));
				this.buckets.push(this.addChild(new McBucket(11, 400)));
                break;
			
			case 7:
				this.parent.tfTask.text = "You need to got 1 liter of water in any two buckets..";
				this.buckets.push(this.addChild(new McBucket(2, 180)));
				this.buckets.push(this.addChild(new McBucket(3, 280)));
				this.buckets.push(this.addChild(new McBucket(9, 380)));
                break;
			
			case 8:
				this.parent.tfTask.text = "You need to got 1 liter of water in small three buckets.";
				this.buckets.push(this.addChild(new McBucket( 5, 180)));
				this.buckets.push(this.addChild(new McBucket( 7, 250)));
				this.buckets.push(this.addChild(new McBucket( 9, 320)));
				this.buckets.push(this.addChild(new McBucket(11, 400)));
                break;
			
			case 9:
				this.parent.tfTask.text = "You need to fill buckets on increase:\nsmallest bust be empty, next must contain 1 liter,\nnext - 2 litres and bigger - 3 litres.";
				this.buckets.push(this.addChild(new McBucket( 7, 180)));
				this.buckets.push(this.addChild(new McBucket(11, 250)));
				this.buckets.push(this.addChild(new McBucket(13, 320)));
				this.buckets.push(this.addChild(new McBucket(17, 400)));
                break;
			
			case 10:
				this.parent.tfTask.text = "You must to got 18 litres in 19-bucket and 5 litres in 6-bucket.";
				this.buckets.push(this.addChild(new McBucket( 2, 180)));
				this.buckets.push(this.addChild(new McBucket( 6, 280)));
				this.buckets.push(this.addChild(new McBucket(19, 380)));
                break;
		}
	}
	
	onEnterFrame()
	{
		switch (this.gameMode)
		{
			case 0:
				if (this.checkWin())
                {
                    this.parent.level++;
                    this.parent.gotoAndStop("Win");
                }
                break;
				
			case 1: // transfuse water from current bucket to another
                this.fallTo.activate(false);
				if (this.carry.fallProcessStep(this.carryDX, this.carryDY))
				{
					this.gameMode = 0;
					this.selectAction();
				}
                break;
				
			case 2: // filling bucket from tap
				if (this.carry.getFill() < this.carry.total)
				{
					if (this.parent.mcTap.currentFrame != 2) this.parent.mcTap.gotoAndStop(2);
					this.tapWaiting++;
					if (this.tapWaiting % 10 == 9)
					{
						this.carry.setFill(this.carry.getFill() + 1);
						Sounds.tap();
						Sounds.water();
					}
				}
				else // bucket is full
				{
					this.parent.mcTap.gotoAndStop(0);
					
					if (this.carry.moveStepTo(new createjs.Point(this.stage.mouseX + this.carryDX, this.stage.mouseY + this.carryDY), 10))
					{
						this.tapWaiting = 0;
						this.gameMode = 0;
						this.selectAction();
					}
				}
                break;
				
			case 3: // fall out to trash
				if (this.carry.fallProcessStep(this.carryDX, this.carryDY))
				{
					this.gameMode = 0;
					this.selectAction();
				}
				else
				{
					if (this.fillBeforeTrash > 0 && this.carry.getFill() < this.fillBeforeTrash)
					{
						this.fillBeforeTrash = this.carry.getFill();
						Sounds.trash();
					}
				}
                break;
				
			case 4: // moving bucket to the ground
				if (this.carry.moveStepTo(new createjs.Point(this.carry.x, 345), 6))
				{
					this.carry = null;
					this.gameMode = 0;
					this.selectAction();
				}
                break;
		}
	}
	
	onMouseDown(e:createjs.MouseEvent)
	{
		if (this.gameMode != 0) return;
		
		if (this.carry == null) // nothing carried
		{
			for (let i = 0; i < this.buckets.length; i++)
			{
				var pos = this.buckets[i].globalToLocal(e.stageX, e.stageY);
				if (this.buckets[i].hitTest(pos.x, pos.y))
				{
					this.carry = this.buckets[i];
					this.carryDX = this.buckets[i].x - e.stageX;
					this.carryDY = this.buckets[i].y - e.stageY;
					
					// move bucket to the front
					for (let j = 0; j < this.buckets.length; j++)
					{
						if (this.getChildIndex(this.buckets[j]) > this.getChildIndex(this.carry))
						{
							this.swapChildren(this.buckets[j], this.carry);
						}
					}
					
					console.log("carry " + new createjs.Point(this.carry.x, this.carry.y));
					console.log("neck " + this.carry.getNeckPos());
					
					break;
				}
			}
		}
		else	// user have bucket
		{
			this.gameMode = this.action;
            
			if (this.gameMode == 1)
            {
                this.carry.startFallToBucketProcess(this.fallTo);
            }
			else if (this.gameMode == 2)
			{
				this.tapWaiting = 0;
				this.carry.x = this.parent.mcTap.x;
			}
			else if (this.gameMode == 3)
			{
				this.fillBeforeTrash = this.carry.getFill();
				this.carry.startFallToBucketProcess(this.parent.mcTrash);
			}
		}
	}
	
	onMouseUp(e:createjs.MouseEvent) 
	{
		if (this.gameMode != 0) return;
	}
	
	onMouseMove(e:createjs.MouseEvent)
	{
		if (this.gameMode != 0) return;

		this.selectAction();

		if (this.carry != null)
		{
			this.carry.x = e.stageX + this.carryDX;
			this.carry.y = e.stageY + this.carryDY;
		}
	}
	
	selectAction()
	{
		this.action = 0;
		
		if (this.carry == null) return;
		
		var carryNeckPos = this.carry.getNeckPos();
		
		// want to fill from tap?
		if (Math.abs(carryNeckPos.x - this.parent.mcTap.x) < this.carry.scaleX * 8 
            && carryNeckPos.y - this.parent.mcTap.y > -5 
            && carryNeckPos.y - this.parent.mcTap.y < 40)
		{
			this.action = 2;
			this.parent.mcTap.gotoAndStop(1);
			return;
		}
		this.parent.mcTap.gotoAndStop(0);
		
		// want to fall out to trash?
		if (this.carry.x < 165 && this.carry.y <= 350)
		{
			this.action = 3;
			this.parent.mcTrash.gotoAndStop(1);
			return;
		}
		this.parent.mcTrash.gotoAndStop(0);
		
		// want to transfuse to another bucket?
		var bucket = this.findNearestBucket();
		if (this.carry.getTransformedBounds().intersects(bucket.getTransformedBounds()))
		{
			this.action = 1;
			this.fallTo = bucket;
			bucket.activate(true);
			for (const bucket of this.buckets) if (bucket != this.fallTo) bucket.activate(false);
		}
		else
		{
			for (const bucket of this.buckets) bucket.activate(false);
		}
		
		// want to release bucket (move to floor)
		if (this.action == 0)
		{
			this.action = 4;
		}
	}
	
	findNearestBucket() : McBucket
	{
		var bestBot : McBucket = null;
		var bestDist : number = 1e10;
		for (const b of this.buckets)
		{
			if (b == this.carry) continue;
			var dx = this.carry.x - b.x;
			var dy = this.carry.y - b.y;
			var dist = Math.sqrt(dx * dx + dy * dy);
			if (dist < bestDist) { bestBot = b; bestDist = dist; }
		}
		return bestBot;
	}
	
	checkWin() : boolean
	{
		switch (this.level)
		{
			case  1: return this.buckets[0].getFill() == 4 || this.buckets[1].getFill() == 4;
			case  2: return this.buckets[0].getFill() == 1 || this.buckets[1].getFill() == 1 || this.buckets[2].getFill() == 1;
			case  3: return this.buckets[0].getFill() == 1 || this.buckets[1].getFill() == 1;
			case  4: return this.buckets.filter(bucket => bucket.getFill() == 1).length  >= 2;
			case  5: return this.buckets[1].getFill() == 4 && this.buckets[2].getFill() == 4 && this.buckets[3].getFill() == 6;
			case  6: return this.buckets.filter(bucket => bucket.getFill() == 2).length  >= 3;
			case  7: return this.buckets.filter(bucket => bucket.getFill() == 1).length  >= 2;
			case  8: return this.buckets[0].getFill() == 1 && this.buckets[1].getFill() == 1 && this.buckets[2].getFill() == 1;
			case  9: return this.buckets[0].getFill() == 0 && this.buckets[1].getFill() == 1 && this.buckets[2].getFill() == 2 && this.buckets[3].getFill() == 3;
			case 10: return this.buckets[1].getFill() == 5 && this.buckets[2].getFill() == 18;
		}
		return false;
	}
}
