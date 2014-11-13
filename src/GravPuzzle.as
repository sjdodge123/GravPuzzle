package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Construct.GameBoard;
	import Construct.Engine.Game.Game;
	
	import Events.KeyEvent;
	
	import Handlers.KeyboardHandler;
	
	import MapEditor.ToolKitWindow;
	
	public class GravPuzzle extends Sprite
	{
		private var game:Game;

		
		public function GravPuzzle()
		{
			game = new Game(stage);
		}
		
	
		
		
		
	}
}