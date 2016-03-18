package MapEditor.ToolKit
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import Construct.GameBoard;
	
	import Events.LevelEditEvent;
	
	import GameObjects.Mobile.MobileObject;

	public class Editor extends Sprite
	{
		private var gameBoard:GameBoard;
		private var editingObject:MobileObject;
		private var mainWindow:Stage;
		private var toolBelt:ToolBelt;
		private var scaleX:Number;
		private var scaleY:Number;
		public function Editor(toolWindow:Stage, mainWindow:Stage,gameBoard:GameBoard)
		{
			this.gameBoard = gameBoard;
			this.mainWindow = mainWindow;
			
			toolBelt = new ToolBelt(toolWindow.stage,mainWindow.stage,gameBoard);
			
			//Used to look for objects that the mouse is currently touching
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,scanForObjects);
			
			
			mainWindow.addEventListener(MouseEvent.MOUSE_WHEEL,zoomOut);
			mainWindow.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN,mapPanOn);
			mainWindow.addEventListener(MouseEvent.MIDDLE_MOUSE_UP,mapPanOff);
		}
		
		protected function mapPanOn(event:MouseEvent):void
		{
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,pan);
		}
		
		protected function pan(event:MouseEvent):void
		{
			var mouse:Point = new Point(event.stageX,event.stageY);
			var grabPoint:Point = gameBoard.globalToLocal(mouse);
			grabPoint.x -= mouse.x*scaleX;
			grabPoint.y -= mouse.y*scaleY;
			gameBoard.x += grabPoint.x;
			gameBoard.y += grabPoint.y;
		}
		
		protected function mapPanOff(event:MouseEvent):void
		{
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,pan);
		}
		
		protected function zoomOut(event:MouseEvent):void
		{
			
			gameBoard.scaleX += event.delta * .1;
			gameBoard.scaleY += event.delta * .1;
			scaleX = gameBoard.scaleX;
			scaleY = gameBoard.scaleY;
			gameBoard.x = mainWindow.stage.stageWidth/2 - gameBoard.width/2;
			gameBoard.y = mainWindow.stage.stageHeight/2-gameBoard.height/2;
		}
		
		protected function scanForObjects(event:MouseEvent):void
		{
			var editArray:Vector.<MobileObject> = gameBoard.getMobileObjectsUnderPoint(new Point(event.stageX-gameBoard.getCameraX(),event.stageY-gameBoard.getCameraY()));
			for(var i:int=0;i<editArray.length;i++)
			{
				if(!editArray[i].hasEventListener(MouseEvent.CLICK))
				{
					editArray[i].addEventListener(MouseEvent.CLICK,editArray[i].edit);
					editArray[i].addEventListener(LevelEditEvent.GRAB_CENTER,centerObjectToMouse);
					editArray[i].addEventListener(LevelEditEvent.GRAB_X,manipulateX);
					editArray[i].addEventListener(LevelEditEvent.GRAB_Y,manipulateY);
				}
				
			}
			
		}
		
		protected function manipulateY(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,moveHeightWithMouse);
		}
		
		protected function moveHeightWithMouse(event:MouseEvent):void
		{
			editingObject.height = event.stageY-editingObject.height/2+20;
			mainWindow.addEventListener(MouseEvent.CLICK,endEdit);
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
			mainWindow.addEventListener(MouseEvent.CLICK,endEdit);
		}
		
		protected function endEdit(event:MouseEvent):void
		{
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,movePointWithMouse);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,moveWidthWithMouse);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,moveHeightWithMouse);
			mainWindow.removeEventListener(MouseEvent.CLICK,endEdit);
			mainWindow.removeEventListener(MouseEvent.CLICK,endEdit);
		}
		
		public function stopAllEdits():void
		{
			gameBoard.stopAllEdits();	
		}
	}
}