package ld28.components {
	import ash.core.Entity;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class CanBeContainedInMembranChains {
		public var membranChainEntities:Dictionary = new Dictionary();
		private var _size:int = 0;
		
		public function CanBeContainedInMembranChains() {
		
		}
		
		public function get size():int {
			return _size;
		}
		
		public function addMembranChain(membranChain:Entity):void {
			membranChainEntities[membranChain] = membranChain;
			_size++;
		}
		
		public function removeMembranChain(membranChain:Entity):void {
			if (membranChainEntities[membranChain]) {
				delete membranChainEntities[membranChain];
				_size--;
			}
		}
	}

}