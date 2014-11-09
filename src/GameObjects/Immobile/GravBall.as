package GameObjects.Immobile
{
	import flash.display.Sprite;

	public class GravBall extends Sprite
	{
		private var shape:Sprite;
		public var radius:int = 10;
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