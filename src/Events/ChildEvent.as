package Events
{
	import flash.events.Event;
	
	public class ChildEvent extends Event
	{
		public static const ADD_CHILD:String = "add_child";
		public static const REMOVE_CHILD:String = "remove_child";
		public var params:Object;
		public function ChildEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ChildEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}