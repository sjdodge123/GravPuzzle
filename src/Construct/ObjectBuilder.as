package Construct
{
	import flash.events.EventDispatcher;
	
	import Events.ChildEvent;
	
	import GameObjects.Mobile.GravBall;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;
	import GameObjects.Mobile.Obstacles.Circle;
	
	import MapEditor.LevelCreation.LevelRead.ObstacleData;

	public class ObjectBuilder extends EventDispatcher
	{
		private var spawnLocX:int = 0;
		private var spawnLocY:int = 0;
		private var spawnClear:Boolean;
		public function ObjectBuilder()
		{
			
		}
		
		public function buildGravBall(stageX:int,stageY:int,gravityObjects:Vector.<GravBall>,gravBallCount:int):Vector.<GravBall>
		{
			spawnLocX = stageX;
			spawnLocY = stageY;
			if(gravityObjects.length < 1)
			{
				gravityObjects = spawnGravBall(gravityObjects);
				
			}
			for(var i:int=0;i<gravityObjects.length;i++)
			{
				var dx:Number = gravityObjects[i].x - stageX;
				var dy:Number = gravityObjects[i].y - stageY;
				var distance:Number = Math.sqrt(dx*dx + dy*dy);
				if(distance > gravityObjects[i].radius*3)
				{
					spawnClear = true;
					
				}
				else
				{
					spawnClear = false;
					break;
				}
			}
			if(spawnClear)
			{
				gravityObjects = spawnGravBall(gravityObjects);
			}
			if(gravityObjects.length == gravBallCount+1)
			{
				gravityObjects = killGravBall(gravityObjects);
			}
			return gravityObjects;
		}
		
		public function buildObstacle(data:ObstacleData):Obstacle
		{
			var obstacle:Obstacle;
			if(data.type == "Square")
			{
				return new Square(data.x,data.y,data.width,data.height);
			}
			if(data.type == "Circle")
			{
				return new Circle(data.x,data.y,data.radius);
			}
			
			return null;
		}
		
		public function packObstacle(obstacle:Obstacle):ObstacleData
		{
			var data:ObstacleData = new ObstacleData();
			if(obstacle as Square)
			{
				data.type = "Square";
				data.x = obstacle.x;
				data.y = obstacle.y;
				data.width = obstacle.width;
				data.height = obstacle.height;
			}
			if(obstacle as Circle)
			{
				data.type = "Circle";
				data.x = obstacle.x;
				data.y = obstacle.y;
				data.radius = obstacle.radius;
			}
			return data;
		}
		
		private function spawnGravBall(gravityObjects:Vector.<GravBall>):Vector.<GravBall>
		{
			gravityObjects.push(new GravBall(spawnLocX,spawnLocY));
			dispatchEvent(new ChildEvent(ChildEvent.ADD_CHILD,gravityObjects[gravityObjects.length-1]));
			return gravityObjects;
		}
		
		private function killGravBall(gravityObjects:Vector.<GravBall>):Vector.<GravBall>
		{
			dispatchEvent(new ChildEvent(ChildEvent.REMOVE_CHILD,gravityObjects[0]));
			gravityObjects[0] = null;
			gravityObjects.splice(0,1);
			return gravityObjects;
		}
	}
}