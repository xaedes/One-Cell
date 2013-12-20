package ld28.components {
	import ld28.easing.Easing;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class AlphaTween {
		public var destination:Number;
		public var time:Number;
		public var start:Number = -1;
		public var ease:Function = null;
		
		public function AlphaTween(destination:Number, time:Number, ease:Function = null) {
			this.destination = destination;
			this.time = time;
			if (ease == null)
				this.ease = Easing.linearTween;
			else
				this.ease = ease;
		}
	
	}

}