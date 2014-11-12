package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.MobileObject;

	public class Square extends Obstacle
	{
		private var image:Sprite;
		public var hitBoxes:Vector.<HitBox>;
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
			hitBox = new HitBox(x,y,width,height);
			hitBoxes = new Vector.<HitBox>;
			hitBoxes.push(hitBox);
		
			
		}
		public override function checkBounds(object:MobileObject,dt:Number):void
		{
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(object,dt);
			}
		}
	}
}