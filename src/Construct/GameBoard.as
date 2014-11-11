package Construct
{
	import flash.display.Sprite;
	import flash.net.ObjectEncoding;
	
	import Events.ChildEvent;
	
	import GameObjects.Immobile.GravBall;
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	import Levels.Level;
	import Levels.LevelOne;

	public class GameBoard extends Sprite
	{
		private var objectBuilder:ObjectBuilder;
		private var friendBall:FriendBall;
		private var basket:BallBasket;
		private var gravBall:GravBall;
		private var gravityObjects:Vector.<GravBall>;
		private var obstacles:Vector.<Obstacle>;
		private var currentLevel:Level;
		public function GameBoard()
		{
			//Setup Gameboard
			objectBuilder = new ObjectBuilder();
			objectBuilder.addEventListener(ChildEvent.ADD_CHILD,addElement);
			objectBuilder.addEventListener(ChildEvent.REMOVE_CHILD,removeElement);
			gravityObjects = new Vector.<GravBall>;
			obstacles = new Vector.<Obstacle>;
			buildNextLevel();
		}
		//-----------------------------------------------
		//-----------------Level Control-----------------
		//-----------------------------------------------
		
		private function buildNextLevel():void
		{
			currentLevel = new LevelOne();
			getAndBuildLevel();
		}
		
		public function resetLevel():Boolean
		{
			var count:int = numChildren;        // Very Important or the count in the below loop will be off
			while(numChildren)
			{
				count--;
				removeChild(getChildAt(count));
			}
			gravityObjects = null;
			gravityObjects = new Vector.<GravBall>;
			getAndBuildLevel();
			return true;
		}
		
		private function getAndBuildLevel():void
		{
			var levelData:Array = currentLevel.getLevelData();
			friendBall = levelData[0];
			basket = levelData[1];
			var obstacleData:Vector.<Obstacle> = levelData[2];
			this.obstacles = new Vector.<Obstacle>;
			for(var i:int=0;i<obstacleData.length;i++)
			{
				this.obstacles.push(obstacleData[i]);
				addChild(obstacleData[i]);
			}
			addChild(friendBall);
			addChild(basket);
		}
		
//		public function endLevel():void
//		{
//			for( var i:int=0;i<gravityObjects.length;i++)
//			{
//				removeChild(gravityObjects[i]);
//			}
//			gravityObjects = null;
//			removeChild(friendBall);
//		}
		
		
		//-----------------------------------------------
		//-----------------User Control------------------
		//-----------------------------------------------
		
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
		
		public function spawnGravBall(stageX:Number, stageY:Number):void
		{
			gravityObjects = objectBuilder.buildGravBall(stageX,stageY,gravityObjects,currentLevel.getGravBallCount());
			friendBall.accel = 0;
		}
		
		
		//-----------------------------------------------
		//-----------------Game Functions----------------
		//-----------------------------------------------
		
		
		public function update(dt:Number):void
		{
			for(var i:int=0;i<gravityObjects.length;i++)
			{
				var dx:Number = gravityObjects[i].x -friendBall.x;
				var dy:Number = gravityObjects[i].y -friendBall.y;
				friendBall.updateVel(dt,dx,dy);	
			}
			friendBall.calcChange(dt);
			// !TODO! needs to check for collision against the obstacle array !TODO!
			
			// !TODO! Line 132 should be reversed. The friendBall should be checking to see if it collides with anything, not the other way around! !TODO!
			basket.checkBounds(friendBall,dt);
			friendBall.updatePos();
			
		}
		protected function addElement(event:ChildEvent):void
		{
			addChild(event.params as Sprite);
		}	
		
		protected function removeElement(event:ChildEvent):void
		{
			removeChild(event.params as Sprite);
		}
	}
}