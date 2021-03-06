package GameObjects.Mobile
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class Camera extends Sprite
	{
		private var world:Sprite;
		private var view:Rectangle;
		private var padding:int = 30;
		
		
		public function Camera(xOffset:int,yOffset:int,gameWidth:int,gameheight:int)
		{
			view = new Rectangle(xOffset,yOffset,gameWidth,gameheight);
		}
		
		public function move(objects:Vector.<MobileObject>):void
		{
			var xAmt:int = 0;
			var yAmt:int = 0;
			for each ( var object:MobileObject in objects){
				
				//Left side of screen
				if(object.x - padding < view.x){
					xAmt = -object.x + padding;
				}
				//Right side of screen
				if(object.x + padding > view.width){
					xAmt = -object.x - padding + view.width;
				}
				
				//Top of the screen
				if(object.y - padding < view.y){
					yAmt = -object.y + padding;
				}
				
				//Bottom of the screen
				if(object.y + padding > view.height){
					yAmt = -object.y - padding + view.height;
				}
				
				view.x = xAmt;
				view.y = yAmt;
				//var mag:Number = Math.sqrt(xAmt*xAmt+yAmt*yAmt);
				//object.scaleX = .5*mag;
				//object.scaleY = .5*mag;
			}
			
			this.x = view.x;
			this.y = view.y;
		}
	}
}