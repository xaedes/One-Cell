package ld28.nodes {
	import ash.core.Node;
	import ld28.components.Attractor;
	import ld28.components.Circle;
	import ld28.components.Collision;
	import ld28.components.Position;
	
	/**
	 * ...
	 * @author xaedes
	 */
	public class AttractorNode extends Node {
		public var attractor:Attractor;
		public var position:Position;
		public var collision:Collision;
		public var circle:Circle;
	}

}