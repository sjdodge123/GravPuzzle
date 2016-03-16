package Construct
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.ChildEvent;
	import Events.LevelStateEvent;
	
	import GameObjects.Immobile.LevelTimer;
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.Camera;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.GravBall;
	import GameObjects.Mobile.MobileObject;
	import GameObjects.Mobile.Obstacles.HitBox;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;
	
	import Handlers.CollisionHandler;
	
	import MapEditor.LevelCreation.Level;
	import MapEditor.LevelCreation.LevelBuilder;
	import MapEditor.LevelCreation.LevelData;
	import MapEditor.LevelCreation.LevelLoader;
	import MapEditor.LevelCreation.ObstacleData;
	

	public class GameBoard extends Sprite
	{
		private var objectBuilder:ObjectBuilder;
		private var friendBall:FriendBall;
		private var basket:BallBasket;
		private var gravBall:GravBall;
		private var gravityObjects:Vector.<GravBall>;
		private var obstacles:Vector.<Obstacle>;
		private var currentLevelData:Level;
		private var goalText:String = "";
	
		
		//Game testing variables
		private var startingLevel:int = 1;
		private var levelNum:int = 0;
		private var penaltyValue:int = 5;
		private var masteryValue:int = 25;
		private var goldValue:int = 25;
		private var silverValue:int = 15;
		private var bronzeValue:int = 5;
		
		
		private var levelTimer:LevelTimer;
		
		private var collisionHandler:CollisionHandler;
		private var levels:Vector.<Level>;
		private var levelList:Vector.<LevelData>;
		private var levelScore:Number;
		private var levelBuilder:LevelBuilder;
		private var totalSpawns:int = 0;
		private var hitBox:HitBox;
		private var gravityBallsSpawned:int;
		private var time:Number;
		private var levelLoader:LevelLoader;
		private var gameScore:int = 0;
		private var loaded:Boolean = false;
		
		public function GameBoard(stageWidth:int,stageHeight:int)
		{
			objectBuilder = new ObjectBuilder();
			objectBuilder.addEventListener(ChildEvent.ADD_CHILD,addElement);
			objectBuilder.addEventListener(ChildEvent.REMOVE_CHILD,removeElement);
			gravityObjects = new Vector.<GravBall>;
			obstacles = new Vector.<Obstacle>;
			levelTimer = new LevelTimer();
			levelLoader = new LevelLoader();
			levelLoader.addEventListener(Event.COMPLETE,populateLevels);
			collisionHandler = new CollisionHandler();
		}
		
		private function populateLevels(evt:Event):void
		{
			loaded = true;
			levels = new Vector.<Level>;
			levelList = levelLoader.getLevelList();
			levels.push(null);
			for(var i:int=0;i<levelList.length;i++)
			{
				levelBuilder = new LevelBuilder(levelList[i]);
				levels.push(levelBuilder);
			}
		 	levelNum = startingLevel;
			buildNextLevel();
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
			goalText = "";
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
			for(var k:int=0;k<basketBoxes.length;k++)
			{
				addChild(basketBoxes[k]);
			}
			var obstacleData:Vector.<Obstacle> = levelData[2];
			this.obstacles = new Vector.<Obstacle>;
			for(var i:int=0;i<obstacleData.length;i++)
			{
				this.obstacles.push(obstacleData[i]);
			}
			displayObstacles();
			levelTimer.reset();
			addChild(friendBall);
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
				gameScore = 0;
				levelNum = 1;
				buildNextLevel();
			}
		}
		
		private function checkScore():Boolean
		{
			var answer:Boolean = false;
			levelScore = calculateScore();
			trace("Achieved score: " + levelScore);
			if(gravityBallsSpawned < 2)
			{
				goalText = ("You got Mastery");
				gameScore += masteryValue; 
				answer = true;
			}
			if(levelScore < 0)
			{
				levelScore = 0;
			}
			
			if(levelScore > currentLevelData.getGoldTarget())
			{
				goalText = ("You got Gold");
				gameScore += goldValue;
				answer = true;
			}
			else if(levelScore > currentLevelData.getSilverTarget())
			{
				goalText = ("You got Silver");
				gameScore += silverValue;
				answer = true;
			}
			else if(levelScore > currentLevelData.getBronzeTarget())
			{
				goalText = ("You got Bronze");
				gameScore += bronzeValue;
				answer = true;
			}
			else
			{
				goalText = ("Passed");
				answer = true;
			}
			trace("Game Score: " + gameScore);
			return answer;
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
			gravityBallsSpawned++;
			//if(totalSpawns < currentLevelData.getGravBallCount())
			//{
			//	totalSpawns += 1;
			gravityObjects = objectBuilder.buildGravBall(stageX,stageY,gravityObjects,currentLevelData.getGravBallCount());
			friendBall.accel = 0;
			//}
			
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
			time = levelTimer.update(dt);
		}
		
		
		private function clearBoard():void
		{
			gravityBallsSpawned = 0;
			totalSpawns = 0;
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
		
		public function calculateScore():Number
		{
			var penalty:int = 0;
			var parBalls:int = currentLevelData.getGravBallCount()*penaltyValue;
			if(gravityBallsSpawned > currentLevelData.getGravBallCount())
			{
				penalty = gravityBallsSpawned*penaltyValue-parBalls;
			}
			var score:int = currentLevelData.getScoreCap() - levelTimer.getElapsedTime() - penalty;
			return score;
		}
		
		public function getElapsedTime():Number
		{
			return time;
		}
		
		public function pause():void
		{
			levelTimer.stop();
		}
		public function resume():void
		{
			levelTimer.start();
		}
		
		public function levelUp():void
		{
			levelNum--;
			clearBoard();
			getAndBuildLevel();
			nextLevel(null);
		}
		public function levelDown():void
		{
			nextLevel(null);
		}
		protected function addElement(event:ChildEvent):void
		{
			addChild(event.params as Sprite);
		}	
		
		protected function removeElement(event:ChildEvent):void
		{
			removeChild(event.params as Sprite);
		}
		
		//The Camera will expand to fit these objects onto the screen
		public function getCameraObjects():Vector.<MobileObject>
		{
			var cameraObjects:Vector.<MobileObject> = new Vector.<MobileObject>;
			cameraObjects.push(friendBall);
			//cameraObjects.push(basket);
			//for each ( var object:MobileObject in gravityObjects){
			//	cameraObjects.push(object);
			//}
			return cameraObjects;
		}
		
		public function displayObstacles():void
		{
			for(var i:int=0;i<obstacles.length;i++)
			{
				addChild(obstacles[i]);
				for(var j:int=0;j<obstacles[i].getHitBoxes().length;j++) //run through and add all hitboxes of each obstacle
				{
					addChild(obstacles[i].hitBoxes[j]);
				}
			}
			
		}
		
		public function addObstacleToBoard(object:ObstacleData):void
		{
			obstacles.push(objectBuilder.buildObstacle(object));
			displayObstacles();
		}
		
		public function getGoalText():String
		{
			return goalText;
		}
		public function getCurrentScore():int
		{
			return calculateScore();
		}
		
		public function getGoldTarget():String
		{
			return currentLevelData.getGoldTarget().toString();
		}
		
		public function getSilverTarget():String
		{
			return currentLevelData.getSilverTarget().toString();
		}
		
		public function getBronzeTarget():String
		{
			return currentLevelData.getBronzeTarget().toString();
		}
		public function checkLoad():Boolean
		{
			return loaded;
		}
	}
}