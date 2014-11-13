package MapEditor
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;

	public class ToolKitWindow extends EventDispatcher
	{
		private var window:NativeWindow;
		private var options:NativeWindowInitOptions;
		public var active:Boolean = false;
		public function ToolKitWindow()
		{
			options = new NativeWindowInitOptions();
		}
		
		protected function onClose(event:Event):void
		{
			active = false;
			window.close();
			this.dispatchEvent(event);
		}
		
		public function move(event:NativeWindowBoundsEvent):void
		{
			if(active)
			{
				window.x = event.afterBounds.x + event.afterBounds.width;
				window.y = event.afterBounds.y;
			}		
		}
		
		public function activate(mainWindow:NativeWindow):void
		{
			window = new NativeWindow(options);
			window.title = "ToolKit";
			active = true;
			window.x = mainWindow.x + mainWindow.width;
			window.y = mainWindow.y;
			window.height = mainWindow.height;
			window.width = 200;
			window.addEventListener(Event.CLOSING,onClose);
			window.visible = true;
		}
		public function close():void
		{
			if(active)
			{
				active = false;
				window.visible = false;
				window.close();
			}
		}
	}
}