package ld28.graphics {
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LabeledCircleView extends Sprite implements Redrawable {
		public var textView:TextView;
		public var circleView:CircleView;
		
		public function LabeledCircleView(text:String = "", _radius:Number = 10, _color:uint = 0xFFFFFF, _alpha:Number = 1) {
			super();
			this.textView = new TextView(text);
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			this.textView.textField.defaultTextFormat = format;
			this.textView.textField.autoSize = TextFieldAutoSize.LEFT;
			
			this.circleView = new CircleView(_radius, _color, 0.1);
			this.alpha = _alpha;
			this.addChild(this.textView);
			this.addChild(this.circleView);
		}
		
		public function set text(value:String):void {
			this.textView.text = value;
		}
		
		public function get text():String {
			return this.textView.text;
		}
		
		public function get radius():Number {
			return this.circleView.radius;
		}
		
		public function set radius(value:Number):void {
			this.circleView.radius = value;
		}
		
		public function get color():uint {
			return this.circleView.color;
		}
		
		public function set color(value:uint):void {
			this.circleView.color = value;
		}
		
		public function redraw(time:Number):void {
			this.circleView.redraw(time);
		
		}
	
	}

}