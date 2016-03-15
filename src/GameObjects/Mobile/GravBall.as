package GameObjects.Mobile
{
	import flash.display.Sprite;
	import GameObjects.Mobile.MobileObject;

	public class GravBall extends MobileObject
	{
		private var shape:Sprite;
		public function GravBall(x:int,y:int)
		{
			this.x = x;
			this.y = y;
			shape = new Sprite();
			shape.graphics.clear();
			shape.graphics.beginFill(0x000000);
			shape.graphics.lineStyle(2, 0xC0C0C0, 100);
			shape.graphics.drawCircle(0,0, radius);
			shape.useHandCursor = false;
			addChild(shape);
		}
	}
}