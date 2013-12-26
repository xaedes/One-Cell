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
		
		public function Size(size:Point = null, align:int = Size.ALIGN_TOP_LEFT) {
			this.size = size ? size : new Point();
			this.align = align;
		}
		
		public function get alignOffset():Point {
			
			return Size.getAlignOffset(size, align);
		}
		
		static public function getAlignOffset(size:Point, align:int):Point {
			var result:Point = new Point();
			if ((align == ALIGN_TOP_LEFT) || (align == ALIGN_TOP_CENTER) || (align == ALIGN_TOP_RIGHT)) {
				result.y = 0;
			}
			if ((align == ALIGN_CENTER_LEFT) || (align == ALIGN_CENTER_CENTER) || (align == ALIGN_CENTER_RIGHT)) {
				result.y = size.y / 2;
			}
			if ((align == ALIGN_BOTTOM_LEFT) || (align == ALIGN_BOTTOM_CENTER) || (align == ALIGN_BOTTOM_RIGHT)) {
				result.y = size.y;
			}
			if ((align == ALIGN_TOP_LEFT) || (align == ALIGN_CENTER_LEFT) || (align == ALIGN_BOTTOM_LEFT)) {
				result.x = 0;
			}
			if ((align == ALIGN_TOP_CENTER) || (align == ALIGN_CENTER_CENTER) || (align == ALIGN_BOTTOM_CENTER)) {
				result.x = size.x / 2;
			}
			if ((align == ALIGN_TOP_RIGHT) || (align == ALIGN_CENTER_RIGHT) || (align == ALIGN_BOTTOM_RIGHT)) {
				result.x = size.x;
			}
			return result;
		}
	}

}