package Construct.Engine.Game
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import Construct.GameBoard;
	import flash.display.DisplayObject;

	public class HUD extends Sprite
	{
		private var timerDisplay:TextField;
		private var goalDisplay:TextField;
		private var gameBoard:GameBoard;
		private var targetWindow:Sprite;
		private var bronzeWindow:Sprite;
		private var goldWindow:Sprite;
		private var silverWindow:Sprite;
		private var goldText:TextField;
		private var silverText:TextField;
		private var bronzeText:TextField;
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
			
			targetWindow  = new Sprite();
			targetWindow.x = stageWidth-25;
			targetWindow.y = stageHeight-45;
			targetWindow.graphics.beginFill(0xFFFF00,0);
			targetWindow.graphics.drawRect(0,0,25,45);
			targetWindow.graphics.endFill();
			addChild(targetWindow);
			
			
			goldWindow  = new Sprite();
			
			goldWindow.x = 0;
			goldWindow.y = 0;
			goldWindow.graphics.beginFill(0xFFD700,1);
			goldWindow.graphics.drawRect(0,0,25,15);
			goldWindow.graphics.endFill();
			
			goldText = new TextField();
			goldText.x = goldWindow.width/4;
			goldText.y = 0;
			goldText.textColor = 0x000000;
			goldText.selectable = false;
			goldText.text = "94";
			goldWindow.addChild(goldText);
			targetWindow.addChild(goldWindow);
			
			silverWindow  = new Sprite();
			silverWindow.x = 0;
			silverWindow.y = 15;
			silverWindow.graphics.beginFill(0xe6e6e6,1);
			silverWindow.graphics.drawRect(0,0,25,15);
			silverWindow.graphics.endFill();
			
			silverText = new TextField();
			silverText.x = silverWindow.width/4;
			silverText.y = 0;
			silverText.textColor = 0x000000;
			silverText.selectable = false;
			silverText.text = "86";
			silverWindow.addChild(silverText);
			targetWindow.addChild(silverWindow);
			
			bronzeWindow  = new Sprite();
			bronzeWindow.x = 0;
			bronzeWindow.y = 30;
			bronzeWindow.graphics.beginFill(0xb9722d,1);
			bronzeWindow.graphics.drawRect(0,0,25,15);
			bronzeWindow.graphics.endFill();
			
			bronzeText = new TextField();
			bronzeText.x = bronzeWindow.width/4;
			bronzeText.y = 0;
			bronzeText.textColor = 0x000000;
			bronzeText.selectable = false;
			bronzeText.text = "75";
			bronzeWindow.addChild(bronzeText);
			
			targetWindow.addChild(bronzeWindow);
			
			
		}
		
		public function update():void
		{
			goldText.text = gameBoard.getGoldTarget();
			silverText.text = gameBoard.getSilverTarget();
			bronzeText.text = gameBoard.getBronzeTarget();
			goalDisplay.text = gameBoard.getGoalText();
			timerDisplay.text = gameBoard.getCurrentScore().toString();
		}
	}
}