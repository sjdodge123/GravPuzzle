package GameObjects.Mobile
{
	import flash.display.Sprite;
	import Events.LevelStateEvent;
	
	import GameObjects.HitRegions.HitBox;

	public class BallBasket extends MobileObject
	{
		private var rectangle:Sprite;
		private var rectangleTop:Sprite;
		private var radius:int = 10;
		private var boxWidth:int = 45;
		private var boxHeight:int = 20;
		
		private var goal:Sprite;
		public var hitBoxes:Vector.<HitBox>;
		
		private var hitLeft:HitBox;
		private var hitRight:HitBox;
		private var hitBottom:HitBox;
		
		private var displayHidden:int = 0;
	
		public function BallBasket(x:int, y:int,width:int=45,height:int=20)
		{
			this.x = x;
			this.y = y;
			boxWidth = width;
			boxHeight = height;
			draw();
		}
		
		public override function draw():void
		{
			rectangle = new Sprite();
			rectangle.graphics.clear();
			rectangle.graphics.beginFill(0x8E2323);
			rectangle.graphics.lineStyle(2,0xC0C0C0, 100);
			rectangle.graphics.drawRect(0,0,boxWidth,boxHeight);
			rectangle.useHandCursor = false;
			addChild(rectangle);
			
			
			rectangleTop = new Sprite();
			rectangleTop.graphics.clear();
			rectangleTop.graphics.beginFill(0xFFFF00);
			rectangleTop.graphics.drawRect(0,0,boxWidth,boxHeight-15);
			rectangleTop.useHandCursor = false;
			addChild(rectangleTop);
			
			goal = new Sprite();
			goal.graphics.clear();
			goal.graphics.beginFill(0xFFFF00,displayHidden);
			goal.graphics.drawRect(0,0,boxWidth,boxHeight-5);
			goal.useHandCursor = false;
			addChild(goal);
			
			hitLeft = new HitBox(x,y+5,1,boxHeight-5,displayHidden);
			hitRight = new HitBox(x+boxWidth,y+5,1,boxHeight-5,displayHidden);
			hitBottom = new HitBox(x,y+boxHeight-1,boxWidth,boxHeight-(boxHeight-1),displayHidden);
			hitBoxes = new Vector.<HitBox>;
			hitBoxes.push(hitLeft);
			hitBoxes.push(hitRight);
			hitBoxes.push(hitBottom);	
			
		}
		
		public function getHitBoxes():Vector.<HitBox>
		{
			return hitBoxes;
		}
		
		public function checkBounds(object:MobileObject,dt:Number):void
		{
			for(var i:int=0;i<hitBoxes.length;i++)
			{
				hitBoxes[i].checkBounds(object,dt);
			}
			//win condition
			if (goal.hitTestPoint(object.x+object.getRadius(),object.y+object.getRadius()))
			{
				trace("Victory! On to next level!");
				dispatchEvent(new LevelStateEvent(LevelStateEvent.WIN_LEVEL,null));
			}			
		}
		
		protected override function drawBorder():void
		{
			border = new Sprite();
			border.graphics.lineStyle(2,0x72BCD4);
			border.graphics.drawRect(-5,-5,boxWidth+10,boxHeight+10);
			addChild(border);
			
			editCenterBall = new Sprite();
			editCenterBall.graphics.beginFill(0x72BCD4);
			editCenterBall.graphics.drawCircle(boxWidth/2,boxHeight/2,5);
			editCenterBall.graphics.endFill();
			
			editXLine = new Sprite();
			editXLine.graphics.lineStyle(2,0x72BCD4);
			editXLine.graphics.moveTo(-5,boxHeight/2);
			editXLine.graphics.lineTo(-25,boxHeight/2);
			addChild(editXLine);
			
			
			editYLine = new Sprite();
			editYLine.graphics.lineStyle(2,0x72BCD4);
			editYLine.graphics.moveTo(boxWidth/2,-5);
			editYLine.graphics.lineTo(boxWidth/2,-25);
			addChild(editYLine);
			
			editBallX = new Sprite();
			editBallX.graphics.beginFill(0x72BCD4);
			editBallX.graphics.drawCircle(-25,boxHeight/2,5);
			editBallX.graphics.endFill();
			
			editBallY = new Sprite();
			editBallY.graphics.beginFill(0x72BCD4);
			editBallY.graphics.drawCircle(boxWidth/2,-25,5);
			editBallY.graphics.endFill();
			addChild(editBallY);
			
			exitBall = new Sprite();
			exitBall.graphics.beginFill(0xFF4C4C);
			exitBall.graphics.drawCircle(border.width-5,-(border.height/4),5);
			exitBall.graphics.endFill();

			addChild(exitBall);
			addChild(editCenterBall);
			addChild(editBallX);
		}
	}
}