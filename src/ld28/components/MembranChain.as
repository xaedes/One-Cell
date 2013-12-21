package ld28.components {
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
		
		public function MembranChain(selfEntity:Entity) {
			if (selfEntity != null) {
				partEntities[selfEntity] = selfEntity;
				size++;
			}
		}
	}

}