package MapEditor.LevelCreation
{	
	public class LevelData
	{
		public var name:String;
		public var gravBallCount:int;
		public var goldTarget:int;
		public var silverTarget:int;
		public var bronzeTarget:int;
		public var obstacles:Vector.<ObstacleData>;
		public var ballX:int;
		public var ballY:int;
		public var ballVelX:Number;
		public var ballVelY:Number;
		public var basketX:int;
		public var basketY:int;
		public var basketWidth:int;
		public var basketHeight:int;
		
		public function LevelData()
		{
			
		}
	}
}