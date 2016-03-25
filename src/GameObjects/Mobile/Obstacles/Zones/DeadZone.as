package GameObjects.Mobile.Obstacles.Zones
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Events.ObstacleEvent;
	
	import GameObjects.EditRegions.EditRect;
	import GameObjects.HitRegions.HitRegion;
	import GameObjects.HitRegions.HollowHitBox;

	public class DeadZone extends Zone
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
			hitBox = new HollowHitBox(x,y,width,height,0,ObstacleEvent.DEADZONE);
			hitBox.addEventListener(ObstacleEvent.DEADZONE,forwardEvent);
			hitRegion = new Vector.<HitRegion>;
			hitRegion.push(hitBox);
			editRegion = new EditRect(width,height);
			addChild(editRegion);
		}
	}
}