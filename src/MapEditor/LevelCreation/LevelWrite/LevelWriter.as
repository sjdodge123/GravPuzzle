package MapEditor.LevelCreation.LevelWrite
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import MapEditor.LevelCreation.LevelRead.LevelData;
	import MapEditor.LevelCreation.LevelRead.LevelReader;

	public class LevelWriter
	{
		private var fileLocation:String = "MapEditor/LevelCreation/levels.xml";
		private var levelLoader:LevelReader;
		private var loaded:Boolean = false;
		private var xml:XML;
		private var file:File;
		
		public function LevelWriter()
		{
			levelLoader = new LevelReader(fileLocation);
			levelLoader.addEventListener(Event.COMPLETE,levelsLoaded);
		}
		
		protected function levelsLoaded(event:Event):void
		{
			loaded = true;
			xml = levelLoader.getXML();	
		}
		public function createLevel(levelData:LevelData):void
		{
			var newLevel:XML = new XML(<level{xml.children().length()+1}/>);
			
			newLevel.appendChild(new XML(<name>{levelData.name}</name>));
			newLevel.appendChild(new XML(<gravBallCount>{levelData.gravBallCount}</gravBallCount>));
			
			var friendBall:XML = new XML(<friendBall />);
			friendBall.appendChild(new XML(<x>{levelData.ballX}</x>));
			friendBall.appendChild(new XML(<y>{levelData.ballY}</y>));
			friendBall.appendChild(new XML(<velX>{levelData.ballVelX}</velX>));
			friendBall.appendChild(new XML(<velY>{levelData.ballVelY}</velY>));
			newLevel.appendChild(friendBall);
			
			var basket:XML = new XML(<basket />);
			basket.appendChild(new XML(<x>{levelData.basketX}</x>));
			basket.appendChild(new XML(<y>{levelData.basketY}</y>));
			basket.appendChild(new XML(<width>{levelData.basketWidth}</width>));
			basket.appendChild(new XML(<height>{levelData.basketHeight}</height>));
			newLevel.appendChild(basket);
			
			var targets:XML = new XML(<targets />);
			targets.appendChild(new XML(<gold>{levelData.goldTarget}</gold>));
			targets.appendChild(new XML(<silver>{levelData.silverTarget}</silver>));
			targets.appendChild(new XML(<bronze>{levelData.bronzeTarget}</bronze>));
			newLevel.appendChild(targets);
			
			var obstacles:XML = new XML(<obstacles />);
			for(var i:int =0 ;i<levelData.obstacles.length;i++)
			{
				var object:XML = new XML(<object />);
				object.appendChild(new XML(<type>{levelData.obstacles[i].type}</type>));
				object.appendChild(new XML(<x>{levelData.obstacles[i].x}</x>));
				object.appendChild(new XML(<y>{levelData.obstacles[i].y}</y>));
				if(levelData.obstacles[i].type == 'Square')
				{
					object.appendChild(new XML(<width>{levelData.obstacles[i].width}</width>));
					object.appendChild(new XML(<height>{levelData.obstacles[i].height}</height>));
				}
				if(levelData.obstacles[i].type == 'DeadZone')
				{
					object.appendChild(new XML(<width>{levelData.obstacles[i].width}</width>));
					object.appendChild(new XML(<height>{levelData.obstacles[i].height}</height>));
				}
				if(levelData.obstacles[i].type == 'BlackZone')
				{
					object.appendChild(new XML(<width>{levelData.obstacles[i].width}</width>));
					object.appendChild(new XML(<height>{levelData.obstacles[i].height}</height>));
				}
				if(levelData.obstacles[i].type == 'Circle')
				{
					object.appendChild(new XML(<radius>{levelData.obstacles[i].radius}</radius>));
				}
				
				obstacles.appendChild(object);
			}
			newLevel.appendChild(obstacles);
			
			xml.appendChild(newLevel);
			
			file = new File("C:/Users/sdodge/Documents/GravPuzzle/src/MapEditor/LevelCreation/levels.xml");
			//file = File.applicationDirectory;
			//file = file.resolvePath(fileLocation);
			trace(file.nativePath);
			var writeStream:FileStream = new FileStream();
			writeStream.open(file,FileMode.WRITE);
			writeStream.writeUTFBytes(xml.toXMLString());
			writeStream.close();
		}
		
	}
}