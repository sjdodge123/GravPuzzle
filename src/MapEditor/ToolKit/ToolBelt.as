package MapEditor.ToolKit
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import Construct.GameBoard;
	
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	import MapEditor.ToolKit.Tools.SquareTool;
	import MapEditor.ToolKit.Tools.Tool;

	public class ToolBelt
	{
		private var squareTool:Tool;
		private var toolStage:Stage;
		private var mainStage:Stage;
		private var gameBoard:GameBoard;
		public function ToolBelt(toolStage:Stage,mainStage:Stage,gameBoard:GameBoard)
		{
			squareTool = new SquareTool();
			this.toolStage = toolStage;
			this.mainStage = mainStage;
			this.gameBoard = gameBoard;
			mainStage.addEventListener(MouseEvent.MOUSE_MOVE,mainMouseMove);
			mainStage.addEventListener(MouseEvent.CLICK,mouseClicked);
			toolStage.addEventListener(MouseEvent.MOUSE_MOVE,toolMouseMove);
			toolStage.addChild(squareTool);
		}
		
		protected function mainMouseMove(event:MouseEvent):void
		{
			if(squareTool.toolInHand)
			{
				removeDeadContainerObjects();
				squareTool.buildTool(event.stageX,event.stageY);
				mainStage.addChild(squareTool.attachedTool);
			}
			
		}
		
		
		protected function toolMouseMove(event:MouseEvent):void
		{
			if(squareTool.toolInHand)
			{
				removeDeadContainerObjects();
				squareTool.drawToolInHand(event.stageX,event.stageY);
			}
			
		}
		
		
		protected function mouseClicked(event:MouseEvent):void
		{
			
			/*
			if(contains(border))
			{
				this.removeChild(border);
			}
			*/
			if(squareTool.toolInHand)
			{
				squareTool.dropTool(mainStage);
				gameBoard.addObstacleToBoard(squareTool.placeTool(event.stageX-gameBoard.getCameraX(),event.stageY-gameBoard.getCameraY()));
			}
			
		}
		
		private function removeDeadContainerObjects():void
		{
			if(mainStage.contains(squareTool.attachedTool))
			{
				mainStage.removeChild(squareTool.attachedTool);
			}
			if(squareTool.contains(squareTool.attachedTool))
			{
				squareTool.removeChild(squareTool.attachedTool);
			}
		}
		
	}
}