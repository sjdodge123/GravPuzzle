package GameObjects.HitRegions
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.MobileObject;
	import GameObjects.Mobile.Obstacles.Square;

	public class HitBox extends HitRegion
	{
		private var box:Sprite;
		public function HitBox(spawnX:int,spawnY:int,width:int,height:int,alpha:Number)
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
			if((object.newX+object.radius>this.x) && (object.x+object.radius<this.x) && (object.y - object.radius<this.y+box.height) && (object.y + object.radius>this.y)) //outerLeft
			{
				object.velX = -object.velX * .65;
			}
			if((object.newX-object.radius<this.x+box.width) && (object.x-object.radius>this.x+box.width) && (object.y - object.radius<this.y+box.height) && (object.y + object.radius>this.y)) //outerRight
			{
				object.velX = -object.velX * .65;
			}
			if((object.newY+object.radius > this.y) && (object.y+object.radius < this.y) && (object.x > this.x) && (object.x < this.x+box.width)) //outerTop
			{
				object.velY = -object.velY * .65;
			}
			if((object.newY-object.radius < this.y+box.height) && (object.y-object.radius > this.y+box.height) && (object.x + object.radius> this.x) && (object.x - object.radius< this.x+box.width)) //outerBottom
			{
				object.velY = -object.velY * .65;
			}
			object.calcChange(dt);
		}
	}
}