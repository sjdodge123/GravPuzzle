package MapEditor.ToolKit
{
	import flash.display.Sprite;
	import flash.text.TextField;


	public class SaveButton extends Sprite
	{
		private var textBox:TextField;
		private var buttonBox:Sprite;
		public function SaveButton(x:int,y:int)
		{
			this.x = x;
			this.y = y;
			
			buttonBox = new Sprite();
			
			buttonBox.graphics.beginFill(0x89E894);
			buttonBox.graphics.drawRect(0,0,100,25);
			buttonBox.graphics.endFill();
			buttonBox.buttonMode = true;
			addChild(buttonBox);
			
			
			textBox = new TextField();
			textBox.x = buttonBox.width/2 - textBox.width/2;
			textBox.text = "Create new Map";
			textBox.selectable = false;
			textBox.alpha = .1
			//buttonBox.addChild(textBox);
		}
	}
}