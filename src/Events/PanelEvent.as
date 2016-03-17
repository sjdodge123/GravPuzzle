package Events
{
	import flash.events.Event;
	
	public class PanelEvent extends Event
	{
		public static const UP_LEVEL:String = "UP_LEVEL";
		public static const DOWN_LEVEL:String = "DOWN_LEVEL";
		public static const CREATE_LEVEL:String = "CREATE_LEVEL";
		
		public var params:Object;
		public function PanelEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new PanelEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}