package MapEditor.LevelCreation.LevelRead
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader extends URLLoader
	{
		private var myXML:XML = new XML(); 
		private var XML_URL:String;
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader ;
		public function XMLLoader(url:String)
		{
			XML_URL = url;
			myXMLURL = new URLRequest(XML_URL);
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		protected function xmlLoaded(event:Event):void
		{
			myXML = XML(myLoader.data);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getData():XML
		{
			return myXML;
		}
	}
}