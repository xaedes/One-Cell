package ld28.components {
	import flash.geom.Point;
	import ld28.easing.Easing;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class PositionTween {
		
		public var destination:Point;
		public var time:Number;
		public var start:Point = null;
		public var current:Point = null;
		public var ease:Function = null;
		
		public function PositionTween(destination:Point, time:Number, ease:Function = null) {
			this.destination = destination;
			this.time = time;
			if (ease == null)
				this.ease = Easing.linearTween;
			else
				this.ease = ease;
		}
	
	}

}