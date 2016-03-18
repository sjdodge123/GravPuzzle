package MapEditor.ToolKit.Tools
{
	import flash.events.MouseEvent;
	
	import GameObjects.Mobile.Obstacles.Zones.BlackZone;
	
	import MapEditor.LevelCreation.LevelRead.ObstacleData;
	
	public class BlackZoneTool extends Tool
	{
		private var name:String = "BlackZone";
		
		public function BlackZoneTool()
		{
			super();
			toolWidth = 50;
			toolHeight = 50;
			tool = new BlackZone(toolOffsetX,toolOffsetY,toolWidth,toolHeight);
			this.addChild(tool);
		}
		
		public override function placeTool(x:int,y:int):ObstacleData
		{
			toolInHand = false;
			if(contains(attachedTool))
			{
				removeChild(attachedTool);
			}
			var toolData:ObstacleData = new ObstacleData();
			toolData.type = name;
			toolData.x = x-toolWidth/2;
			toolData.y = y-toolHeight/2;
			toolData.width = toolWidth;
			toolData.height = toolHeight;
			return toolData;
		}
		
		protected override function pickUpTool(mouseX:int,mouseY:int):void
		{
			toolInHand = true;
			attachedTool = new BlackZone(mouseX-toolWidth/2,mouseY-toolHeight/2,toolWidth,toolHeight);
			addChild(attachedTool);
		}
		
		public override function drawToolInHand(mouseX:int,mouseY:int):void
		{
			if(this.contains(attachedTool))
			{
				removeChild(attachedTool);
			}
			attachedTool = new BlackZone(mouseX-toolWidth/2,mouseY-toolHeight/2,toolWidth,toolHeight);
			addChild(attachedTool);
		}
		
		public override function buildTool(mouseX:Number, mouseY:Number):void
		{
			attachedTool = new BlackZone(mouseX-toolWidth/2,mouseY-toolHeight/2,toolWidth,toolHeight);
		}
	}
}

