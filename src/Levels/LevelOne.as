package Levels
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;

	public class LevelOne extends Level
	{
		public function LevelOne()
		{
			gravBallCount = 3;
			friendBall = new FriendBall(20,20);
			friendBall.velX = 1.5;
			basket = new BallBasket(400,300);
		}
		
		public function getLevelData():Array
		{
			var levelData:Array = new Array();
			levelData.push(friendBall);
			levelData.push(basket);
			return levelData;
		}
	}
}