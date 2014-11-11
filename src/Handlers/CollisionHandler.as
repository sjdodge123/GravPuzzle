package Handlers
{
	import GameObjects.Mobile.BallBasket;
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.Obstacles.Obstacle;

	public class CollisionHandler
	{
		public function CollisionHandler()
		{
		}
		
		
		public function checkBounds(friendBall:FriendBall, obstacles:Vector.<Obstacle>, basket:BallBasket, dt:Number):void
		{
			for(var i:int=0;i<obstacles.length; i++)
			{
				obstacles[i].checkBounds(friendBall,dt);
			}
			basket.checkBounds(friendBall,dt);
			
		}
	}
}