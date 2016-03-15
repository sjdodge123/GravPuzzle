package Construct.Engine.Game
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import Construct.GameBoard;

	public class HUD extends Sprite
	{
		private var timerDisplay:TextField;
		private var goalDisplay:TextField;
		private var gameBoard:GameBoard;
		public function HUD(stageWidth:int,stageHeight:int,gameBoard)
		{
			this.gameBoard = gameBoard;
			timerDisplay = new TextField();
			timerDisplay.textColor = 0xFF0000;
			timerDisplay.x = stageWidth/2;
			timerDisplay.y = 1;
			timerDisplay.selectable = false;
			addChild(timerDisplay);
			
			goalDisplay = new TextField();
			goalDisplay.textColor = 0xFF0000;
			goalDisplay.width = stageWidth;
			goalDisplay.x =stageWidth/2 + 50;
			goalDisplay.y = 1;
			goalDisplay.selectable = false;
			addChild(goalDisplay);
			
		}
		
		public function update():void
		{
			goalDisplay.text = gameBoard.getGoalText();
			timerDisplay.text = gameBoard.getElapsedTime().toString();
		}
	}
}