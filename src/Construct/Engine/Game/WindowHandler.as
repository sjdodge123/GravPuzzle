package Construct.Engine.Game
{
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;
	
	import Construct.GameBoard;
	
	import Events.EngineControlEvent;
	
	import MapEditor.ToolKit.ToolKitWindow;

	public class WindowHandler extends EventDispatcher
	{
		private var toolKit:ToolKitWindow;
		private var mainWindow:NativeWindow;
		private var width:int;
		private var height:int;
		public function WindowHandler(mainWindow:NativeWindow,gameBoard:GameBoard)
		{
			this.mainWindow = mainWindow;
			toolKit = new ToolKitWindow(gameBoard);
			mainWindow.addEventListener(Event.CLOSING,onClose);
			mainWindow.addEventListener(NativeWindowBoundsEvent.MOVE,windowMove);
			mainWindow.width = 800;
			mainWindow.height = 600;
		}
		
		public function getWidth():int
		{
			return mainWindow.width;
		}
		
		public function getHeight():int
		{
			return mainWindow.height;
		}
		
		
		protected function windowMove(event:NativeWindowBoundsEvent):void
		{
			toolKit.move(event);
		}
		
		protected function onClose(event:Event):void
		{
			if(event.currentTarget == toolKit)
			{
				toolKit.removeEventListener(Event.CLOSING,onClose);
				this.dispatchEvent(new EngineControlEvent(EngineControlEvent.RESUME_ENGINE,null));
			}
			else
			{
				toolKit.close();
			}
		}
		
		public function levelEdit(event:Event):void
		{
			if(toolKit.active == false)
			{
				this.dispatchEvent(new EngineControlEvent(EngineControlEvent.PAUSE_ENGINE,null));
				toolKit.addEventListener(Event.CLOSING,onClose);
				toolKit.activate(mainWindow);
			}
			else
			{
				toolKit.close();
				toolKit.removeEventListener(Event.CLOSING,onClose);
				this.dispatchEvent(new EngineControlEvent(EngineControlEvent.RESUME_ENGINE,null));
			}
			
		}
	}
}