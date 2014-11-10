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
			var dx:Number = this.x + (rectangle.width)/2 - object.x;
			var dy:Number = this.y + (rectangle.height)/2 - object.y;
			var dL:Number = Math.sqrt(dx*dx+dy*dy);
			
			/*fairly ghetto-rigged at the moment.  All the statements result in one of two options: (1) reverse velX (2) reverse velY.
			This all can be cleaned up, which would result in more efficient code that need not check 6 if's each frame. Plus, there almost definitely exist some bugs that could 
			arise from abnormal scenarios (edge collision, moving too slowly/quickly even). Primary change of the logic of our original statements: 
			We were using exclusively objX and objY to determine conditions. This resulted in weird scenarious where the ball could change x and y velocity after collision with a 
			single wall. Now, each condition has just one sub-condition with objX or objY, the latter sub-conditions are determined.
			by the ball's actual position (i.e. object.x and object.y).
			*/
			
			//outer left
			if((objX+objRadius+1>this.x) && (object.x+objRadius<this.x) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) // padding necessary..
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			
			//outer right
			if((objX-objRadius-1<this.x+rectangle.width) && (object.x-objRadius>this.x+rectangle.width) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) // padding necessary
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			
			//outer bottom
			if((objY-objRadius<this.y+rectangle.height) && (object.y-objRadius > this.y+rectangle.height) && (object.x-objRadius<this.x+rectangle.width) && (object.x+objRadius>this.x))
			{
				object.velY = -object.velY * .65;
				object.calcChange(dt);
			}
			
			//inner left
			if((objX-objRadius < this.x) && (object.x+objRadius > this.x) && (object.x-objRadius < this.x+rectangle.width) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) //2 padding necessary..
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			
			//inner right
			if((objX+objRadius + 1 > this.x+rectangle.width) && (object.x+objRadius > this.x) && (object.x-objRadius < this.x+rectangle.width) && (object.y-objRadius<this.y+rectangle.height) && (object.y+objRadius>this.y)) //2 padding necessary..
			{
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			
			//inner bottom
			if((objY+objRadius + 1>this.y+rectangle.height) && (object.y+objRadius < this.y+rectangle.height) && (object.x-objRadius<this.x+rectangle.width) && (object.x+objRadius>this.x))
			{
				object.velY = -object.velY * .65;
				object.calcChange(dt);
			}
			
			//win condition
			if (dL<10)
			{
				trace('victory, bitch');
			}
			//if collision checks out return false
			
		}
	}
}