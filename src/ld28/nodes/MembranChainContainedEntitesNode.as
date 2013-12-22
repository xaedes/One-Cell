package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Collision;
	import ld28.components.MembranChain;
	import ld28.components.MembranChainOrderedEntities;
	
	public class MembranChainContainedEntitesNode extends Node {
		
		public var membranChain:MembranChain;
		public var membranChainOrderedEntities:MembranChainOrderedEntities;
		public var collision:Collision;
	
	}

}