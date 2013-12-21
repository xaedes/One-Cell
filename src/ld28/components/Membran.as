package ld28.components {
	import ash.core.Entity;
	import flash.utils.Dictionary;
	import ld28.Utils;
	
	public class Membran {
		public var connections:Vector.<Entity> = new Vector.<Entity>();
		public var straigthener:Entity = null;
		public var connected:Dictionary = new Dictionary();
		
		public var chain:Entity; //chain.has(MembranChain)
		
		public function Membran(chain:Entity) {
			this.chain = chain;
		}
	
	}

}

