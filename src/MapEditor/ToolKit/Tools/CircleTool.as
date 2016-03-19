package MapEditor.ToolKit.Tools
{
	import GameObjects.Mobile.Obstacles.Circle;
	import MapEditor.LevelCreation.LevelRead.ObstacleData;

	public class CircleTool extends Tool
	{
		private var radius:int;
		public function CircleTool()
		{
			toolWidth = 50;
			toolHeight = 50;
			radius = 25;
			tool = new Circle(toolOffsetX+radius,toolOffsetY+radius,radius);
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
			toolData.type = "Circle";
			toolData.x = x;
			toolData.y = y;
			toolData.radius = radius;
			return toolData;
		}
		
		protected override function pickUpTool(mouseX:int,mouseY:int):void
		{
			toolInHand = true;
			attachedTool = new Circle(mouseX,mouseY,radius);
			addChild(attachedTool);
		}
		
		public override function drawToolInHand(mouseX:int,mouseY:int):void
		{
			if(this.contains(attachedTool))
			{
				removeChild(attachedTool);
			}
			attachedTool = new Circle(mouseX,mouseY,radius);
			addChild(attachedTool);
		}
		
		public override function buildTool(mouseX:Number, mouseY:Number):void
		{
			attachedTool = new Circle(mouseX,mouseY,radius);
		}
	}
}