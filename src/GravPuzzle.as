package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.NativeWindowBoundsEvent;
	import Construct.GameBoard;
	
	import Events.KeyEvent;
	
	import Handlers.KeyboardHandler;
	
	import MapEditor.ToolKitWindow;
	
	public class GravPuzzle extends Sprite
	{
		private var gravity:Number = 100;
		private var coolDownReady:Boolean = true;
		private var justDeleted:Boolean = true;
		private var clickCooldown:Timer;
		private var deleteCooldown:Timer;
		private var resetTimer:Timer;
		private var keyboardHandler:KeyboardHandler;
		private var dt:Number = 1;
		private var gameBoard:GameBoard;
		private var toolKit:ToolKitWindow;
		
		public function GravPuzzle()
		{
			
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.nativeWindow.addEventListener(Event.CLOSING,onClose);
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.MOVE,windowMove);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler = new KeyboardHandler(stage);
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
			keyboardHandler.addEventListener(KeyEvent.F12_PRESSED,levelEdit);
			clickCooldown = new Timer(500,1);
			clickCooldown.addEventListener(TimerEvent.TIMER,resetCooldown);
			deleteCooldown = new Timer(50,1);
			deleteCooldown.addEventListener(TimerEvent.TIMER,resetDeleteCooldown);
			resetTimer = new Timer(2000,1);
			resetTimer.addEventListener(TimerEvent.TIMER,resetResetTimer); //love the naming scheme, sorry in advance
			gameBoard = new GameBoard(stage);
			toolKit = new ToolKitWindow();
			addChild(gameBoard);

			
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
				stage.addEventListener(Event.ENTER_FRAME,update);
				stage.addEventListener(MouseEvent.CLICK,mouseClick);
			}
			else
			{
				toolKit.close();
			}
		}
		
		protected function levelEdit(event:Event):void
		{
			if(toolKit.active == false)
			{
				stage.removeEventListener(Event.ENTER_FRAME,update);
				stage.removeEventListener(MouseEvent.CLICK,mouseClick);
				toolKit.addEventListener(Event.CLOSING,onClose);
				toolKit.activate(stage);
			}
			else
			{
				toolKit.close();
				toolKit.removeEventListener(Event.CLOSING,onClose);
				stage.addEventListener(Event.ENTER_FRAME,update);
				stage.addEventListener(MouseEvent.CLICK,mouseClick);
			}
			
		}
		
		protected function resetResetTimer(event:TimerEvent):void
		{
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
			gameBoard.resetLevel();
			
		}
		
		protected function reset(event:Event):void
		{
			trace('restarting in 2 seconds');
			resetTimer.reset();
			resetTimer.start();
			stage.removeEventListener(Event.ENTER_FRAME,update);
			stage.removeEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler.removeEventListener(KeyEvent.SPACE_PRESSED,reset);
		}
		
		protected function resetDeleteCooldown(event:TimerEvent):void
		{
			justDeleted = false;
			
		}
		protected function resetCooldown(event:TimerEvent):void
		{
			coolDownReady = true;
		}
		
		protected function mouseClick(event:MouseEvent):void
		{
			
			justDeleted = gameBoard.checkDeletions(event.stageX,event.stageY);
			if(justDeleted)
			{	
				deleteCooldown.reset();
				deleteCooldown.start();
			}
			if(coolDownReady && !justDeleted)
			{
				gameBoard.spawnGravBall(event.stageX,event.stageY);
				coolDownReady = false;
				clickCooldown.reset();
				clickCooldown.start();
			}
		}
		
		protected function update(event:Event):void
		{
			gameBoard.update(dt);	
		}
		
	}
}