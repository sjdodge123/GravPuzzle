package GameObjects.Mobile.Obstacles.Zones
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Events.ObstacleEvent;
	
	import GameObjects.HitRegions.HitRegion;
	import GameObjects.HitRegions.HollowHitBox;

	public class BlackZone extends Zone
	{
		private var image:Sprite;
		private var hitBox:HollowHitBox;
		
		public function BlackZone(x:int,y:int,width:int, height:int)
		{
			
			this.x = x;
			this.y = y;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0x191919);
			image.graphics.drawRect(0,0,width,height);
			addChild(image);
			
			//adds hitboxes to square
			hitBox = new HollowHitBox(x,y,width,height,0,ObstacleEvent.BLACKZONE);
			hitBox.addEventListener(ObstacleEvent.BLACKZONE,forwardEvent);
			hitRegion = new Vector.<HitRegion>;
			hitRegion.push(hitBox);
			super();
			
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