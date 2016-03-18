package GameObjects.Mobile.Obstacles.Zones
{
	import Events.ObstacleEvent;
	
	import GameObjects.Mobile.FriendBall;
	import GameObjects.Mobile.MobileObject;
	import GameObjects.Mobile.Obstacles.Obstacle;
	
	public class Zone extends Obstacle
	{
		public function Zone()
		{
			
		}
		
		protected function forwardEvent(event:ObstacleEvent):void
		{
			var sendVector:Vector.<MobileObject> = new Vector.<MobileObject>;
			var friend:FriendBall = FriendBall(event.params);
			sendVector.push(this);
			sendVector.push(friend);
			dispatchEvent(new ObstacleEvent(event.type,sendVector));
		}
	}
}