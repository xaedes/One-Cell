package ld28.graphics {
	import flash.display.Shape;
	
	public class CircleView extends Shape implements Redrawable {
		public var _radius:Number;
		public var _color:uint;
		public var _alpha:Number;
		
		public function CircleView(_radius:Number = 10, _color:uint = 0xFFFFFF, _alpha:Number = 1) {
			this._radius = _radius;
			this._color = _color;
			this._alpha = _alpha;
			this.redraw(0);
		}
		
		public function redraw(time:Number):void {
			graphics.clear();
			graphics.beginFill(_color, _alpha);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
	}
}
