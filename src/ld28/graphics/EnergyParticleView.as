package ld28.graphics {
	import ash.core.Entity;
	import flash.display.Shape;
	import flash.geom.Point;
	import ld28.components.Circle;
	import ld28.components.Lifetime;
	import ld28.components.Timer;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class EnergyParticleView extends Shape implements Redrawable {
		public var _alpha:Number
		public var _color:uint
		public var _radius:Number
		public var entity:Entity
		private var timer:Timer;
		private var lifetime:Lifetime;
		private var circle:Circle;
		
		public function EnergyParticleView(entity:Entity) {
			this.entity = entity;
			this.circle = entity.get(Circle);
			this.timer = entity.get(Timer);
			this.lifetime = entity.get(Lifetime);
			this._color = 0xFFF4BA;
			redraw(0);
		}
		
		public function redraw(time:Number):void {
			if (!this.circle) {
				this.circle = entity.get(Circle);
			}
			this._radius = circle ? circle.radius : 2;
			
			if (!this.timer) {
				this.timer = entity.get(Timer);
			}
			if (!this.lifetime) {
				this.lifetime = entity.get(Lifetime);
			}
			if (this.timer && this.lifetime) {
				_alpha = 1 - (this.timer.seconds / this.lifetime.lifetime);
				if (_alpha < 0)
					_alpha = 0;
			} else {
				_alpha = 1;
			}
			graphics.clear();
			graphics.beginFill(_color, _alpha);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
	
	}

}