package Construct
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.net.ObjectEncoding;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import Events.ChildEvent;
	
	import GameObjects.Immobile.GravBall;
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.HitBox;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	import Handlers.CollisionHandler;
	
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
		private var levelTimer:Timer;
		private var timerDisplay:TextField;
		private var collisionHandler:CollisionHandler;
		
		//temporary!!
		public var hitBox:HitBox;
		
		public function GameBoard(gameStage:Stage)
		{
			//Setup Gameboard
			objectBuilder = new ObjectBuilder();
			objectBuilder.addEventListener(ChildEvent.ADD_CHILD,addElement);
			objectBuilder.addEventListener(ChildEvent.REMOVE_CHILD,removeElement);
			gravityObjects = new Vector.<GravBall>;
			obstacles = new Vector.<Obstacle>;
			levelTimer = new Timer(0,0);
			timerDisplay = new TextField();
			timerDisplay.textColor = 0xFF0000;
			timerDisplay.x = gameStage.stageWidth/2;
			timerDisplay.y = 1;
			timerDisplay.selectable = false;
			addChild(timerDisplay);
			buildNextLevel();
			collisionHandler = new CollisionHandler();
//			hitBox = new HitBox(200,150);
//			addChild(hitBox);
			
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
			var count:int = numChildren;
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
			levelTimer.reset();
			var levelData:Array = currentLevel.getLevelData();
			friendBall = levelData[0];
			basket = levelData[1];
			var obstacleData:Vector.<Obstacle> = levelData[2];
			this.obstacles = new Vector.<Obstacle>;
			for(var i:int=0;i<obstacleData.length;i++)
			{
				this.obstacles.push(obstacleData[i]);
				addChild(obstacleData[i]);
				
				for(var j:int=0;j<obstacleData[i].getHitBoxes().length;j++) //run through and add all hitboxes of each obstacle
				{
					addChild(obstacleData[i].hitBoxes[j]);
				}
			}
			addChild(friendBall);
			addChild(basket);
			addChild(timerDisplay);
			levelTimer.start();
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
			collisionHandler.checkBounds(friendBall,obstacles,basket,dt); 
			friendBall.updatePos();
			var time:Number = levelTimer.currentCount/100;
			timerDisplay.text = time.toString();
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