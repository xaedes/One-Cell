package ld28.graphics {
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class RectView extends Shape implements Redrawable {
		public var _rect:Rectangle;
		public var _color:uint;
		public var _alpha:Number;
		
		public function RectView(rect:Rectangle = null, _color:uint = 0xFFFFFF, _alpha:Number = 1) {
			this._rect = rect ? rect : new Rectangle();
			this._color = _color;
			this._alpha = _alpha;
			this.redraw(0);
		}
		
		public function redraw(time:Number):void {
			if (_rect) {
				graphics.clear();
				graphics.beginFill(_color, _alpha);
				graphics.drawRect(_rect.x, _rect.y, _rect.width, _rect.height);
				graphics.endFill();
			}
		}
	}

}