package MapEditor.ToolKit.Tools
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;
	
	import MapEditor.LevelCreation.LevelRead.ObstacleData;

	public class Tool extends Sprite
	{
		protected var border:Sprite;
		protected var color:uint;
		
		protected var visible:int = 0;
		public var toolInHand:Boolean = false;
		
		protected var tool:Obstacle;
		protected var toolWidth:int;
		protected var toolHeight:int;
		
		protected var toolOffsetX:int = 5;
		protected var toolOffsetY:int = 5;
		
		public var attachedTool:Obstacle = new Square(1,1,1,1);;
		
		public function Tool()
		{
			border = new Sprite();
			border.graphics.lineStyle(1,0,0);
			border.graphics.drawRect(toolOffsetX,toolOffsetY,50,50);
			this.addChild(border);
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			this.addEventListener(MouseEvent.CLICK,mouseClicked);
			this.addEventListener(MouseEvent.RIGHT_CLICK,rightClick);
		}
		
		
		
		protected function mouseClicked(event:MouseEvent):void
		{
			if(contains(border))
			{
				this.removeChild(border);
			}
			if(toolInHand)
			{
				dropTool();
			}
			else
			{
				pickUpTool(event.stageX,event.stageY);
			}
			
		}
		
		public function placeTool(x:int,y:int):ObstacleData
		{
			//Implemented in tool
			return new ObstacleData();
		}
		
		protected function mouseOver(evt:MouseEvent):void
		{
			visible = 1;
			color = 0x0000FF;
			border.graphics.lineStyle(1,color,visible);
			border.graphics.drawRect(5,5,50,50);
			this.addChild(border);
			this.removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
		}
		
		protected function mouseOut(event:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			if(contains(border))
			{
				this.removeChild(border);
			}
				
		}
		
		protected function rightClick(evt:MouseEvent):void
		{
			if(!dropTool(this.stage))
			{
				resizeTool();
			}
		}
		
		public function dropTool(stage:Stage=null):Boolean
		{
			if(stage == null && toolInHand){
				toolInHand = false;
				if(contains(attachedTool))
				{
					removeChild(attachedTool);
				}
				if(this.contains(border))
				{
					this.removeChild(border);
				}
				return true;
			}
			if(toolInHand)
			{
				toolInHand = false;
				if(stage.contains(attachedTool))
				{
					stage.removeChild(attachedTool);
				}
				return true;
			}
			return false;
		}
		
		private function resizeTool():void
		{
			//Find which obstacle the mouse is currently highlighting
			//Show the border of that tool
			//Allow user to click a border line and expand that dimension
		}
		
		protected function  pickUpTool(mouseX:int,mouseY:int):void
		{
			//Implmented in tools themselves
		}
		
		public function drawToolInHand(mouseX:int,mouseY:int):void
		{
			//Implmented in tools themselves
		}
		
		public function changeStage(stage:Stage):void
		{
			//Implmented in tools themselves
		}
		
		
		public function buildTool(stageX:Number, stageY:Number):void
		{
			//Implmented in tools themselves
		}
	}
}