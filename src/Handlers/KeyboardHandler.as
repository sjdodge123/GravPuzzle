package Handlers
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Events.KeyEvent;
	import flash.events.MouseEvent;

	public class KeyboardHandler extends EventDispatcher
	{
		public function KeyboardHandler(gameStage:Stage)
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardInput);
			gameStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightClick);
			//gameStage.addEventListener(MouseEvent.MIDDLE_CLICK, middleClick);
		}
		
		protected function middleClick(event:MouseEvent):void
		{
			dispatchEvent(new KeyEvent(KeyEvent.F12_PRESSED,null));
		}
		
		protected function rightClick(event:MouseEvent):void
		{
			dispatchEvent(new KeyEvent(KeyEvent.SPACE_PRESSED,null));			
		}
		protected function keyboardInput(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
				{
					dispatchEvent(new KeyEvent(KeyEvent.SPACE_PRESSED,null));
					break;
				}
				case Keyboard.F12:
				{
					dispatchEvent(new KeyEvent(KeyEvent.F12_PRESSED,null));
					break;
				}
			}
		}			
	}
}