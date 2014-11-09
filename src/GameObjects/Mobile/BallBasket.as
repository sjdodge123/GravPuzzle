package GameObjects.Mobile
{
	import flash.display.Sprite;

	public class BallBasket extends MobileObject
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
		
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			var objX:int = object.newX;
			var objY:int = object.newY;
			var objRadius:int = object.radius;
			if((objX+objRadius+2>this.x) && (object.x+objRadius<this.x) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) //2 padding necessary..
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			if((objX-objRadius-2<this.x+rectangle.width) && (object.x-objRadius>this.x+rectangle.width) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) //2 padding necessary
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			if((objY-objRadius<this.y+rectangle.height) && (object.x-objRadius<this.x+rectangle.width) && (object.x+objRadius>this.x))
			{
				object.velY = -object.velY * .65;
				object.calcChange(dt);
			}
			
			//if collision checks out return false
			
		}
	}
}