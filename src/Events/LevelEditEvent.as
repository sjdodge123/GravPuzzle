package Events
{
	import flash.events.Event;
	
	public class LevelEditEvent extends Event
	{
		public static const GRAB_CENTER:String = "GRAB_CENTER";
		public static const GRAB_X:String = "GRAB_X";
		public static const GRAB_Y:String = "GRAB_Y";
		public static const GRAB_RADIUS:String = "GRAB_RADIUS";
		
		public var params:Object;
		public function LevelEditEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new LevelEditEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}