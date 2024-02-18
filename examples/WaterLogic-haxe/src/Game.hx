import createjs.DisplayObject;
import createjs.MouseEvent;
import createjs.Point;
import nanofl.MovieClip;
import nanofl.TextField;

class Game extends base.Game
{
	var mcTap : MovieClip;
	var mcTrash : MovieClip;
	
	var level = 0;

	var ballSpeed : Point;
	var g = 1;	// physic constant

	var midX = 520/2;
	var midY = 390/2;

	var buckets = new Array<Bucket>();

	var carry : Bucket = null;
	var carryDX : Float;
	var carryDY : Float;

	var action = 0;				// what to do with "carry" if user release it
								// 0 - nothing
								// 1-4 - see gameMode
	
	var fallTo : Bucket = null;
	
	var gameMode = 0;			// 0 - waiting to user
								// 1 - tansfuse water from "carry" into "fallTo"
								// 2 - filling "carry" from tap
								// 3 - falling out from carry to trash
								// 4 - moving bucket to floor
	
	var fallIntoBucketPhase = 0;// 0 - rotation for falling
								// 1 - going to original position
	
	var tapWaiting = 0;	// tick counter
	
	var fillBeforeTrash = 0;
	
	function init()
	{
		cast(parent, MovieClip).stop();
		
		mcTap = cast parent.getChildByName("mcTap");
		mcTrash = cast parent.getChildByName("mcTrash");
		
		this.level = Globals.level;
		
		cast(parent.getChildByName("tfLevel"), TextField).text = Std.string(level);
		
		var tfTask = cast(parent.getChildByName("tfTask"), TextField);
		
		switch (level)
		{
			case 1:
				tfTask.text = "You need to measure 4 litres of water,\nusing two buckets of 5 and 7 litres.\nUse barrel (at the right) for filling buckets.\nTo make buckets empty, use trash (at the left).";
				buckets.push(new Bucket(this, 5, 220));
				buckets.push(new Bucket(this, 7, 320));
			
			case 2:
				tfTask.text = "You need to measure 1 liter of water.";
				buckets.push(new Bucket(this, 3, 180));
				buckets.push(new Bucket(this, 6, 280));
				buckets.push(new Bucket(this, 8, 380));
			
			case 3:
				tfTask.text = "You need to measure 1 liter of water.";
				buckets.push(new Bucket(this, 3, 220));
				buckets.push(new Bucket(this, 5, 320));
			
			case 4:
				tfTask.text = "You need to got 1 liter of water in any two buckets.";
				buckets.push(new Bucket(this, 3, 180));
				buckets.push(new Bucket(this, 4, 280));
				buckets.push(new Bucket(this, 6, 380));
			
			case 5:
				tfTask.text = "You need to got 6 litres of water in bigger bucket,\n4 liters in 5-bucket and 4 litres in 8-bucket.";
				buckets.push(new Bucket(this, 3, 180));
				buckets.push(new Bucket(this, 5, 250));
				buckets.push(new Bucket(this, 8, 320));
				buckets.push(new Bucket(this, 12, 400));
			
			case 6:
				tfTask.text = "You need to got 2 liter of water in any three buckets.";
				buckets.push(new Bucket(this, 3, 180));
				buckets.push(new Bucket(this, 3, 250));
				buckets.push(new Bucket(this, 8, 320));
				buckets.push(new Bucket(this, 11, 400));
			
			case 7:
				tfTask.text = "You need to got 1 liter of water in any two buckets..";
				buckets.push(new Bucket(this, 2, 180));
				buckets.push(new Bucket(this, 3, 280));
				buckets.push(new Bucket(this, 9, 380));
			
			case 8:
				tfTask.text = "You need to got 1 liter of water in small three buckets.";
				buckets.push(new Bucket(this,  5, 180));
				buckets.push(new Bucket(this,  7, 250));
				buckets.push(new Bucket(this,  9, 320));
				buckets.push(new Bucket(this, 11, 400));
			
			case 9:
				tfTask.text = "You need to fill buckets on increase:\nsmallest bust be empty, next must contain 1 liter,\nnext - 2 litres and bigger - 3 litres.";
				buckets.push(new Bucket(this,  7, 180));
				buckets.push(new Bucket(this, 11, 250));
				buckets.push(new Bucket(this, 13, 320));
				buckets.push(new Bucket(this, 17, 400));
			
			case 10:
				tfTask.text = "You must to got 18 litres in 19-bucket and 5 litres in 6-bucket.";
				buckets.push(new Bucket(this,  2, 180));
				buckets.push(new Bucket(this,  6, 280));
				buckets.push(new Bucket(this, 19, 380));
		}
	}
	
