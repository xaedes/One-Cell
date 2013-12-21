package ld28 {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class Utils {
		public function Utils() {
		
		}
		
		static public function randomRange(min:Number = 0, max:Number = 1):Number {
			return Math.random() * (max - min) + min;
		}
		
		static public function normalVector(vec:Point):Point {
			return new Point(-vec.y, vec.x);
		}
		
		static public function dot(vec1:Point, vec2:Point):Number {
			return vec1.x * vec2.x + vec1.y * vec2.y;
		}
		
		static public function mult(vec:Point, scalar:Number):Point {
			return new Point(vec.x * scalar, vec.y * scalar);
		}
		
		static public function rectFromCenter(center:Point, width:Number, height:Number):Rectangle {
			return new Rectangle(center.x - width / 2, center.y - height / 2, width, height);
		}
		
		static public function pointAdd(a:Point, b:Point):void {
			a.x += b.x;
			a.y += b.y;
		}
		
		static public function pointSub(a:Point, b:Point):void {
			a.x -= b.x;
			a.y -= b.y;
		}
		
		static public function pointSet(a:Point, b:Point):void {
			a.x = b.x;
			a.y = b.y;
		}
		
		static public function partitionVector(vec:Point, axisNormalised:Point, axisPart:Point, rest:Point):void {
			pointSet(axisPart, mult(axisNormalised, dot(vec, axisNormalised)));
			pointSet(rest, vec.subtract(axisPart));
		}
		
		static public function getKeys(dict:Dictionary):Array {
			var keys:Array = new Array();
			for (var key:Object in dict) {
				keys.push(key);
			}
			return keys;
		}
		
		static public function dictionaryClean(dict:Dictionary):void {
			for (var key:Object in dict) {
				delete dict[key];
			}
		}
	}

}