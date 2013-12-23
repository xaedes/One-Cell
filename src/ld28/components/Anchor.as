package ld28.components {
	import ash.core.Entity;
	import flash.geom.Point;
	
	public class Anchor {
		public var entity:Entity;
		public var offset:Point;
		
		public function Anchor(entity:Entity, offset:Point = null) {
			this.entity = entity;
			this.offset = offset ? offset : new Point();
		}
	
	}

}