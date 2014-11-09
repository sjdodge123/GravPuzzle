package InputHandler
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import Events.KeyEvent;

	public class KeyboardHandler extends EventDispatcher
	{
		private var reset:Boolean;
		public function KeyboardHandler(gameStage:Stage)
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardInput);
			gameStage.addEventListener(Event.ENTER_FRAME, updateKeys);

		}
		
		protected function updateKeys(event:Event):void
		{
			if(reset)
			{
				dispatchEvent(new KeyEvent(KeyEvent.SPACE_PRESSED,null));
				reset = false;
			}
		}
		
		protected function keyboardInput(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
				{
					reset = true;
					break;
				}
			}
		}		

		
		
	}
}