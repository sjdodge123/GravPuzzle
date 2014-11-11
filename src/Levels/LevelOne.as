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
			
			var levelData:Array = new Array();
			levelData.push(friendBall);
			levelData.push(basket);
			return levelData;
		}
	}
}