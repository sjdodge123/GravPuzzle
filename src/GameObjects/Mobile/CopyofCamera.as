package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import Construct.GameBoard;

	public class Camera extends Sprite
	{
		private var world:Sprite;
		private var view:Rectangle = new Rectangle(0,0,300,300);
		private var ease:Number = 0.25;
		private var stageWidth:int;
		private var stageHeight:int;
		private var fakeObject:Sprite;
		
		public function Camera(stageWidth:int,stageHeight:int)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			view.width = this.stageWidth;
			view.height = this.stageHeight;
			world = new Sprite()
			world.graphics.lineStyle(1,0xFF0000,1);
			world.graphics.drawRect(view.x,view.y,view.width,view.height);
			world.graphics.endFill();
			addChild(world);
		}
		
		public function adjust(cameraObjects:Vector.<MobileObject>):void
		{
			for each (var object:MobileObject in cameraObjects)
			{
				
			}
		}
		public function addToWorld(gameBoard:GameBoard):void
		{
			world.addChild(gameBoard);
		}
		
		public function getView():Rectangle
		{
			return view;
		}
	}
}