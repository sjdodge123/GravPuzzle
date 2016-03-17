package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class MobileObject extends Sprite
	{
		public var radius:int = 10;
		public var accel:Number= 0;
		public var newX:Number = 0;
		public var newY:Number = 0;
		public var velX:Number = 0;
		public var velY:Number =0;
		public var shape:Sprite;
		protected var velocity:Number;
		protected var dirX:Number =0;
		protected var dirY:Number=0;
		protected const gravConstant:Number = 10;
		protected var border:Sprite;
		protected var editLine:Sprite;
		protected var editXLine:Sprite;
		protected var editYLine:Sprite;
		
		protected var editBallX:Sprite;
		protected var editBallY:Sprite;
		protected var editCenterBall:Sprite;
		
		protected var editBalls:Vector.<Sprite>;
		
		public function MobileObject()
		{
			editBalls = new Vector.<Sprite>;
		}
		
		public function draw():void {}
		public function calcChange(dt:Number):void
		{
			newX = this.x + velX* dt;
			newY = this.y + velY* dt;
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
		
		protected function drawBorder():void {}
		
		public function editObject(event:MouseEvent):void{}
		
		public function edit(event:Event):void
		{
			trace('edit');
			this.drawBorder();
			this.removeEventListener(MouseEvent.CLICK,edit);
			this.addEventListener(MouseEvent.CLICK,editObject);
		}
		
		public function endEdit(event:Event):void
		{
			//this.removeBorder();
			//this.addEventListener(MouseEvent.CLICK,edit);
			//this.removeEventListener(MouseEvent.CLICK,editObject);
		}
		
		protected function removeBorder():void {
			if(contains(border)){
				removeChild(border);
			}
			if(contains(editLine)){
				removeChild(editLine);
			}
			if(contains(editXLine)){
				removeChild(editXLine);
			}
			if(contains(editYLine)){
				removeChild(editYLine);
			}
			for(var i:int=0;i<editBalls;i++)
			{
				if(contains(editBalls[i])){
					removeChild(editBalls[i]);
				}
			}
		}
		
	}
}