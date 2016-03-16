package MapEditor.LevelCreation
{
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	import Levels.Level;
	
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
			friendBall = data.friendBall;
			basket = data.basket;
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
			return data.obstacles;
		}
	}
}