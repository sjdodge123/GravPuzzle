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

	public class Editor extends Sprite
	{
		private var gameBoard:GameBoard;
		private var editingObject:MobileObject;
		private var mainWindow:Stage;
		private var toolBelt:ToolBelt;
		private var scaleX:Number;
		private var scaleY:Number;
		private var onlyOnce:Boolean = true;
		public function Editor(toolWindow:Stage, mainWindow:Stage,gameBoard:GameBoard)
		{
			this.gameBoard = gameBoard;
			this.mainWindow = mainWindow;
			
			toolBelt = new ToolBelt(toolWindow.stage,mainWindow.stage,gameBoard);
			
			//Used to look for objects that the mouse is currently touching
			mainWindow.addEventListener(MouseEvent.CLICK,scanForObjects);
			
			//Edit Camera Control
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
				mainWindow.removeEventListener(MouseEvent.CLICK,scanForObjects);
				editArray[i].edit();
				editArray[i].addEventListener(LevelEditEvent.GRAB_CENTER,centerObjectToMouse);
				editArray[i].addEventListener(LevelEditEvent.GRAB_X,manipulateX);
				editArray[i].addEventListener(LevelEditEvent.GRAB_Y,manipulateY);
				editArray[i].addEventListener(LevelEditEvent.EXIT,endEdit);
				return;
			}
			
		}
		
		// After clicking object's center
		protected function centerObjectToMouse(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,movePointWithMouse);	
		}
		// After clicking object's y axis
		protected function manipulateY(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,moveHeightWithMouse);
		}
		
		// After clicking object's x axis
		protected function manipulateX(event:LevelEditEvent):void
		{
			editingObject = MobileObject(event.params);
			mainWindow.addEventListener(MouseEvent.MOUSE_MOVE,moveWidthWithMouse);
		}
		
		//Mechanics to actually edit the object
		protected function moveHeightWithMouse(event:MouseEvent):void
		{
			editingObject.height = event.stageY-editingObject.height/2+20;
			addEndListener();
		}
		//Mechanics to actually edit the object
		protected function moveWidthWithMouse(event:MouseEvent):void
		{
			editingObject.width = event.stageX-editingObject.width/2+20;
			addEndListener();
		}
		//Mechanics to actually edit the object
		protected function movePointWithMouse(event:MouseEvent):void
		{
			editingObject.x = event.stageX-editingObject.width/2+20;
			editingObject.y = event.stageY-editingObject.height/2;
			addEndListener();
		}
		
		private function addEndListener():void
		{
			if(onlyOnce){
				onlyOnce = false;
				mainWindow.addEventListener(MouseEvent.CLICK,endCurrentAction);
			}
		}
		
		//Stop edit mechanic
		protected function endCurrentAction(event:MouseEvent):void
		{
			onlyOnce = true;
			mainWindow.removeEventListener(MouseEvent.CLICK,endCurrentAction);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,movePointWithMouse);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,moveWidthWithMouse);
			mainWindow.removeEventListener(MouseEvent.MOUSE_MOVE,moveHeightWithMouse);
		}
		
		protected function endEdit(event:LevelEditEvent):void
		{
			mainWindow.addEventListener(MouseEvent.CLICK,scanForObjects);
		}
		
		public function stopAllEdits(event:Event):void
		{
			endEdit(null);
			gameBoard.stopAllEdits();	
		}
		
		public function dropAllTools():void
		{
			toolBelt.dropAllTools(null);
		}
	}
}