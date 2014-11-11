package GameObjects.Mobile.Obstacles
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.FriendBall;

	public class HitBox extends Sprite
	{
		private var box:Sprite;
		public function HitBox(spawnX:int,spawnY:int,width:int)
		{
			
			this.x = spawnX;
			this.y = spawnY;
			box = new Sprite();
			box.graphics.clear();
			box.graphics.drawRect(0,0,width,width);
			box.useHandCursor = false;
			useHandCursor = false;
			addChild(box);
		}
		public function checkBounds(friendBall:FriendBall,dt:Number):void
		{
			
			if((friendBall.newX+friendBall.radius>this.x) && (friendBall.x+friendBall.radius<this.x) && (friendBall.y - friendBall.radius<this.y+box.height) && (friendBall.y + friendBall.radius>this.y)) //outerLeft
			{
				friendBall.velX = -friendBall.velX * .65;
				friendBall.calcChange(dt);
			}
			if((friendBall.newX-friendBall.radius<this.x+box.width) && (friendBall.x-friendBall.radius>this.x+box.width) && (friendBall.y - friendBall.radius<this.y+box.height) && (friendBall.y + friendBall.radius>this.y)) //outerRight
			{
				friendBall.velX = -friendBall.velX * .65;
				friendBall.calcChange(dt);
			}
			if((friendBall.newY+friendBall.radius > this.y) && (friendBall.y+friendBall.radius < this.y) && (friendBall.x + friendBall.radius> this.x) && (friendBall.x - friendBall.radius < this.x+box.width)) //outerTop
			{
				friendBall.velY = -friendBall.velY * .65;
				friendBall.calcChange(dt);
				
			}
			if((friendBall.newY-friendBall.radius < this.y+box.height) && (friendBall.y-friendBall.radius > this.y+box.height) && (friendBall.x + friendBall.radius> this.x) && (friendBall.x - friendBall.radius< this.x+box.width)) //outerBottom
			{
				friendBall.velY = -friendBall.velY * .65;
				friendBall.calcChange(dt);
			}
		}
	}
}