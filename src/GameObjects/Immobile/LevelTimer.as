package GameObjects.Immobile
{
	import flash.utils.Timer;

	public class LevelTimer
	{
		private var dt:Number;
		private var elapsedTime:Number = 0;
		private var timer:Timer;
		private var previousTime:Number;
		private var newTime:Number;	
		
		public function LevelTimer()
		{
			timer = new Timer(0,0);
			timer.start();
			previousTime = timer.currentCount;
		}
		
		public function reset():void
		{
			elapsedTime = 0;
			newTime = 0;
			previousTime = timer.currentCount;
		}
		
		public function stop():void
		{
			timer.stop();
		}
		
		public function update(dt:Number):Number
		{
			newTime = timer.currentCount;
			dt =  newTime-previousTime;
			previousTime = newTime;
			elapsedTime += dt;
			return elapsedTime/100;
		}
		
		public function getElapsedTime():Number
		{
			return elapsedTime/100;
		}
		
		public function start():void
		{
			timer.start();	
		}
	}
}