package GameObjects.EditRegions
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Events.LevelEditEvent;

	public class EditRegion extends Sprite
	{
		protected var editXLine:Sprite;
		protected var editYLine:Sprite;
		
		protected var border:Sprite;
		protected var editBallX:Sprite;
		protected var editBallY:Sprite;
		protected var editCenterBall:Sprite;
		
		public function EditRegion()
		{
			border = new Sprite();
			editBallX = new Sprite();
			editBallY = new Sprite();
			editCenterBall = new Sprite();
			editXLine = new Sprite();
			editYLine = new Sprite();
		}
		
		public function drawBorder():void{}
		
		public function editObject(event:MouseEvent):String
		{
			if(editCenterBall.hitTestPoint(event.stageX,event.stageY))
			{
				trace('grab center');
				return LevelEditEvent.GRAB_CENTER;
			}
			if(editBallX.hitTestPoint(event.stageX,event.stageY))
			{
				trace('grab x axis');
				return LevelEditEvent.GRAB_X;
			}
			if(editBallY.hitTestPoint(event.stageX,event.stageY))
			{
				trace('grab y axis');
				return LevelEditEvent.GRAB_Y;
			}
			return "";
		}
		
		public function removeBorder():void {
			if(contains(border)){
				removeChild(border);
			}
			if(contains(editXLine)){
				removeChild(editXLine);
			}
			if(contains(editYLine)){
				removeChild(editYLine);
			}
			if(contains(editBallX)){
				removeChild(editBallX);
			}
			if(contains(editBallY)){
				removeChild(editBallY);
			}
			if(contains(editCenterBall)){
				removeChild(editCenterBall);
			}
			
		}
	}
}