package ld28.components {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class Display {
		public var displayObject:DisplayObject = null;
		public var z:int;
		public var container:DisplayObjectContainer = null;
		
		public function Display(displayObject:DisplayObject, z:int = 0) {
			this.displayObject = displayObject;
			this.z = z;
		}
	}
}
