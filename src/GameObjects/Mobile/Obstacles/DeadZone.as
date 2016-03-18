package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Events.ObstacleEvent;
	
	import GameObjects.HitRegions.HitRegion;
	import GameObjects.HitRegions.HollowHitBox;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.MobileObject;

	public class DeadZone extends Obstacle
	{
		private var image:Sprite;
		private var hitBox:HollowHitBox;
		
		public function DeadZone(x:int,y:int,width:int, height:int)
		{
			this.x = x;
			this.y = y;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0xFFCC00);
			image.graphics.drawRect(0,0,width,height);
			addChild(image);
			
			//adds hitboxes to square
			hitBox = new HollowHitBox(x,y,width,height,0);
			hitBox.addEventListener(ObstacleEvent.DEADZONE,preventOverlap);
			hitRegion = new Vector.<HitRegion>;
			hitRegion.push(hitBox);
		}
		
		private function preventOverlap(event:ObstacleEvent):void
		{
			var sendVector:Vector.<MobileObject> = new Vector.<MobileObject>;
			var friend:FriendBall = FriendBall(event.params);
			sendVector.push(this);
			sendVector.push(friend);
			dispatchEvent(new ObstacleEvent(ObstacleEvent.DEADZONE,sendVector));
		}
		
		public override function edit(event:Event):void
		{
			trace('edit');
			this.drawBorder();
			this.removeEventListener(MouseEvent.CLICK,edit);
			this.addEventListener(MouseEvent.CLICK,editObject);
		}
		
		public override function editObject(event:MouseEvent):void
		{
			trace('make edits');
		}
		protected override function drawBorder():void
		{
			border = new Sprite();
			border.graphics.lineStyle(2,0x72BCD4);
			border.graphics.drawCircle(0,0,50);
			addChild(border);
		}
	}
}