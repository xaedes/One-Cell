package ld28.graphics {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import ld28.components.Text;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class TextView extends Sprite implements Redrawable {
		public var textField:TextField;
		private var text:Text;
		
		public function TextView(text:Text) {
			textField = createTextField();
			textField.x = 0;
			textField.y = 0;
			//textField.text
			addChild(textField);
			this.text = text;
		}
		
		public function redraw(time:Number):void {
			textField.text = text.text;
		}
		
		private function createTextField():TextField {
			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.color = 0xFFFFFF;
			//format.color = 0xFF0000;
			format.font = "Helvetica";
			format.size = 18;
			tf.defaultTextFormat = format;
			tf.selectable = false;
			//tf.width = 120;
			tf.autoSize = TextFieldAutoSize.CENTER;
			return tf;
		}
	}

}