	override function onEnterFrame()
	{
		switch (gameMode)
		{
			case 0:
				if (checkWin()) cast(parent, MovieClip).gotoAndStop("Win");
				
			case 1: // transfuse water from current bucket to another
				fallTo.activate(false);
				if (carry.fallProcessStep(carryDX, carryDY))
				{
					gameMode = 0;
					selectAction();
				}
				
			case 2: // filling bucket from tap
				if (carry.fill < carry.total)
				{
					if (mcTap.currentFrame != 2) mcTap.gotoAndStop(2);
					tapWaiting++;
					if (tapWaiting % 10 == 9)
					{
						carry.setFill(carry.fill + 1);
						Sounds.tap();
						Sounds.water();
					}
				}
				else // bucket is full
				{
					mcTap.gotoAndStop(0);
					
					if (carry.moveStepTo(new Point(stage.mouseX + carryDX, stage.mouseY + carryDY), 10))
					{
						tapWaiting = 0;
						gameMode = 0;
						selectAction();
					}
				}
				
			case 3: // fall out to trash
				if (carry.fallProcessStep(carryDX, carryDY))
				{
					gameMode = 0;
					selectAction();
				}
				else
				{
					if (fillBeforeTrash>0 && carry.fill<fillBeforeTrash)
					{
						fillBeforeTrash = carry.fill;
						Sounds.trash();
					}
				}
				
			case 4: // moving bucket to the ground
				if (carry.moveStepTo(new Point(carry.mc.x, 345), 6))
				{
					carry = null;
					gameMode = 0;
					selectAction();
				}
		}
	}
	
	override public function onMouseDown(e:MouseEvent)
	{
		if (gameMode != 0) return;
		
		if (carry == null) // nothing carried
		{
			for (i in 0...buckets.length)
			{
				var pos = buckets[i].mc.globalToLocal(e.stageX, e.stageY);
				if (buckets[i].mc.hitTest(pos.x, pos.y))
				{
					carry = buckets[i];
					carryDX = buckets[i].mc.x - e.stageX;
					carryDY = buckets[i].mc.y - e.stageY;
					
					// move bucket to the front
					for (j in 0...buckets.length)
					{
						if (getChildIndex(buckets[j].mc) > getChildIndex(carry.mc))
						{
							swapChildren(buckets[j].mc, carry.mc);
						}
					}
					
					trace("carry " + new Point(carry.mc.x, carry.mc.y));
					trace("neck " + carry.getNeckPos());
					
					break;
				}
			}
		}
		else	// user have bucket
		{
			gameMode = action;
			if (gameMode == 1) carry.startFallToBucketProcess(fallTo);
			else
			if (gameMode == 2)
			{
				tapWaiting = 0;
				carry.mc.x = mcTap.x;
			}
			else
			if (gameMode == 3)
			{
				fillBeforeTrash = carry.fill;
				
				var sliv = new BaseBucket(1000, mcTrash);
				carry.startFallToBucketProcess(sliv);
			}
		}
	}
	
	override function onMouseUp(e:MouseEvent) 
	{
		if (gameMode != 0) return;
	}
	
	override function onMouseMove(e:MouseEvent)
	{
		if (gameMode != 0) return;

		selectAction();

		if (carry != null)
		{
			carry.mc.x = e.stageX + carryDX;
			carry.mc.y = e.stageY + carryDY;
		}
	}
	
	function selectAction()
	{
		action = 0;
		
		if (carry == null) return;
		
		var carryNeckPos = carry.getNeckPos();
		
		// want to fill from tap?
		if (Math.abs(carryNeckPos.x - mcTap.x) < carry.mc.scaleX * 8 && carryNeckPos.y - mcTap.y > -5 && carryNeckPos.y - mcTap.y < 40)
		{
			action = 2;
			mcTap.gotoAndStop(1);
			return;
		}
		mcTap.gotoAndStop(0);
		
		// want to fall out to trash?
		if (carry.mc.x < 165 && carry.mc.y <= 350)
		{
			action = 3;
			mcTrash.gotoAndStop(1);
			return;
		}
		mcTrash.gotoAndStop(0);
		
		// want to transfuse to another bucket?
		var bucket = findNearestBucket();
		if (carry.mc.getTransformedBounds().intersects(bucket.mc.getTransformedBounds()))
		{
			action = 1;
			fallTo = bucket;
			bucket.activate(true);
			for (bucket in buckets) if (bucket != fallTo) bucket.activate(false);
		}
		else
		{
			for (bucket in buckets) bucket.activate(false);
		}
		
		// want to release bucket (move to floor)
		if (action == 0)
		{
			action = 4;
		}
	}
	
	function findNearestBucket() : Bucket
	{
		var bestBot : Bucket = null;
		var bestDist : Float = 1e10;
		for (b in buckets)
		{
			if (b == carry) continue;
			var dx = carry.mc.x - b.mc.x;
			var dy = carry.mc.y - b.mc.y;
			var dist = Math.sqrt(dx * dx + dy * dy);
			if (dist<bestDist) { bestBot = b; bestDist = dist; }
		}
		return bestBot;
	}
	
	function checkWin() : Bool
	{
		switch (level)
		{
			case 1: return buckets[0].fill == 4 || buckets[1].fill == 4;
			case 2: return buckets[0].fill == 1 || buckets[1].fill == 1 || buckets[2].fill == 1;
			case 3: return buckets[0].fill == 1 || buckets[1].fill == 1;
			case 4: return buckets.filter(function(bucket) return bucket.fill == 1).length  >= 2;
			case 5: return buckets[1].fill == 4 && buckets[2].fill == 4 && buckets[3].fill == 6;
			case 6: return buckets.filter(function(bucket) return bucket.fill == 2).length  >= 3;
			case 7: return buckets.filter(function(bucket) return bucket.fill == 1).length  >= 2;
			case 8: return buckets[0].fill == 1 && buckets[1].fill == 1 && buckets[2].fill == 1;
			case 9: return buckets[0].fill == 0 && buckets[1].fill == 1 && buckets[2].fill == 2 && buckets[3].fill == 3;
			case 10: return buckets[1].fill == 5 && buckets[2].fill == 18;
		}
		return false;
	}
}
