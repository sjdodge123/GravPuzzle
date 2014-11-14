package Construct.Engine.Game
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Construct.GameBoard;
	
	import Events.EngineControlEvent;
	import Events.KeyEvent;
	
	import Handlers.KeyboardHandler;
	
	public class Game
	{
		private var mainWindow:WindowHandler;
		private var mainStage:Stage;
		private var keyboardHandler:KeyboardHandler;
		private var gravity:Number = 100;
		private var coolDownReady:Boolean = true;
		private var justDeleted:Boolean = true;
		private var clickCooldown:Timer;
		private var deleteCooldown:Timer;
		private var resetTimer:Timer;
		private var dt:Number = 1;
		private var gameBoard:GameBoard;
	
		public function Game(mainStage:Stage)
		{
			this.mainStage = mainStage;
			mainWindow = new WindowHandler(mainStage.nativeWindow);
			mainWindow.addEventListener(EngineControlEvent.RESUME_ENGINE,resumeUpdates);
			mainWindow.addEventListener(EngineControlEvent.PAUSE_ENGINE,pauseUpdates);
			keyboardHandler = new KeyboardHandler(mainStage);
			gameBoard = new GameBoard(mainStage);
			mainStage.addEventListener(Event.ENTER_FRAME,update);
			mainStage.addEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
			keyboardHandler.addEventListener(KeyEvent.F12_PRESSED,mainWindow.levelEdit);
			clickCooldown = new Timer(500,1);
			clickCooldown.addEventListener(TimerEvent.TIMER,resetCooldown);
			deleteCooldown = new Timer(50,1);
			deleteCooldown.addEventListener(TimerEvent.TIMER,resetDeleteCooldown);
			resetTimer = new Timer(2000,1);
			resetTimer.addEventListener(TimerEvent.TIMER,resetResetTimer); //love the naming scheme, sorry in advance
			mainStage.addChild(gameBoard);
		}
		
		protected function pauseUpdates(event:Event):void
		{
			gameBoard.pause();
			mainStage.removeEventListener(Event.ENTER_FRAME,update);
			mainStage.removeEventListener(MouseEvent.CLICK,mouseClick);
		}
		
		protected function resumeUpdates(event:Event):void
		{
			gameBoard.resume();
			mainStage.addEventListener(Event.ENTER_FRAME,update);
			mainStage.addEventListener(MouseEvent.CLICK,mouseClick);
		}
		
		protected function resetResetTimer(event:TimerEvent):void
		{
			mainStage.addEventListener(Event.ENTER_FRAME,update);
			mainStage.addEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
			gameBoard.resetLevel(null);
		}
		
		protected function reset(event:Event):void
		{
			trace('restarting in 2 seconds');
			resetTimer.reset();
			resetTimer.start();
			mainStage.removeEventListener(Event.ENTER_FRAME,update);
			mainStage.removeEventListener(MouseEvent.CLICK,mouseClick);
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