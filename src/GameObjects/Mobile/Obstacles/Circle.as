package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	
	import GameObjects.EditRegions.EditRect;
	import GameObjects.HitRegions.HitCircle;
	import GameObjects.HitRegions.HitRegion;

	public class Circle extends Obstacle
	{
		private var image:Sprite;
		private var hitCircle:HitCircle;
		
		public function Circle(x:int,y:int,radius:int)
		{
			
			this.x = x;
			this.y = y;
			this.radius = radius;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0x8E2323);
			image.graphics.drawCircle(0,0,radius);
			addChild(image);
			//adds hitboxes to square
			hitCircle = new HitCircle(x,y,radius,0);
			hitRegion = new Vector.<HitRegion>;
			hitRegion.push(hitCircle);
			editRegion = new EditRect(radius,radius);
			addChild(editRegion);
			super();
		}
	}
}