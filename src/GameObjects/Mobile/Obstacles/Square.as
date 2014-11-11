package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.FriendBall;

	public class Square extends Obstacle
	{
		private var image:Sprite;
		public var hitBoxes:Vector.<HitBox>;
		private var hitBox:HitBox;
		private var hitBox2:HitBox;
		
		public function Square(x:int,y:int,width:int)
		{
			this.x = x;
			this.y = y;
			image = new Sprite();
			image.graphics.clear();
			image.graphics.beginFill(0x8E2323);
			image.graphics.drawRect(0,0,width,width);
			image.useHandCursor = false;
			addChild(image);
			
			
			//adds hitboxes to square
			hitBox = new HitBox(x,y,width);
			hitBoxes = new Vector.<HitBox>;
			hitBoxes.push(hitBox);
		
			
		}
		public override function checkBounds(friendBall:FriendBall,dt:Number):void
		{
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(friendBall,dt);
			}
		}
	}
}