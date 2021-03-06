package MapEditor.ToolKit
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import Construct.GameBoard;
	
	import Events.LevelEditEvent;
	import MapEditor.ToolKit.Tools.BlackZoneTool;
	import MapEditor.ToolKit.Tools.CircleTool;
	import MapEditor.ToolKit.Tools.DeadZoneTool;
	import MapEditor.ToolKit.Tools.SquareTool;
	import MapEditor.ToolKit.Tools.Tool;

	public class ToolBelt extends EventDispatcher
	{
		private var toolStage:Stage;
		private var mainStage:Stage;
		private var gameBoard:GameBoard;
		private var toolList:Vector.<Tool>;
		private var oneTime:Boolean = true;
		public function ToolBelt(toolStage:Stage,mainStage:Stage,gameBoard:GameBoard)
		{
			this.toolStage = toolStage;
			this.mainStage = mainStage;
			this.gameBoard = gameBoard;
			
			toolList = new Vector.<Tool>();
			
			toolList.push(new SquareTool());
			toolList.push(new CircleTool());
			toolList.push(new DeadZoneTool());
			toolList.push(new BlackZoneTool());
			toolList.push(new SquareTool());
			toolList.push(new SquareTool());
			toolList.push(new SquareTool());
			toolList.push(new SquareTool());
			toolList.push(new SquareTool());
			
			addToolsToStage();
			
			mainStage.addEventListener(MouseEvent.MOUSE_MOVE,mainMouseMove);
			mainStage.addEventListener(MouseEvent.CLICK,mouseClicked);
			mainStage.addEventListener(MouseEvent.RIGHT_CLICK,dropAllTools);
			toolStage.addEventListener(MouseEvent.RIGHT_CLICK,dropAllTools);
			toolStage.addEventListener(MouseEvent.MOUSE_MOVE,toolMouseMove);	
		}
		
		private function addToolsToStage():void
		{
			var rows:int = 0;
			var columns:int = 0;
			for(var i:int=0; i<toolList.length;i++)
			{
				if(i % 3 == 0)
				{
					columns++;
					rows = 1;
				} else {
					rows++;
				}
				toolList[i].y = ((columns-1)*60)+ 2;
				toolList[i].x = ((rows-1)*60) + 2;
				toolStage.addChild(toolList[i]);
			}
		}
		
		protected function saveClicked(event:MouseEvent):void
		{
			this.dispatchEvent(event);
		}
		
		protected function mainMouseMove(event:MouseEvent):void
		{
			for each (var tool:Tool in toolList)
			{
				if(tool.toolInHand)
				{
					removeDeadContainerObjects();
					tool.buildTool(event.stageX,event.stageY);
					mainStage.addChild(tool.attachedTool);
					preventEdit();
				}
			}
			
		}
		
		protected function toolMouseMove(event:MouseEvent):void
		{
			for each (var tool:Tool in toolList)
			{
				if(tool.toolInHand)
				{
					removeDeadContainerObjects();
					tool.drawToolInHand(event.stageX,event.stageY);
				}
			}
		}
		
		
		protected function mouseClicked(event:MouseEvent):void
		{
			for each ( var tool:Tool in toolList)
			{
				if(tool.toolInHand)
				{
					tool.dropTool(mainStage);
					gameBoard.addObstacleToBoard(tool.placeTool(event.stageX-gameBoard.getCameraX(),event.stageY-gameBoard.getCameraY()));
					allowEdit();
				}
			}
		}
		
		private function removeDeadContainerObjects():void
		{
			for each ( var tool:Tool in toolList)
			{
				if(mainStage.contains(tool.attachedTool))
				{
					mainStage.removeChild(tool.attachedTool);
				}
				if(tool.contains(tool.attachedTool))
				{
					tool.removeChild(tool.attachedTool);
				}
			}
		}
		
		public function dropAllTools(event:Event):void
		{
			for each ( var tool:Tool in toolList)
			{
				tool.toolInHand = false;
				allowEdit();
				removeDeadContainerObjects();
			}
		}
		
		private function preventEdit():void
		{
			if(oneTime){
				oneTime = false;
				dispatchEvent(new LevelEditEvent(LevelEditEvent.PREVENT_EDIT,null));
			}
		}
		private function allowEdit():void
		{
			oneTime = true;
			dispatchEvent(new LevelEditEvent(LevelEditEvent.ALLOW_EDIT,null));
		}
		
	}
}