package GameObjects
{
	import flash.display.Sprite;

	public class BallBasket extends Sprite
	{
		private var rectangle:Sprite;
		private var rectangleTop:Sprite;
		private var radius:int = 10;
		public function BallBasket(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			rectangle = new Sprite();
			rectangle.graphics.clear();
			rectangle.graphics.beginFill(0x8E2323);
			rectangle.graphics.lineStyle(2,0xC0C0C0, 100);
			rectangle.graphics.drawRect(0,0,45,20);
			rectangle.useHandCursor = false;
			addChild(rectangle);
			
			
			rectangleTop = new Sprite();
			rectangleTop.graphics.clear();
			rectangleTop.graphics.beginFill(0xFFFF00);
			rectangleTop.graphics.drawRect(0,0,45,5);
			rectangleTop.useHandCursor = false;
			addChild(rectangleTop);
		}
	}
}