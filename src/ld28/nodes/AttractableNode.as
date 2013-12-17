package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Attractable;
	import ld28.components.Motion;
	import ld28.components.Position;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class AttractableNode extends Node {
		public var attractable:Attractable;
		public var position:Position;
		public var motion:Motion;
	}

}