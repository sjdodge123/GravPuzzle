package GameObjects.EditRegions
{
	import flash.display.Sprite;

	public class EditRect extends EditRegion
	{
		private var boxWidth:int;
		private var boxHeight:int;
		
		public function EditRect(width:int,height:int)
		{
			this.boxWidth = width;
			this.boxHeight = height;
		}
		
		public override function drawBorder():void
		{
			border.graphics.lineStyle(2,0x72BCD4);
			border.graphics.drawRect(-5,-5,boxWidth+10,boxHeight+10);
			addChild(border);
			
			editCenterBall.graphics.beginFill(0x72BCD4);
			editCenterBall.graphics.drawCircle(boxWidth/2,boxHeight/2,5);
			editCenterBall.graphics.endFill();
			
			editXLine.graphics.lineStyle(2,0x72BCD4);
			editXLine.graphics.moveTo(-5,boxHeight/2);
			editXLine.graphics.lineTo(-25,boxHeight/2);
			addChild(editXLine);
			
			
			editYLine.graphics.lineStyle(2,0x72BCD4);
			editYLine.graphics.moveTo(boxWidth/2,-5);
			editYLine.graphics.lineTo(boxWidth/2,-25);
			addChild(editYLine);
			
			editBallX.graphics.beginFill(0x72BCD4);
			editBallX.graphics.drawCircle(-25,boxHeight/2,5);
			editBallX.graphics.endFill();
			
			editBallY.graphics.beginFill(0x72BCD4);
			editBallY.graphics.drawCircle(boxWidth/2,-25,5);
			editBallY.graphics.endFill();
			
			
			addChild(editBallY);
			addChild(editCenterBall);
			addChild(editBallX);
		}
	}
}