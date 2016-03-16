package MapEditor.LevelCreation
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	public class LevelData
	{
		public var name:String;
		public var gravBallCount:int;
		public var friendBall:FriendBall;
		public var basket:BallBasket;
		public var goldTarget:int;
		public var silverTarget:int;
		public var bronzeTarget:int;
		public var obstacles:Vector.<Obstacle>;
		
		public function LevelData()
		{
			
		}
	}
}