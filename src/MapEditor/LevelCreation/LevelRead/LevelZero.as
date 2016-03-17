package MapEditor.LevelCreation.LevelRead
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;

	public class LevelZero extends Level
	{
		public function LevelZero()
		{
			// THIS LEVEL IS FOR UI& level selection purposes... Not used yet.
		}
		public override function getLevelData():Array
		{
			gravBallCount = 3;
			friendBall = new FriendBall(20,20);
			friendBall.velX = 1.5;
			basket = new BallBasket(400,300);
			setTargets();
			return buildData();
		}
		
		private function setTargets():void
		{
			bronzeTarget = 200;
			silverTarget = 400;
			goldTarget   = 1000;
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