package Levels
{
	import flash.events.EventDispatcher;
	
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;

	public class Level extends EventDispatcher
	{
	
		protected var gravBallCount:int = -1;
		protected var friendBall:FriendBall;
		protected var basket:BallBasket;
		protected var obstacles:Vector.<Obstacle>;
		protected var levelData:Array;
		protected var bronzeTarget:int = 0;
		protected var silverTarget:int = 0;
		protected var goldTarget:int = 0;
		
		public function Level()
		{
			
		}
		
		public function getGravBallCount():int
		{
			return gravBallCount;
		}
		
		public function getLevelData():Array
		{
			return levelData;	
		}
		public function getBronzeTarget():int
		{
			return bronzeTarget;
		}
		public function getSilverTarget():int
		{
			return silverTarget;
		}
		public function getGoldTarget():int
		{
			return goldTarget;	
		}
	}
}