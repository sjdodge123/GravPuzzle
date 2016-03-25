package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Events.LevelEditEvent;
	
	import GameObjects.EditRegions.EditRect;
	import GameObjects.EditRegions.EditRegion;
	

	public class MobileObject extends Sprite
	{
		protected var radius:int = 10;
		public var accel:Number= 0;
		public var newX:Number = 0;
		public var newY:Number = 0;
		public var velX:Number = 0;
		public var velY:Number =0;
		protected var velocity:Number;
		protected var dirX:Number =0;
		protected var dirY:Number=0;
		protected const gravConstant:Number = 10;
		protected var shape:Sprite;
		protected var editRegion:EditRegion;
		
		private var justPlaced:Boolean = false;;
		public function MobileObject()
		{
			shape = new Sprite();
			editRegion = new EditRect(width,height);
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
		
		public function editObject(event:MouseEvent):void
		{
			var newEventType:String = editRegion.editObject(event);
			if(newEventType != ""){
				this.dispatchEvent(new LevelEditEvent(newEventType,this));
			}
		}
		
		public function edit():void
		{
				trace('edit');
				editRegion.drawBorder();
				this.addEventListener(MouseEvent.CLICK,editObject);
				if(this as FriendBall){
					endEdit();
				}
		}
		
		public function endEdit():void
		{
			trace('end edit');
			editRegion.removeBorder();
			this.removeEventListener(MouseEvent.CLICK,editObject);
		}
		
		public function editWidth(value:Number):void
		{
			shape.width = value;
		}
		
		public function editHeight(value:Number):void
		{
			shape.height = value;
		}
		
		
		public function getRadius():int
		{
			return radius;
		}
	}
}