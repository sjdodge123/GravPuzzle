package GameObjects
{
	import flash.display.Sprite;

	public class GravBall extends Sprite
	{
		private var circle:Sprite;
		public var radius:int = 10;
		public function GravBall(x:int,y:int)
		{
			this.x = x;
			this.y = y;
			circle = new Sprite();
			circle.graphics.clear();
			circle.graphics.beginFill(0x000000);
			circle.graphics.lineStyle(2, 0xC0C0C0, 100);
			circle.graphics.drawCircle(0,0, radius);
			circle.useHandCursor = false;
			addChild(circle);
		}
	}
}