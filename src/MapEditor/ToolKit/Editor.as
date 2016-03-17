package MapEditor.ToolKit
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import Construct.GameBoard;
	
	import Events.LevelEditEvent;
	
	import GameObjects.Mobile.MobileObject;
	import GameObjects.Mobile.Obstacles.Square;

	public class Editor extends Sprite
	{
		private var gameBoard:GameBoard;
		private var editingObject:MobileObject;
		private var mainWindow:Stage;
		public function Editor(mainWindow:Stage,gameBoard:GameBoard)
		{
			this.gameBoard = gameBoard;
			this.mainWindow = mainWindow;
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		
		protected function mouseMove(event:MouseEvent):void
		{
			var editArray:Vector.<MobileObject> = gameBoard.getMobileObjectsUnderPoint(new Point(event.stageX-gameBoard.getCameraX(),event.stageY-gameBoard.getCameraY()));
			for(var i:int=0;i<editArray.length;i++)
			{
				if(!editArray[i].hasEventListener(MouseEvent.CLICK))
				{
					editArray[i].addEventListener(MouseEvent.CLICK,editArray[i].edit);
					editArray[i].addEventListener(LevelEditEvent.GRAB_CENTER,centerObjectToMouse);
					editArray[i].addEventListener(LevelEditEvent.GRAB_X,manipulateX);
				}
				if(!editArray[i].hasEventListener(MouseEvent.MOUSE_OUT))
				{
					//editArray[i].addEventListener(MouseEvent.MOUSE_OUT, editArray[i].endEdit);
				}
				
				
			}
			
		}
		
		protected function manipulateX(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,moveWidthWithMouse);
		}
		
		protected function moveWidthWithMouse(event:MouseEvent):void
		{
			editingObject.width = event.stageX-editingObject.width/2+20;
			mainWindow.addEventListener(MouseEvent.CLICK,endEdit);
		}
		
		protected function centerObjectToMouse(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,movePointWithMouse);	
		}
		
		protected function movePointWithMouse(event:MouseEvent):void
		{
			editingObject.x = event.stageX-editingObject.width/2+20;
			editingObject.y = event.stageY-editingObject.height/2;
			editingObject.addEventListener(MouseEvent.CLICK,endEdit);
		}
		
		protected function endEdit(event:MouseEvent):void
		{
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,movePointWithMouse);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,moveWidthWithMouse);
			mainWindow.removeEventListener(MouseEvent.CLICK,endEdit);
			editingObject.removeEventListener(MouseEvent.CLICK,endEdit);
		}
		
	}
}