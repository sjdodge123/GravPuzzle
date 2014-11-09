package Levels
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Construct.ObjectBuilder;
	
	import Events.ChildEvent;
	
	import GameObjects.BallBasket;
	import GameObjects.FriendBall;
	import GameObjects.GravBall;

	public class LevelOne extends Sprite
	{
		private var friendBall:FriendBall;
		private var basket:BallBasket;
		private var gravBall:GravBall;
		private var gravityObjects:Vector.<GravBall>;
		private var gravBallCount:int = 3;
		private var spawnClear:Boolean;
		private var objectBuilder:ObjectBuilder;
		
		public function LevelOne()
		{
			objectBuilder = new ObjectBuilder();
			objectBuilder.addEventListener(ChildEvent.ADD_CHILD,addElement);
			objectBuilder.addEventListener(ChildEvent.REMOVE_CHILD,removeElement);
			gravityObjects = new Vector.<GravBall>;
			friendBall = new FriendBall(20,20);
			basket = new BallBasket(400,300);
			addChild(basket);
			addChild(friendBall);
		}
		
		protected function addElement(event:ChildEvent):void
		{
			addChild(event.params as Sprite);
		}	
		
		protected function removeElement(event:ChildEvent):void
		{
			removeChild(event.params as Sprite);
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
		
		public function spawnGravBall(stageX:Number, stageY:Number):void
		{
			gravityObjects = objectBuilder.buildGravBall(stageX,stageY,gravityObjects,gravBallCount);
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
		
		public function endLevel():void
		{
			for( var i:int=0;i<gravityObjects.length;i++)
			{
				removeChild(gravityObjects[i]);
			}
			gravityObjects = null;
			removeChild(friendBall);
		}
		
		public function reset():Boolean
		{
			for( var i:int=0;i<gravityObjects.length;i++)
			{
				removeChild(gravityObjects[i]);
			}
			gravityObjects = null;
			gravityObjects = new Vector.<GravBall>;
			removeChild(friendBall);
			friendBall = new FriendBall(20,20);
			addChild(friendBall);
			return true;
		}
	}
}