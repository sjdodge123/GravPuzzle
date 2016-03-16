package MapEditor.LevelCreation
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;

	public class LevelLoader extends EventDispatcher
	{
		private var loader:XMLLoader;
		private var xml:XML;
		private var dataList:Vector.<LevelData>;
		public function LevelLoader()
		{
			loader = new XMLLoader("Levels/levels.xml");
			loader.addEventListener(Event.COMPLETE,getLevelData);
		}
		
		protected function getLevelData(event:Event):void
		{
			dataList = new Vector.<LevelData>;
			xml = loader.getData();
			for(var i:int=0;i<xml.children().length();i++){
				dataList.push(readLevel(xml.child(i)));
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function readLevel(level:XMLList):LevelData
		{
			var levelData:LevelData = new LevelData();
			
			levelData.name = level.child("name").toString();
			levelData.gravBallCount = level.child("gravBallCount");
			
			var ballData:XMLList = level.child("friendBall");
			var ballX:int = ballData.child("x");
			var ballY:int = ballData.child("y");
			var ballVelX:Number = ballData.child("velX");
			var ballVelY:Number = ballData.child("velY");
			
			var friendBall:FriendBall = new FriendBall(ballX,ballY);
			friendBall.velX = ballVelX;
			friendBall.velY = ballVelY;
			levelData.friendBall = friendBall;
			
			var basketData:XMLList = level.child("basket");
			var basketX:int = basketData.child("x");
			var basketY:int = basketData.child("y");
			var basketWidth:Number = basketData.child("width");
			var basketHeight:Number = basketData.child("height");
			levelData.basket = new BallBasket(basketX,basketY,basketWidth,basketHeight);
			
			var targets:XMLList = level.child("targets");
			levelData.goldTarget = targets.child("gold");
			levelData.silverTarget  = targets.child("silver");
			levelData.bronzeTarget = targets.child("bronze");
			
			levelData.obstacles = new Vector.<Obstacle>;
			var obstacleData:XMLList = level.child("obstacles");
			for(var i:int=0;i<obstacleData.length();i++)
			{
				var objectData:XMLList = obstacleData.child(i);
				var type:String =objectData.child("type").toString();
				if(type == "Square")
				{
					var squareX:int = objectData.child("x");
					var squareY:int = objectData.child("y");
					var squareWidth:int = objectData.child("width");
					var squareHeight:int = objectData.child("height");
					levelData.obstacles.push(new Square(squareX,squareY,squareWidth,squareHeight));
				}
				
			}
			return levelData;
		}
		public function getLevelList():Vector.<LevelData>
		{
			return dataList;
		}
	}
}