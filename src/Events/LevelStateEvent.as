package Events
{
	import flash.events.Event;
	
	public class LevelStateEvent extends Event
	{
		public static const WIN_LEVEL:String = "win_level";
		public static const LOSE_LEVEL:String = "lose_level";
		public var params:Object;
		public function LevelStateEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new LevelStateEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}