package Events
{
	import flash.events.Event;

	public class ObstacleEvent extends Event
	{
		public static const DEADZONE:String = "DEADZONE";
	
		public var params:Object;
		public function ObstacleEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ObstacleEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}