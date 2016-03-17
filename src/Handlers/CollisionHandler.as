package Handlers
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.MobileObject;
	import GameObjects.Mobile.Obstacles.Obstacle;

	public class CollisionHandler
	{
		public function CollisionHandler()
		{
		}
		
		
		public function checkBounds(object:MobileObject, obstacles:Vector.<Obstacle>, basket:BallBasket, dt:Number):void
		{
			for(var i:int=0;i<obstacles.length; i++)
			{
				obstacles[i].checkBounds(object,dt);
			}
			basket.checkBounds(object,dt);
		}
	}
}