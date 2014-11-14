package
{
	import flash.display.Sprite;
	import Construct.Engine.Game.Game;
	
	public class GravPuzzle extends Sprite
	{
		private var game:Game;
		public function GravPuzzle()
		{
			game = new Game(stage);
		}
	}
}