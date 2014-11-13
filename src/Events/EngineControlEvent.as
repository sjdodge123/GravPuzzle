package Events
{
	import flash.events.Event;
	
	public class EngineControlEvent extends Event
	{
		public static const PAUSE_ENGINE:String = "pause_engine";
		public static const RESUME_ENGINE:String = "resume_engine";
		public var params:Object;
		public function EngineControlEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new EngineControlEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}