package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;

	public class Level3 extends Level
	{
		public function Level3()
		{
			
		}
		public override function getLevelData():Array
		{
			gravBallCount = 1;
			friendBall = new FriendBall(265,50);
			friendBall.velY = 1.22;
			basket = new BallBasket(350,250);
			setTargets();
			return buildData();
		}
		
		private function setTargets():void
		{
			bronzeTarget = 200;
			silverTarget = 350;
			goldTarget   = 600;
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
			obstacles.push(new Square(100,150,500,50));
			return obstacles;
		}
	}
}