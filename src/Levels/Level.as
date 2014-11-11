package Levels
{
	import flash.events.EventDispatcher;
	
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;

	public class Level extends EventDispatcher
	{
	
		protected var gravBallCount:int = -1;
		protected var friendBall:FriendBall;
		protected var basket:BallBasket;
		protected var obstacles:Array
		protected var levelData:Array 
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
	}
}