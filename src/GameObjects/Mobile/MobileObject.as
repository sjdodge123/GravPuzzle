package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Events.LevelEditEvent;

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
		
		protected var editXLine:Sprite;
		protected var editYLine:Sprite;
		
		protected var border:Sprite;
		protected var editBallX:Sprite;
		protected var editBallY:Sprite;
		protected var editCenterBall:Sprite;
		protected var exitBall:Sprite;
		
		public function MobileObject()
		{
			border = new Sprite();
			editBallX = new Sprite();
			editBallY = new Sprite();
			editCenterBall = new Sprite();
			exitBall = new Sprite();
			editXLine = new Sprite();
			editYLine = new Sprite();
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
		
		public function editObject(event:MouseEvent):void
		{
			if(editCenterBall.hitTestPoint(event.stageX,event.stageY))
			{
				this.dispatchEvent(new LevelEditEvent(LevelEditEvent.GRAB_CENTER,this));
			}
			if(editBallX.hitTestPoint(event.stageX,event.stageY))
			{
				this.dispatchEvent(new LevelEditEvent(LevelEditEvent.GRAB_X,this));
			}
			
			if(exitBall.hitTestPoint(event.stageX,event.stageY))
			{
				endEdit(null);
			}
			
			if(editBallY.hitTestPoint(event.stageX,event.stageY))
			{
				this.dispatchEvent(new LevelEditEvent(LevelEditEvent.GRAB_Y,this));
			}
		}
		
		public function edit(event:Event):void
		{
			trace('edit');
			this.drawBorder();
			this.removeEventListener(MouseEvent.CLICK,edit);
			this.addEventListener(MouseEvent.CLICK,editObject);
		}
		
		public function endEdit(event:Event):void
		{
			this.removeBorder();
			this.removeEventListener(MouseEvent.CLICK,edit);
			this.removeEventListener(MouseEvent.CLICK,editObject);
		}
		
		protected function removeBorder():void {
			if(contains(border)){
				removeChild(border);
			}
			if(contains(editXLine)){
				removeChild(editXLine);
			}
			if(contains(editYLine)){
				removeChild(editYLine);
			}
			if(contains(exitBall)){
				removeChild(exitBall);
			}
			if(contains(editBallX)){
				removeChild(editBallX);
			}
			if(contains(editBallY)){
				removeChild(editBallY);
			}
			if(contains(editCenterBall)){
				removeChild(editCenterBall);
			}
			
		}
		
		public function getRadius():int
		{
			return radius;
		}
	}
}