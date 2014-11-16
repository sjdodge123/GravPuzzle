package Events
{
	import flash.events.Event;
	
	public class KeyEvent extends Event
	{
		public static const SPACE_PRESSED:String = "space_pressed";
		public static const F12_PRESSED:String = "f12_pressed";
		public static const MOUSE_WHEEL_UP:String = "mouse_wheel_up";
		public static const MOUSE_WHEEL_DOWN:String = "mouse_wheel_down";
		
		public var params:Object;
		public function KeyEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new KeyEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}