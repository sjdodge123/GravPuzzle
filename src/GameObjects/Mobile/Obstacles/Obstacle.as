package GameObjects.Mobile.Obstacles
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import GameObjects.HitRegions.HitRegion;
	import GameObjects.Mobile.MobileObject;

	public class Obstacle extends MobileObject
	{
		protected var hitRegion:Vector.<HitRegion> = new Vector.<HitRegion>;
		
		public function Obstacle()
		{
		}
		
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			for(var i:int=0;i<hitRegion.length;i++)
			{
				hitRegion[i].checkBounds(object,dt);	
			}
		}
		public function getHitRegion():Vector.<HitRegion>
		{
			return hitRegion;
		}
		
	}
}