package GameObjects.Mobile
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.Obstacles.HitBox;

	public class BallBasket extends MobileObject
	{
		private var rectangle:Sprite;
		private var rectangleTop:Sprite;
		private var radius:int = 10;
		public var hitBoxes:Vector.<HitBox>;
		private var hitLeft:HitBox;
		private var hitRight:HitBox;
		private var hitBottom:HitBox;
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
			
			hitLeft = new HitBox(x,y,1,20);
			hitRight = new HitBox(x+44,y,1,20);
			hitBottom = new HitBox(x,y+19,45,1);
			
			hitBoxes = new Vector.<HitBox>;
			hitBoxes.push(hitLeft);
			hitBoxes.push(hitRight);
			hitBoxes.push(hitBottom);

		}
		
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			
			var dx:Number = this.x + (rectangle.width)/2 - object.x;
			var dy:Number = this.y + (rectangle.height)/2 - object.y;
			var dL:Number = Math.sqrt(dx*dx+dy*dy);
			
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(object,dt);
			}
			//win condition
			if (dL<10)
			{
				trace('victory, bitch');
			}			
		}
	}
}