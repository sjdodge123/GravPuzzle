package GameLogic
{
	import Construct.GameBoard;
	
	import GameObjects.Mobile.Obstacles.Zones.DeadZone;
	import GameObjects.Mobile.MobileObject;

	public class ZoneLogic
	{
		public function ZoneLogic(gameBoard:GameBoard)
		{
			
		}
		
		public function checkForDeadZone(array:Vector.<MobileObject>):Boolean
		{
			for(var i:int = 0;i<array.length;i++)
			{
				if(array[i] as DeadZone)
				{
					return true;
				}
			}
			return false;
		}
		public function checkForBlackZone():void
		{
			//ADD BLACKZONE LOGIC HERE
			//IMPLEMENT TIMER THAT STARTS IF YOUR FIRST BLACK ZONE AND PERSISTS UNTIL YOU LEAVE
			//TAKE AWAY TIME FROM GAME TIMER FOR DURATION IN BLACK ZONE
			//CALLED FROM GAMEBOARD LINE 398 enterBlackZone()
		}
	}
}