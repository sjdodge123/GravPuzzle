package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;

	public class Level1 extends Level
	{
		public function Level1()
		{
			
		}
		public override function getLevelData():Array
		{
			gravBallCount = 10;
			friendBall = new FriendBall(20,20);
			friendBall.velX = 1.5;
			basket = new BallBasket(400,300,90);
			setTargets();
			return buildData();
		}
		
		private function setTargets():void
		{
			goldTarget   = 94;
			silverTarget = 88;
			bronzeTarget = 75;
			
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
			obstacles.push();
			return obstacles;
		}
	}
}