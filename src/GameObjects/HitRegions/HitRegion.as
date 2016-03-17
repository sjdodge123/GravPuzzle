package GameObjects.HitRegions
{
	import flash.display.Sprite;
	
	import GameObjects.Mobile.MobileObject;

	public class HitRegion extends Sprite
	{
		public function HitRegion()
		{
		}
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			//Implemented in HitObjects
		}
	}
}