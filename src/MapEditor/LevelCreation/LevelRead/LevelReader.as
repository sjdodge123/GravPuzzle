package MapEditor.LevelCreation.LevelRead
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LevelReader extends EventDispatcher
	{
		private var loader:XMLLoader;
		private var xml:XML;
		private var dataList:Vector.<LevelData>;
		public function LevelReader(url:String)
		{
			loader = new XMLLoader(url);
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
			levelData.ballX = ballData.child("x");
			levelData.ballY = ballData.child("y");
			levelData.ballVelX = ballData.child("velX");
			levelData.ballVelY = ballData.child("velY");
			
			var basketData:XMLList = level.child("basket");
			levelData.basketX = basketData.child("x");
			levelData.basketY = basketData.child("y");
			levelData.basketWidth = basketData.child("width");
			levelData.basketHeight = basketData.child("height");
			
			var targets:XMLList = level.child("targets");
			levelData.goldTarget = targets.child("gold");
			levelData.silverTarget  = targets.child("silver");
			levelData.bronzeTarget = targets.child("bronze");
			
			levelData.obstacles = new Vector.<ObstacleData>;
			var obstacleDataList:XMLList = level.child("obstacles");
			for(var i:int=0;i<obstacleDataList.children().length();i++)
			{
				var count:int = 0;
				var data:ObstacleData = new ObstacleData();
				var objectData:XMLList = obstacleDataList.child(i);
				var type:String = objectData.child("type").toString();
				if(type == "Square")
				{
					data.type = type;
					data.x = objectData.child("x");
					data.y = objectData.child("y");
					data.width = objectData.child("width");
					data.height = objectData.child("height");
				}
				if(type == "DeadZone")
				{
					data.type = type;
					data.x = objectData.child("x");
					data.y = objectData.child("y");
					data.width = objectData.child("width");
					data.height = objectData.child("height");
				}
				if(type == "Circle")
				{
					data.type = type;
					data.x = objectData.child("x");
					data.y = objectData.child("y");
					data.radius = objectData.child("radius");
				}
				count++;
				levelData.obstacles.push(data);
			}
			return levelData;
		}
		public function getLevelList():Vector.<LevelData>
		{
			return dataList;
		}
		public function getXML():XML{
			return xml;
		}
	}
}