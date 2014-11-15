package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	
	public class Square extends Obstacle
	{
		private var image:Sprite;
		private var hitBox:HitBox;
		
		public function Square(x:int,y:int,width:int, height:int)
		{
			this.x = x;
			this.y = y;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0x8E2323);
			image.graphics.drawRect(0,0,width,height);
			image.useHandCursor = false;
			addChild(image);
			//adds hitboxes to square
			hitBox = new HitBox(x,y,width,height,0);
			hitBoxes = new Vector.<HitBox>;
			hitBoxes.push(hitBox);
		
			
		}
	}
}