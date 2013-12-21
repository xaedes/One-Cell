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
		
		public function MembranChain() {
		
		}
		
		static public function join(chain1:MembranChain, chain2:MembranChain):MembranChain {
			var part:Object;
			var joined:MembranChain = new MembranChain();
			var chain:MembranChain = null;
			if (chain1 && chain2) {
				for (part in chain1.partEntities) {
					joined.partEntities[part] = part;
					joined.size++;
				}
				for (part in chain2.partEntities) {
					if (joined.partEntities[part]) {
						joined.circular = true;
						trace("circle");
					} else {
						joined.partEntities[part] = part;
						joined.size++;
					}
				}
			} else if (chain1 || chain2) {
				chain = chain1 ? chain1 : chain2;
				for (part in chain.partEntities) {
					joined.partEntities[part] = part;
					joined.size++;
				}
			}
			for (part in joined.partEntities) {
				chain = MembranChain(part.get(MembranChain));
				if (chain) {
					chain.circular = joined.circular;
					trace("chain", Utils.getKeys(chain.partEntities).length, "joined", Utils.getKeys(joined.partEntities).length, "chain1", Utils.getKeys(chain1.partEntities).length, "chain2", Utils.getKeys(chain2.partEntities).length);
					chain.size = joined.size;
					for (part in joined.partEntities) {
						chain.partEntities[part] = part;
					}
						//chain.partEntities = joined.partEntities;
				} else {
					part.add(joined);
				}
			}
			return joined;
		}
	}

}