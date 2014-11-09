package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import Events.KeyEvent;
	
	import InputHandler.KeyboardHandler;
	
	import Levels.LevelOne;
	
	public class GravPuzzle extends Sprite
	{
		private var levelOne:LevelOne;
		private var gravity:Number = 100;
		private var coolDownReady:Boolean = true;
		private var justDeleted:Boolean = true;
		private var startReset:Boolean = false;
		private var clickCooldown:Timer;
		private var deleteCooldown:Timer;
		private var resetTimer:Timer;
		private var keyboardHandler:KeyboardHandler;
		private var countDown:TextField;

		private var dt:Number = 1;
		public function GravPuzzle()
		{
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			
			keyboardHandler = new KeyboardHandler(stage);
			
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
		
			clickCooldown = new Timer(500,1);
			clickCooldown.addEventListener(TimerEvent.TIMER,resetCooldown);
			deleteCooldown = new Timer(50,1);
			deleteCooldown.addEventListener(TimerEvent.TIMER,resetDeleteCooldown);
			resetTimer = new Timer(2000,1);
			resetTimer.addEventListener(TimerEvent.TIMER,resetResetTimer); //love the naming scheme, sorry in advance
			levelOne = new LevelOne();
			addChild(levelOne);
			
			countDown = new TextField();
			countDown.x = 200;
			countDown.y = 200;
			
		}
		
		protected function resetResetTimer(event:TimerEvent):void
		{
			startReset = false;
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			keyboardHandler.addEventListener(KeyEvent.SPACE_PRESSED,reset);
		}
		
		protected function reset(event:Event):void
		{
			startReset = levelOne.reset();
			resetTimer.reset();
			resetTimer.start();
			trace('restarting in 2 seconds');
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
			
			justDeleted = levelOne.checkDeletions(event.stageX,event.stageY);
			if(justDeleted)
			{	
				deleteCooldown.reset();
				deleteCooldown.start();
			}
			if(coolDownReady && !justDeleted)
			{
				levelOne.mouseClick(event.stageX,event.stageY);
				coolDownReady = false;
				clickCooldown.reset();
				clickCooldown.start();
			}
		
			
		}
		
		protected function update(event:Event):void
		{
			levelOne.update(dt);	
		}
	}
}