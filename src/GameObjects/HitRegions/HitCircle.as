package GameObjects.HitRegions
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.MobileObject;

	public class HitCircle extends HitRegion
	{
		private var circle:Sprite;
		private var radius:int;
		public function HitCircle(spawnX:int,spawnY:int,radius:int,alpha:Number)
		{
			this.x = spawnX;
			this.y = spawnY;
			this.radius = radius;
			circle = new Sprite();
			circle.graphics.clear();
			circle.graphics.beginFill(0x000000,alpha);
			circle.graphics.drawCircle(0,0,radius);
			addChild(circle);
		}
		
		public override function checkBounds(object:MobileObject,dt:Number):void
		{
			if(circle.hitTestObject(object)){
				object.velY = -object.velY * .65;
				object.velX = -object.velX * .65;
				object.calcChange(dt);
			}
			
		}
	}
}