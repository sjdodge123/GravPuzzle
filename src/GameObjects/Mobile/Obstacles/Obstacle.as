package GameObjects.Mobile.Obstacles
{
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.MobileObject;

	public class Obstacle extends MobileObject
	{
		private var hitBoxes:Vector.<HitBox>;
		
		public function Obstacle()
		{
		}
		
		// !TODO! Add collision for a wall obstacle here !TODO!
		
		
		public function checkBounds(friendBall:FriendBall,dt:Number):void
		{
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(friendBall,dt);
			}
		}
	}
}