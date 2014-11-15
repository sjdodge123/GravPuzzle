package Construct
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import Events.ChildEvent;
	import Events.LevelStateEvent;
	
	import GameObjects.Immobile.GravBall;
	import GameObjects.Immobile.LevelTimer;
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.HitBox;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	import Handlers.CollisionHandler;
	
	import Levels.Level;
	import Levels.Level1;
	import Levels.Level2;
	import Levels.Level3;
	import Levels.Level4;

	public class GameBoard extends Sprite
	{
		private var objectBuilder:ObjectBuilder;
		private var friendBall:FriendBall;
		private var basket:BallBasket;
		private var gravBall:GravBall;
		private var gravityObjects:Vector.<GravBall>;
		private var obstacles:Vector.<Obstacle>;
		private var currentLevelData:Level;
		private var levelNum:int = 1;
		private var levelTimer:LevelTimer;
		private var timerDisplay:TextField;
		private var collisionHandler:CollisionHandler;
		private var levels:Vector.<Level>;
		private var levelScore:Number;
		
		//temporary!!
		public var hitBox:HitBox;
		private var mouseClicks:int;
		
		public function GameBoard(stageWidth:int,stageHeight:int)
		{
			objectBuilder = new ObjectBuilder();
			objectBuilder.addEventListener(ChildEvent.ADD_CHILD,addElement);
			objectBuilder.addEventListener(ChildEvent.REMOVE_CHILD,removeElement);
			gravityObjects = new Vector.<GravBall>;
			obstacles = new Vector.<Obstacle>;
			levelTimer = new LevelTimer();
			timerDisplay = new TextField();
			timerDisplay.textColor = 0xFF0000;
			timerDisplay.x = stageWidth/2;
			timerDisplay.y = 1;
			timerDisplay.selectable = false;
			addChild(timerDisplay);
			
			populateLevels();
			buildNextLevel();
			collisionHandler = new CollisionHandler();
			
		}
		
		private function populateLevels():void
		{
			levels = new Vector.<Level>;
			levels.push(null);
			levels.push(new Level1());
			levels.push(new Level2());
			levels.push(new Level3());
			levels.push(new Level4());
			
			levelNum = 1;
		} 
		//-----------------------------------------------
		//-----------------Level Control-----------------
		//-----------------------------------------------
		
		private function buildNextLevel():void
		{
			currentLevelData = levels[levelNum];
			getAndBuildLevel();
		}
		
		public function resetLevel(event:Event):Boolean
		{
			clearBoard();
			getAndBuildLevel();
			return true;
		}
		
		private function getAndBuildLevel():void
		{
			levelScore = currentLevelData.getScoreCap();
			var levelData:Array = currentLevelData.getLevelData();
			friendBall = levelData[0];
			basket = levelData[1];
			basket.addEventListener(LevelStateEvent.WIN_LEVEL,nextLevel);
			basket.addEventListener(LevelStateEvent.LOSE_LEVEL,resetLevel);
			var basketBoxes:Vector.<HitBox> = basket.getHitBoxes();
			addChild(basket);
			for(var i:int=0;i<basketBoxes.length;i++)
			{
				addChild(basketBoxes[i]);
			}
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
			levelTimer.reset();
			addChild(friendBall);
			addChild(timerDisplay);
			friendBall.calcChange(1);
		}
		
		protected function nextLevel(event:Event):void
		{
			if(checkScore())
			{
				levelNum++;
			}
			clearBoard();
			if(levelNum < levels.length)
			{
				buildNextLevel();
			}
			else
			{
				//Return to level selection or menu screen
				trace("You Win! Game over");
				levelNum = 1;
				buildNextLevel();
			}
		}
		
		private function checkScore():Boolean
		{
			levelScore -= 50*levelTimer.getElapsedTime();
			if(mouseClicks < 2)
			{
				trace("Mastery Achieved");
			}
			if(levelScore < 0)
			{
				levelScore = 0;
			}
			trace(levelScore);
			if(levelScore > currentLevelData.getGoldTarget())
			{
				trace("You got Gold");
				return true;
			}
			else if(levelScore > currentLevelData.getSilverTarget())
			{
				trace("You got Silver");
				return true;
			}
			else if(levelScore > currentLevelData.getBronzeTarget())
			{
				trace("You got Bronze");
				return true;
			}
			else
			{
				trace("You suckkkk, you can't go on");
				return false;
			}
		}
		
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
			mouseClicks++;
			gravityObjects = objectBuilder.buildGravBall(stageX,stageY,gravityObjects,currentLevelData.getGravBallCount());
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
			var time:Number = levelTimer.update(dt);
			timerDisplay.text = time.toString();
		}
		
		private function clearBoard():void
		{
			mouseClicks = 0;
			levelScore = 1000;
			var count:int = numChildren;
			while(numChildren)
			{
				count--;
				removeChild(getChildAt(count));
			}
			gravityObjects = null;
			friendBall = null;
			basket.removeEventListener(LevelStateEvent.WIN_LEVEL,nextLevel);
			basket.removeEventListener(LevelStateEvent.LOSE_LEVEL,resetLevel);
			basket = null;
			gravityObjects = new Vector.<GravBall>;
		}
		
		public function pause():void
		{
			levelTimer.stop();
		}
		public function resume():void
		{
			levelTimer.start();
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