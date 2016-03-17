package MapEditor.ToolKit.ControlPanel
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Events.PanelEvent;

	public class Panel extends Sprite
	{
		private var saveButton:SaveButton;
		private var backround:Sprite;
		private var leftArrow:ArrowButton;
		private var rightArrow:ArrowButton;
		private var levelCounter:TextField;
		private var currentLevel:int = 1;
		private var maxLevels:int = 1;
		public function Panel(x:int,y:int,width:int,height:int,currentLevel:int,maxLevels:int)
		{
			this.x = x;
			this.y = y;
			this.currentLevel = currentLevel;
			this.maxLevels = maxLevels;
			backround = new Sprite();
			backround.graphics.beginFill(0xD3D3D3);
			backround.graphics.drawRect(0,0,width,height);
			backround.graphics.endFill();
			addChild(backround);
			
			rightArrow = new ArrowButton(110,12.5);
			leftArrow = new ArrowButton(60,12.5,1);
			rightArrow.addEventListener(MouseEvent.CLICK,rightClicked);
			leftArrow.addEventListener(MouseEvent.CLICK,leftClicked);
			addChild(rightArrow);
			addChild(leftArrow);
			
			
			levelCounter = new TextField()
			levelCounter.x = 85;
			levelCounter.y = 5;
			levelCounter.width = 10;
			levelCounter.text = currentLevel.toString();
			levelCounter.selectable = false;
			addChild(levelCounter);
			saveButton = new SaveButton(0,height-25,width/2,25);
			saveButton.addEventListener(MouseEvent.CLICK,saveClicked);
			addChild(saveButton);
		}
		
		protected function leftClicked(event:MouseEvent):void
		{
			currentLevel--;
			if(currentLevel < 1)
			{
				currentLevel = maxLevels; 
			} 
			dispatchEvent(new PanelEvent(PanelEvent.DOWN_LEVEL,null));
			levelCounter.text = currentLevel.toString();
			
		}
		
		protected function rightClicked(event:MouseEvent):void
		{
			currentLevel++;
			if(currentLevel > maxLevels)
			{
				currentLevel = 1; 
			} 
			dispatchEvent(new PanelEvent(PanelEvent.UP_LEVEL,null));
			levelCounter.text = currentLevel.toString();
		}
		
		protected function saveClicked(event:MouseEvent):void
		{
			dispatchEvent(new PanelEvent(PanelEvent.CREATE_LEVEL,null));
		}
	}
}