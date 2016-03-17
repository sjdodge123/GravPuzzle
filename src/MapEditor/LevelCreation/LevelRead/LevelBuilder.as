package MapEditor.LevelCreation.LevelRead
{
	import Construct.ObjectBuilder;
	
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	
	public class LevelBuilder extends Level
	{
		private var data:LevelData;
		private var objectBuilder:ObjectBuilder;
		public function LevelBuilder(data:LevelData)
		{
			objectBuilder = new ObjectBuilder();
			this.data = data;
		}
		
		public override function getLevelData():Array
		{
			gravBallCount = data.gravBallCount;
			friendBall = new FriendBall(data.ballX,data.ballY);
			friendBall.velX = data.ballVelX;
			friendBall.velY = data.ballVelY;
			basket = new BallBasket(data.basketX,data.basketY,data.basketWidth,data.basketHeight);
			setTargets();
			return buildData();
		}
		
		private function setTargets():void
		{
			goldTarget   = data.goldTarget;
			silverTarget = data.silverTarget;
			bronzeTarget = data.bronzeTarget;
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
			for(var i:int=0;i<data.obstacles.length;i++)
			{
				obstacles.push(objectBuilder.buildObstacle(data.obstacles[i]));
			}
			return obstacles;
		}
	}
}