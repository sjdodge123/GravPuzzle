package Levels
{
	import flash.display.Sprite;
	
	import GameObjects.BallBasket;
	import GameObjects.FriendBall;
	import GameObjects.GravBall;

	public class LevelOne extends Sprite
	{
		private var friendBall:FriendBall;
		private var basket:BallBasket;
		private var gravBall:GravBall;
		private var gravityObjects:Vector.<GravBall>;
		
		public function LevelOne()
		{
			gravityObjects = new Vector.<GravBall>;
			friendBall = new FriendBall(20,20);
			basket = new BallBasket(400,300);
			addChild(basket);
			addChild(friendBall);
		}
		
		
		
		public function update(dt:Number):void
		{
			for(var i:int=0;i<gravityObjects.length;i++)
			{
				var dx:Number = gravityObjects[i].x -friendBall.x;
				var dy:Number = gravityObjects[i].y -friendBall.y;
				friendBall.updateVel(dt,dx,dy);	
			}
			friendBall.updatePos(dt);	
		}
		
		public function mouseClick(stageX:Number, stageY:Number):void
		{
			if(gravityObjects.length < 1)
			{
				gravBall = new GravBall(stageX,stageY);
				gravityObjects.push(gravBall);
				addChild(gravBall);
			}
			for(var i:int=0;i<gravityObjects.length;i++)
			{
				var dx:Number = gravityObjects[i].x - stageX;
				var dy:Number = gravityObjects[i].y - stageY;
				var distance:Number = Math.sqrt(dx*dx + dy*dy);
				if(distance > gravityObjects[i].radius*3)
				{
					gravBall = new GravBall(stageX,stageY);
					gravityObjects.push(gravBall);
					addChild(gravBall);
				}
			}
			friendBall.accel = 0;
		}
		
		public function checkDeletions(stageX:Number, stageY:Number):Boolean
		{
			for(var i:int=0;i<gravityObjects.length;i++)
			{
				var dx:Number = gravityObjects[i].x - stageX;
				var dy:Number = gravityObjects[i].y - stageY;
				var distance:Number = Math.sqrt(dx*dx + dy*dy);	
				if(distance <= gravityObjects[i].radius)
				{
					removeChild(gravityObjects[i]);
					gravityObjects[i] = null;
					gravityObjects.splice(i,1);
					return true;
				}
			}
			return false;
			
		}
	}
}