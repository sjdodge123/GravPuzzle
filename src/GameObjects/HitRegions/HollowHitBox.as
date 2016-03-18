package GameObjects.HitRegions
{
	import flash.display.Sprite;
	
	import Events.ObstacleEvent;
	
	import GameObjects.Mobile.MobileObject;

	public class HollowHitBox extends HitRegion
	{
		private var box:Sprite;
		private var firstTimeOnly:Boolean = true;
		public function HollowHitBox(spawnX:int,spawnY:int,width:int,height:int,alpha:Number)
		{
			this.x = spawnX;
			this.y = spawnY;
			box = new Sprite();
			box.graphics.clear();
			box.graphics.beginFill(0x000000,alpha);
			box.graphics.drawRect(0,0,width,height);
			addChild(box);
		}
		public override function checkBounds(object:MobileObject,dt:Number):void
		{
			
			if(this.hitTestObject(object))
			{
				if(firstTimeOnly)
				{
					firstTimeOnly = false;
					this.dispatchEvent(new ObstacleEvent(ObstacleEvent.DEADZONE,object));
				}
				
			}
		}
	}
}