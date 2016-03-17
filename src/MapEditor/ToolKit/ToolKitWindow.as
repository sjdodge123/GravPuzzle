package MapEditor.ToolKit
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.MouseEvent;
	import Construct.GameBoard;
	import MapEditor.LevelCreation.LevelWrite.LevelWriter;

	public class ToolKitWindow extends EventDispatcher
	{
		private var window:NativeWindow;
		private var options:NativeWindowInitOptions;
		public var active:Boolean = false;
		private var toolBelt:ToolBelt;
		private var gameBoard:GameBoard;
		private var levelWriter:LevelWriter;
		
		
		public function ToolKitWindow(gameBoard:GameBoard)
		{
			options = new NativeWindowInitOptions();
			levelWriter = new LevelWriter();
			
			this.gameBoard = gameBoard;
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
			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			window.stage.align = StageAlign.TOP_LEFT;
			toolBelt = new ToolBelt(window.stage,mainWindow.stage,gameBoard);
			toolBelt.addEventListener(MouseEvent.CLICK,saveLevel);
		}
		
		protected function saveLevel(event:Event):void
		{
			levelWriter.createLevel(gameBoard.getCurrentLevel());
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