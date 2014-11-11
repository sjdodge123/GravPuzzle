package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;

	public class LevelOne extends Level
	{
		public function LevelOne()
		{
			
		}
		public override function getLevelData():Array
		{
			gravBallCount = 3;
			friendBall = new FriendBall(20,20);
			friendBall.velX = 1.5;
			basket = new BallBasket(400,300);
			return buildData();
		}
		
		private function buildData():Array
		{
			levelData = new Array();
			levelData.push(friendBall);
			levelData.push(basket);
			levelData.push(buildObstacles()); 
			return levelData;
		}
		
		private function buildObstacles():Array
		{
			obstacles = new Array();
			return obstacles;
		}
	}
}