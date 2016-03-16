package MapEditor.LevelCreation
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.*;
	
	
	public class LevelBuilder extends Level
	{
		private var data:LevelData;
		public function LevelBuilder(data:LevelData)
		{
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
			for(var i:int=0;i<data.obstacles.length;i++){
				if(data.obstacles[i].type == "Square"){
					obstacles.push(new Square(data.obstacles[i].x,data.obstacles[i].y,data.obstacles[i].width,data.obstacles[i].height))
				}
			}
			return obstacles;
		}
	}
}