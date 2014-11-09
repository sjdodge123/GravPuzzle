package GameObjects
{
	import flash.display.Sprite;

	public class FriendBall extends Sprite
	{
		
		public const radius:int = 10;
		public var accel:Number=0;
		public var velX:Number =1.5;
		public var newX:Number = 0;
		public var newY:Number = 0;
		private var velocity:Number;
		private var circle:Sprite;
		private var velY:Number =0;
		private var dirX:Number =0;
		private var dirY:Number=0;
		private var gravConstant:Number = 10;
		public function FriendBall(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			circle = new Sprite();
			circle.graphics.clear();
			circle.graphics.beginFill(0xBDFCC9);
			circle.graphics.lineStyle(2, 0xC0C0C0, 100);
			circle.graphics.drawCircle(0,0, radius);
			circle.useHandCursor = false;
			addChild(circle);
		}
		public function calcChange(dt:Number):void
		{
			newX = this.x + velX* dt;
			newY = this.y +  velY* dt;
		}
		public function updatePos():void
		{
			this.x = newX;			
			this.y = newY;
		}
		
		public function updateVel(dt:Number,dx:Number,dy:Number):void
		{
			var distance:Number = Math.sqrt(dx*dx + dy*dy);
			if(distance > 10)
			{
				dirX = dx/distance;
				dirY = dy/distance;
				var accelCont:Number= gravConstant/(distance*distance);
				accel +=  accelCont;
				velX += accel*dt*dirX;
				velY += accel*dt*dirY;
			}
		}
	}
}