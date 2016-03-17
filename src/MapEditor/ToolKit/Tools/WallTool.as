package MapEditor.ToolKit.Tools
{
	import GameObjects.Mobile.Obstacles.Square;
	
	import MapEditor.LevelCreation.LevelRead.ObstacleData;

	public class SquareTool extends Tool
	{
		
		public function SquareTool()
		{
			toolWidth = 50;
			toolHeight = 50;
			tool = new Square(toolOffsetX,toolOffsetY,toolWidth,toolHeight);
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
			toolData.type = "Square";
			toolData.x = x-toolWidth/2;
			toolData.y = y-toolHeight/2;
			toolData.width = toolWidth;
			toolData.height = toolHeight;
			return toolData;
		}
		
		protected override function pickUpTool(mouseX:int,mouseY:int):void
		{
			toolInHand = true;
			attachedTool = new Square(mouseX-toolWidth/2,mouseY-toolHeight/2,toolWidth,toolHeight);
			addChild(attachedTool);
		}
		
		public override function drawToolInHand(mouseX:int,mouseY:int):void
		{
			if(this.contains(attachedTool))
			{
				removeChild(attachedTool);
			}
			attachedTool = new Square(mouseX-toolWidth/2,mouseY-toolHeight/2,toolWidth,toolHeight);
			addChild(attachedTool);
		}
		
		public override function buildTool(stageX:Number, stageY:Number):void
		{
			attachedTool = new Square(stageX-toolWidth/2,stageY-toolHeight/2,toolWidth,toolHeight);
		}
		
	}
}