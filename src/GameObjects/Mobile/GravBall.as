package GameObjects.Mobile
{
	import flash.display.Sprite;

	public class GravBall extends MobileObject
	{
		private var shape:Sprite;
		public function GravBall(x:int,y:int)
		{
			super();
			this.x = x;
			this.y = y;
			shape = new Sprite();
			shape.graphics.clear();
			shape.graphics.beginFill(0x000000);
			shape.graphics.lineStyle(2, 0xC0C0C0, 100);
			shape.graphics.drawCircle(0,0, radius);
			shape.useHandCursor = false;
			addChild(shape);
		}
		
		protected override function drawBorder():void
		{
			trace('drawing grav ball border');
		}
		protected override function removeBorder():void
		{
			trace('removing grav ball border');
		}
	}
}