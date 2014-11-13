package Construct.Engine.Game
{
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	
	import Events.EngineControlEvent;
	
	import MapEditor.ToolKitWindow;

	public class WindowHandler extends EventDispatcher
	{
		private var toolKit:ToolKitWindow;
		private var mainWindow:NativeWindow;
		public function WindowHandler(mainWindow:NativeWindow)
		{
			this.mainWindow = mainWindow;
			toolKit = new ToolKitWindow();
			mainWindow.addEventListener(Event.CLOSING,onClose);
			mainWindow.addEventListener(NativeWindowBoundsEvent.MOVE,windowMove);
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