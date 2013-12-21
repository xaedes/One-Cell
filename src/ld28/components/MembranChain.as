package ld28.components {
	import ash.core.Engine;
	import ash.core.Entity;
	import flash.utils.Dictionary;
	import ld28.Utils;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class MembranChain {
		public var _size:int = 0;
		public var circular:Boolean = false;
		public var partEntities:Dictionary = new Dictionary();
		
		public var containedEntities:Dictionary = new Dictionary();
		
		public function MembranChain() {
		}
		
		public function get size():int {
			return _size;
		}
		
		public function addPart(part:Entity):void {
			partEntities[part] = part;
			_size++;
		}
		
		public function removePart(part:Entity):void {
			if (partEntities[part]) {
				delete partEntities[part];
				_size--;
			}
		}
	}

}