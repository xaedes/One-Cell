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
		
		public function TextView(_text:String = "") {
			textField = createTextField();
			textField.x = 0;
			textField.y = 0;
			addChild(textField);
			text = _text;
		}
		
		public function redraw(time:Number):void {
		
		}
		
		public function set text(value:String):void {
			this.textField.text = value;
		}
		
		public function get text():String {
			return this.textField.text;
		}
		
		private function createTextField():TextField {
			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			//format.bold = true;
			format.color = 0xFFFFFF;
			format.font = "Helvetica";
			format.size = 18;
			tf.defaultTextFormat = format;
			tf.selectable = false;
			
			tf.autoSize = TextFieldAutoSize.CENTER;
			return tf;
		}
	}

}