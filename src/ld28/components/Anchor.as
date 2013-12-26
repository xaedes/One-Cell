package ld28.components {
	import ash.core.Entity;
	import flash.geom.Point;
	
	public class Anchor {
		public var entity:Entity;
		public var offset:Point;
		
		public var align:int; //enum ALIGN ; determines which point is anchored (it will be to the same aligned point in the entity anchored)
		//enum ALIGN
		static public const ALIGN_TOP_LEFT:int = 0;
		static public const ALIGN_TOP_CENTER:int = 1;
		static public const ALIGN_TOP_RIGHT:int = 2;
		static public const ALIGN_CENTER_LEFT:int = 3;
		static public const ALIGN_CENTER_CENTER:int = 4;
		static public const ALIGN_CENTER_RIGHT:int = 5;
		static public const ALIGN_BOTTOM_LEFT:int = 6;
		static public const ALIGN_BOTTOM_CENTER:int = 7;
		static public const ALIGN_BOTTOM_RIGHT:int = 8;
		
		public function Anchor(entity:Entity, offset:Point = null, align:int = ALIGN_CENTER_CENTER) {
			this.entity = entity;
			this.offset = offset ? offset : new Point();
			this.align = align;
		}
	
	}

}