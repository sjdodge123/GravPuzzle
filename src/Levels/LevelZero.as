package Levels
{
	public class LevelZero extends Level
	{
		public function LevelZero()
		{
			nextLevel = new LevelOne();
		}
	}
}