package ld28.components {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class Size {
		public var size:Point;
		
		public var align:int; //enum ALIGN ; determines how Position is aligned
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
		
		public function Size(size:Point, align:int = Size.ALIGN_TOP_LEFT) {
			this.size = size;
			this.align = align;
		}
	
	}

}