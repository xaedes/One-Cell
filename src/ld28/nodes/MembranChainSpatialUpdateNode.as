package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Display;
	import ld28.components.MembranChain;
	import ld28.components.MembranChainSpatialUpdate;
	import ld28.components.Position;
	import ld28.components.Size;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class MembranChainSpatialUpdateNode extends Node {
		public var membranChainSpatialUpdate:MembranChainSpatialUpdate;
		public var membranChain:MembranChain;
		public var position:Position;
		public var size:Size;
		public var display:Display;
	
	}

}