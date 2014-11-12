package GameObjects.Mobile.Obstacles
{
	import GameObjects.Mobile.MobileObject;

	public class Obstacle extends MobileObject
	{
		public var hitBoxes:Vector.<HitBox> = new Vector.<HitBox>;
		
		public function Obstacle()
		{
		}
		
		// !TODO! Add collision for a wall obstacle here !TODO!
		
		
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(object,dt);
			}
		}
		public function getHitBoxes():Vector.<HitBox>
		{
			return hitBoxes;
		}
	}
}