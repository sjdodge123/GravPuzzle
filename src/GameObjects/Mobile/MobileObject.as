package GameObjects.Mobile
{
	import flash.display.Sprite;

	public class MobileObject extends Sprite
	{
		public const radius:int = 10;
		public var accel:Number=0;
		public var newX:Number = 0;
		public var newY:Number = 0;
		public var velX:Number = 0;
		public var velY:Number =0;
		public var shape:Sprite;
		protected var velocity:Number;
		protected var dirX:Number =0;
		protected var dirY:Number=0;
		protected const gravConstant:Number = 10;
		public function MobileObject()
		{
			
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