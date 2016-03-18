package MapEditor.ToolKit
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;
	
	import Construct.GameBoard;
	
	import Events.PanelEvent;
	
	import MapEditor.LevelCreation.LevelWrite.LevelWriter;
	import MapEditor.ToolKit.ControlPanel.Panel;

	public class ToolKitWindow extends EventDispatcher
	{
		private var window:NativeWindow;
		private var options:NativeWindowInitOptions;
		public var active:Boolean = false;
		private var gameBoard:GameBoard;
		private var levelWriter:LevelWriter;
		private var controlPanel:Panel;
		private var editor:Editor;
		
		
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
			
			editor = new Editor(window.stage,mainWindow.stage,gameBoard);
			controlPanel = new Panel(0,window.stage.stageHeight-100,200,100,gameBoard.getCurrentLevelNumber(),gameBoard.getLevelCount());
			controlPanel.addEventListener(PanelEvent.CREATE_LEVEL,createLevel);
			controlPanel.addEventListener(PanelEvent.DOWN_LEVEL,previousLevel);
			controlPanel.addEventListener(PanelEvent.UP_LEVEL,nextLevel);
			window.stage.addChild(controlPanel);
		}
		
		protected function nextLevel(event:Event):void
		{
			gameBoard.nextLevel(null);
		}
		
		protected function previousLevel(event:Event):void
		{
			gameBoard.previousLevel(null);
			
		}
		
		protected function createLevel(event:Event):void
		{
			editor.stopAllEdits();
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