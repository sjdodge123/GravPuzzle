package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Wall;

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
		
		private function buildObstacles():Vector.<Obstacle>
		{
			obstacles = new Vector.<Obstacle>;
			obstacles.push(new Wall(300,300));
			return obstacles;
		}
	}
}