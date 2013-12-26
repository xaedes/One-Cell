package ld28.components {
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class CircleCircleCollision {
		public var collidingEntities:Dictionary = new Dictionary();
		
		public function CircleCircleCollision() {
		
		}
		
		public function clear():void {
			for (var key:Object in collidingEntities)
				delete collidingEntities[key];
		}
	}

}