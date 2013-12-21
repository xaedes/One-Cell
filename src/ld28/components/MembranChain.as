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
		public var size:Number = 0;
		public var circular:Boolean = false;
		public var partEntities:Dictionary = new Dictionary();
		
		public function MembranChain() {
		}
		
		public function addPart(part:Entity):void {
			partEntities[part] = part;
			size++;
		}
		
		public function removePart(part:Entity):void {
			if (partEntities[part]) {
				delete partEntities[part];
				size--;
			}
		}
	}

}