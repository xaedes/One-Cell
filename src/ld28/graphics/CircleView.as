package ld28.graphics {
	import flash.display.Shape;
	
	public class CircleView extends Shape implements Redrawable {
		private var _radius:Number;
		private var _color:uint;
		private var _redrawNecessary:Boolean;
		
		public function CircleView(_radius:Number = 10, _color:uint = 0xFFFFFF, _alpha:Number = 1) {
			this.radius = _radius;
			this.color = _color;
			this.alpha = _alpha;
			
			this.redraw(0);
		}
		
		public function get radius():Number {
			return this._radius;
		}
		
		public function set radius(value:Number):void {
			if (this._radius != value)
				this._redrawNecessary = true;
			this._radius = value;
		}
		
		public function get color():uint {
			return this._color;
		}
		
		public function set color(value:uint):void {
			if (this._color != value)
				this._redrawNecessary = true;
			this._color = value;
		}
		
		override public function set alpha(value:Number):void {
			if (this.alpha != value)
				this._redrawNecessary = true;
			super.alpha = value;
		}
		
		public function redraw(time:Number):void {
			if (this._redrawNecessary) {
				graphics.clear();
				graphics.beginFill(_color);
				graphics.drawCircle(0, 0, _radius);
				graphics.endFill();
			}
		}
	}
}
