package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;

	public class Wall extends Obstacle
	{
		private var image:Sprite;
		public function Wall(x:int,y:int)
		{
			this.x = x;
			this.y = y;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0x8E2323);
			image.graphics.drawRect(0,0,3,20);
			image.useHandCursor = false;
			addChild(image);
			
		}
	}
}