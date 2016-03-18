package Construct
{
	import flash.events.EventDispatcher;
	
	import Events.ChildEvent;
	
	import GameObjects.Mobile.GravBall;
	import GameObjects.Mobile.Obstacles.Circle;
	import GameObjects.Mobile.Obstacles.Obstacle;
	import GameObjects.Mobile.Obstacles.Square;
	import GameObjects.Mobile.Obstacles.Zones.BlackZone;
	import GameObjects.Mobile.Obstacles.Zones.DeadZone;
	
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
				var radius:Number = gravityObjects[i].getRadius()*3;
				if(distance > radius)
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
			if(data.type == "DeadZone")
			{
				return new DeadZone(data.x,data.y,data.width,data.height);
			}
			if(data.type == "BlackZone")
			{
				return new BlackZone(data.x,data.y,data.width,data.height);
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
				data.radius = obstacle.getRadius();
			}
			if(obstacle as DeadZone)
			{
				data.type = "DeadZone";
				data.x = obstacle.x;
				data.y = obstacle.y;
				data.width = obstacle.width;
				data.height = obstacle.height;
			}
			if(obstacle as BlackZone)
			{
				data.type = "BlackZone";
				data.x = obstacle.x;
				data.y = obstacle.y;
				data.width = obstacle.width;
				data.height = obstacle.height;
			}
			return data;
		}
		
		private function spawnGravBall(gravityObjects:Vector.<GravBall>):Vector.<GravBall>
		{
			var gravBall:GravBall = new GravBall(spawnLocX,spawnLocY);
			gravityObjects.push(gravBall);
			dispatchEvent(new ChildEvent(ChildEvent.ADD_CHILD,gravBall));
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