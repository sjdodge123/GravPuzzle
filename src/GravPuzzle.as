package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Levels.LevelOne;
	
	public class GravPuzzle extends Sprite
	{
		private var levelOne:LevelOne;
		private var gravity:Number = 100;
		private var coolDownReady:Boolean = true;
		private var clickCoolDown:Timer;
		private var dt:Number = 1;
		public function GravPuzzle()
		{
			stage.addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,mouseClick);
			clickCoolDown = new Timer(2000,1);
			clickCoolDown.addEventListener(TimerEvent.TIMER,resetCooldown);
			levelOne = new LevelOne();
			addChild(levelOne);
		}
		protected function resetCooldown(event:TimerEvent):void
		{
			coolDownReady = true;
		}
		
		protected function mouseClick(event:MouseEvent):void
		{
			if(!coolDownReady)
			{
				levelOne.checkDeletions(event.stageX,event.stageY);
			}
			else
			{
				levelOne.mouseClick(event.stageX,event.stageY);
				coolDownReady = false;
				clickCoolDown.reset();
				clickCoolDown.start();
			}
		}
		
		protected function update(event:Event):void
		{
			levelOne.update(dt);			
		}
	}
}