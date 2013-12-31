package ld28.nodes {
	import ash.core.Node;
	import ld28.components.MembranChain;
	import ld28.components.MembranChainOrderedEntities;
	import ld28.components.MembranChainUpdateOrderedEntities;
	
	public class MembranChainOrderedEntitiesNode extends Node {
		public var updateOrderedEntities:MembranChainUpdateOrderedEntities;
		public var orderedEntities:MembranChainOrderedEntities;
		public var membranChain:MembranChain;
	}

}