package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;
	
	public class Level2 extends Level
	{
		public function Level2()
		{
			
		}
		public override function getLevelData():Array
		{
			gravBallCount = 1;
			friendBall = new FriendBall(50,350);
			friendBall.velY = -2.5;
			basket = new BallBasket(400,175);
			setTargets();
			return buildData();
		}
		
		private function setTargets():void
		{
			bronzeTarget = 425;
			silverTarget = 550;
			goldTarget   = 670;
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
			obstacles.push(new Square(200,150,50,50));
			return obstacles;
		}
	}
}