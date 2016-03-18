package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class FriendBall extends MobileObject
	{
		private var shape:Sprite;
		public function FriendBall(x:int, y:int)
		{
			super();
			this.x = x;
			this.y = y;
			shape = new Sprite();
			shape.graphics.clear();
			shape.graphics.beginFill(0xBDFCC9);
			shape.graphics.lineStyle(2, 0xC0C0C0, 100);
			shape.graphics.drawCircle(0,0, radius);
			shape.useHandCursor = false;
			addChild(shape);
		}
	}
}